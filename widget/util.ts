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

export function debounce<T extends (...args: any[]) => any>(fn: T, wait: number = 0) {
  let timeout: number;

  return (...args: any[]) => {
    window.clearTimeout(timeout);
    timeout = window.setTimeout(() => fn(...args), wait);
  };
}
