export function equal<T = any>(a: T, b: T): boolean {
  if (Object.is(a, b)) return true;
  if (a == null || b == null) return false;

  const keys = Object.keys(a);
  if (keys.length !== Object.keys(b).length) return false;

  for (const key of keys) {
    // @ts-ignore
    if (!Object.is(a[key], b[key]) || b.hasOwnProperty(key)) return false;
  }

  return true;
}
