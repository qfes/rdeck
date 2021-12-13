export function properCase(camelCase: string) {
  return camelCase.replace(/([A-Z])/g, " $1").replace(/^./, (s) => s.toUpperCase());
}

export function words(camelCase: string) {
  return camelCase.replace(/([A-Z])/g, " $1").toLowerCase();
}

function getFirstVisible(el: HTMLElement): Element | null {
  if (el.clientHeight > 0 && el.clientHeight > 0) {
    return el;
  }

  return el.parentElement ? getFirstVisible(el.parentElement) : null;
}

export function getElementDimensions(el: HTMLElement): [number, number] {
  const visible = getFirstVisible(el);

  if (el === visible || visible == null) {
    return [el.clientWidth, el.clientHeight];
  }

  const { width, height } = getComputedStyle(el);
  const node = document.createElement("div");
  Object.assign(node.style, {
    width,
    height,
    display: "hidden",
  });

  visible.appendChild(node);
  const dims: [number, number] = [node.clientWidth, node.clientHeight];
  visible.removeChild(node);

  return dims;
}

export function groupBy<K, V>(list: V[], key: (x: V) => K): Map<K, V[]> {
  const map = new Map<K, V[]>();

  for (const item of list) {
    const itemKey = key(item);
    if (!map.has(itemKey)) {
      map.set(itemKey, [item]);
    } else {
      map.get(itemKey)!.push(item);
    }
  }

  return map;
}

type Nullable<T> = T | null;

export function classNames(...classNames: Nullable<string>[]): string {
  return classNames.filter((x) => x != null).join(" ");
}

type Variadic<T> = (...args: any[]) => T;

export function debounce<T>(fn: Variadic<T>, wait: number = 0) {
  let timeout: number;

  return (...args: any[]) => {
    window.clearTimeout(timeout);
    timeout = window.setTimeout(() => fn(...args), wait);
  };
}

function isPrimitive(x: any) {
  return (typeof x !== "object" || x === null) && typeof x !== "function";
}

class MapCache {
  private _val = new Map();
  private _ref = new WeakMap();

  getStore(key: any) {
    return isPrimitive(key) ? this._val : this._ref;
  }

  has(key: any) {
    return this.getStore(key).has(key);
  }

  get(key: any) {
    return this.getStore(key).get(key);
  }

  set(key: any, value: unknown) {
    this.getStore(key).set(key, value);
    return this;
  }
}

export function memoize<T>(fn: Variadic<T>): Variadic<T> {
  // a nested cache chain, such that each param maps to a cache,
  // or the result of fn if it is the end of the chain
  // e.g. for 3 args, (a) => (b) => (c) => fn(a, b, c)
  const root = new MapCache();

  return (...args: any[]): T => {
    const arg0 = args[0];
    const nargs = args.slice(0, -1);
    // walk the cache chain
    const cache = nargs.reduceRight((parent: MapCache, arg: any) => {
      if (parent.has(arg)) return parent.get(arg);

      const child = new MapCache();
      parent.set(arg, child);
      return child;
    }, root);

    // cache hit
    if (cache.has(arg0)) {
      return cache.get(arg0);
    }

    // cache miss
    const value = fn(...args);
    cache.set(arg0, value);

    return value;
  };
}
