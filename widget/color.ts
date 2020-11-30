export function rgba([r, g, b, a = 255]: Color) {
  return `rgba(${r}, ${g}, ${b}, ${a / 255})`;
}

// https://github.com/uber/deck.gl/blob/master/modules/core/src/utils/color.js
export function parseColor(color?: string | Color): Color {
  if (Array.isArray(color)) {
    return color.length === 4 ? color : [color[0], color[1], color[2], 255];
  }

  if (typeof color === "string") {
    return parseHexColor(color);
  }

  return [0, 0, 0, 255];
}

// Parse a hex color
function parseHexColor(color: string): Color {
  if (color.length === 7) {
    const value = parseInt(color.substring(1), 16);
    return [Math.floor(value / 65536), Math.floor((value / 256) % 256), value % 256, 255];
  } else if (color.length === 9) {
    const value = parseInt(color.substring(1), 16);
    return [
      Math.floor(value / 16777216),
      Math.floor((value / 65536) % 256),
      Math.floor((value / 256) % 256),
      value % 256,
    ];
  }
  return [0, 0, 0, 255];
}
