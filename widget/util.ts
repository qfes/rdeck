export function isObject(value: any) {
  return value != null && typeof value === "object" && !Array.isArray(value);
}

export function properCase(camelCase: string) {
  return camelCase.replace(/([A-Z])/g, " $1").replace(/^./, (s) => s.toUpperCase());
}

export function words(camelCase: string) {
  return camelCase.replace(/([A-Z])/g, " $1").toLowerCase();
}

export type Color = [number, number, number, number];

export function rgba([r, g, b, a = 255]: Color) {
  return `rgba(${r}, ${g}, ${b}, ${a / 255})`;
}

// https://github.com/uber/deck.gl/blob/master/modules/core/src/utils/color.js
export function parseColor(color: string | number[], target?: Color, index = 0): Color {
  if (Array.isArray(color) || ArrayBuffer.isView(color)) {
    if (!target && color.length === 4) {
      return color;
    }

    target = target || [];
    target[index + 0] = color[0];
    target[index + 1] = color[1];
    target[index + 2] = color[2];
    target[index + 3] = color.length === 4 ? color[3] : 255;
    return target;
  }

  if (typeof color === "string") {
    target = target || [];
    parseHexColor(color, target, index);
    return target;
  }

  return [0, 0, 0, 255];
}

// Parse a hex color
function parseHexColor(color: string, target: Color, index: number) {
  if (color.length === 7) {
    const value = parseInt(color.substring(1), 16);
    target[index + 0] = Math.floor(value / 65536);
    target[index + 1] = Math.floor((value / 256) % 256);
    target[index + 2] = value % 256;
    target[index + 3] = 255;
  } else if (color.length === 9) {
    const value = parseInt(color.substring(1), 16);
    target[index + 0] = Math.floor(value / 16777216);
    target[index + 1] = Math.floor((value / 65536) % 256);
    target[index + 2] = Math.floor((value / 256) % 256);
    target[index + 3] = value % 256;
  }
  return index + 4;
}
