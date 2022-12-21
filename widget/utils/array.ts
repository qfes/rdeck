import { assert } from "./assert";

export function sum(values: number[]): number {
  return values.reduce((total, current) => total + current, 0);
}

export function replicate<T>(fn: (index: number) => T, times: number[]): T[] {
  const result = new Array(sum(times));

  for (let i = 0, s = 0; i < times.length; s += times[i], ++i) {
    result.fill(fn(i), s, s + times[i]);
  }

  return result;
}

export function decodeRle<T>(values: T[], lengths: number[]): T[] {
  assert(values.length === lengths.length);
  return replicate((i) => values[i], lengths);
}
