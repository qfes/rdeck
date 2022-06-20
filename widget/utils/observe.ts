export function observable<T extends object>(object: T, observer?: SetHandler<Partial<T>>): T {
  // replace all writable properties with get() & set()
  const ownDescriptors = getDescriptors(object);
  for (const [property, descriptor] of ownDescriptors) {
    if (!descriptor.configurable) continue;

    if (descriptor.writable) {
      defineAccessor(object, property, descriptor, observer);
    } else if (typeof descriptor.set === "function") {
      wrapSetter(object, property, descriptor, observer);
    }
  }

  // is this a custom object?
  if (Object.getPrototypeOf({}) === Object.getPrototypeOf(object)) return object;

  const prototypeDescriptors = getDescriptors(Object.getPrototypeOf(object));
  // wrap all setters on prototype
  for (const [property, descriptor] of prototypeDescriptors) {
    if (descriptor.configurable && typeof descriptor.set === "function") {
      wrapSetter(object, property as keyof T, descriptor, observer);
    }
  }

  return object;
}

export type ChangeHandler = () => void;

export interface Observable {
  onChange?: ChangeHandler;
}

type DescriptorEntry<T> = [keyof T, PropertyDescriptor];
function getDescriptors<T extends object>(object: T): DescriptorEntry<T>[] {
  return Object.entries(Object.getOwnPropertyDescriptors(object)) as DescriptorEntry<T>[];
}

type SetHandler<T> = (info: T) => void;

function defineAccessor<T extends object, K extends keyof T>(
  target: T,
  property: K,
  { value }: TypedPropertyDescriptor<T[K]>,
  onSet?: SetHandler<Pick<T, K>>
) {
  return Reflect.defineProperty(target, property, {
    get(): T[K] {
      // @ts-ignore
      return value;
    },
    set(newValue: T[K]) {
      if (Object.is(newValue, value)) return;
      value = newValue;
      onSet?.({ [property]: newValue } as Pick<T, K>);
    },
  });
}

function wrapSetter<T extends object, K extends keyof T>(
  target: T,
  property: K,
  descriptor: TypedPropertyDescriptor<T[K]>,
  onSet?: SetHandler<Pick<T, K>>
) {
  return Reflect.defineProperty(target, property, {
    ...descriptor,
    set(newValue: T[K]) {
      const value = descriptor.get?.call(target);
      if (Object.is(newValue, value)) return;
      descriptor.set?.call(target, newValue);
      onSet?.({ [property]: newValue } as Pick<T, K>);
    },
  });
}
