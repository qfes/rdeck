import type { Color } from "./types";

const DEFAULT_COLOR: Color = [0, 0, 0, 255];

export function isColorProp(name: string) {
  return name.endsWith("Color");
}

export function rgba([r, g, b, a = 255]: Color) {
  return `rgba(${r}, ${g}, ${b}, ${a / 255})`;
}

// https://github.com/uber/deck.gl/blob/master/modules/core/src/utils/color.js
export function parseColor(color: string | Color, target?: Color): Color {
  if (Array.isArray(color)) {
    if (!target && color.length === 4) {
      return color;
    }

    // @ts-ignore
    target = target ?? ([] as Color);
    target[0] = color[0];
    target[1] = color[1];
    target[2] = color[2];
    // @ts-ignore
    target[3] = color.length === 3 ? color[3] : 255;
    return target;
  }

  if (typeof color === "string") {
    // @ts-ignore
    target = target ?? ([] as Color);
    parseHexColor(color, target);
    return target;
  }

  return DEFAULT_COLOR;
}

// Parse a hex color
function parseHexColor(color: string, target: Color) {
  if (color.length === 7) {
    const value = parseInt(color.substring(1), 16);
    target[0] = Math.floor(value / 65536);
    target[1] = Math.floor((value / 256) % 256);
    target[2] = value % 256;
    target[3] = 255;
  } else if (color.length === 9) {
    const value = parseInt(color.substring(1), 16);
    target[0] = Math.floor(value / 16777216);
    target[1] = Math.floor((value / 65536) % 256);
    target[2] = Math.floor((value / 256) % 256);
    target[3] = value % 256;
  }
}
