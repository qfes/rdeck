export function observable<T extends object>(object: T, observer?: (info: Partial<T>) => void): T {
  const onSet = (property: keyof T, value: T[typeof property]) =>
    // @ts-ignore
    observer?.({ [property]: value });

  const defineProperty = (target: T, property: keyof T, { value }: PropertyDescriptor) =>
    Reflect.defineProperty(target, property, {
      enumerable: true,
      configurable: false,
      get() {
        return value;
      },
      set(newValue) {
        if (Object.is(newValue, value)) return;
        value = newValue;
        onSet(property, newValue);
      },
    });

  const defineSet = (target: T, property: keyof T, descriptor: PropertyDescriptor) =>
    Reflect.defineProperty(target, property, {
      ...descriptor,
      enumerable: true,
      configurable: false,
      set(newValue) {
        const value = descriptor.get?.call(target);
        if (Object.is(newValue, value)) return;
        descriptor.set?.call(target, newValue);
        onSet(property, newValue);
      },
    });

  const getDescriptors = <T>(ob: T) =>
    Object.entries(Object.getOwnPropertyDescriptors(ob)) as [keyof T, PropertyDescriptor][];

  // replace all writable properties with get() & set()
  for (const [property, descriptor] of getDescriptors(object)) {
    if (descriptor.configurable && descriptor.writable) {
      defineProperty(object, property, descriptor);
    }
  }

  // wrap all setters on prototype
  for (const [property, descriptor] of getDescriptors(Object.getPrototypeOf(object))) {
    if (typeof descriptor.set === "function") {
      // @ts-ignore
      defineSet(object, property, descriptor);
    }
  }

  return object;
}

export type ChangeHandler = () => void;

export interface Observable {
  onChange?: ChangeHandler;
}
