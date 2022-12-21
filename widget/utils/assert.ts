export class AssertionError extends Error {
  constructor(message?: string) {
    super(message);
    this.name = this.constructor.name;
  }
}

export function assert(expr: boolean, message = "Assertion failed") {
  if (!expr) throw new AssertionError(message);
}
