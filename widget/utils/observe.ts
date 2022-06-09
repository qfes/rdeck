export function observable<T extends object>(object: T, observer?: (info: Partial<T>) => void): T {
  function defineProperty(target: T, property: keyof T, { value }: PropertyDescriptor) {
    return Reflect.defineProperty(target, property, {
      enumerable: true,
      get() {
        return value;
      },
      set(newValue) {
        if (Object.is(newValue, value)) return;
        value = newValue;
        observer?.({ [property]: newValue } as Pick<T, typeof property>);
      },
    });
  }

  // Reflect.ownKeys has overly broad return type
  const descriptors = Object.entries(Object.getOwnPropertyDescriptors(object)) as Array<
    [keyof T, PropertyDescriptor]
  >;

  for (const [property, descriptor] of descriptors) {
    if (descriptor.configurable && descriptor.writable) {
      defineProperty(object, property, descriptor);
    }
  }

  return object;
}

export type ChangeHandler = () => void;

export interface Observable {
  onChange?: ChangeHandler;
}
