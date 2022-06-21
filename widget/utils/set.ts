export function isSubset<T>(subset: Set<T>, superset: Set<T>): boolean {
  for (const element of subset) {
    if (!superset.has(element)) return false;
  }

  return true;
}

export function isSuperset<T>(superset: Set<T>, subset: Set<T>): boolean {
  for (const element of subset) {
    if (!superset.has(element)) return false;
  }

  return true;
}

export function union<T>(...sets: Set<T>[]): Set<T> {
  return new Set(sets.flatMap((x) => [...x]));
}

export function difference<T>(...sets: Set<T>[]): Set<T> {
  const diff = new Set(sets[0]);

  for (const set of sets.slice(1)) {
    for (const element of set) {
      diff.delete(element);
    }
  }

  return diff;
}
