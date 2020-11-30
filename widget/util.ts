export function isObject(value: any) {
  return value != null && typeof value === "object" && !Array.isArray(value);
}

export function properCase(camelCase: string) {
  return camelCase.replace(/([A-Z])/g, " $1").replace(/^./, (s) => s.toUpperCase());
}

export function words(camelCase: string) {
  return camelCase.replace(/([A-Z])/g, " $1").toLowerCase();
}
