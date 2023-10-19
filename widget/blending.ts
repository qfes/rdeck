import { default as GL } from "@luma.gl/constants";
import type { BlendingMode } from "./types";

const BLENDING_MODES = Object.freeze({
  additive: {
    [GL.BLEND]: true,
    blendFunc: [GL.SRC_ALPHA, GL.DST_ALPHA],
    blendEquation: GL.FUNC_ADD,
  },
  subtractive: {
    [GL.BLEND]: true,
    blendFunc: [GL.ONE, GL.ONE_MINUS_DST_COLOR, GL.SRC_ALPHA, GL.DST_ALPHA],
    blendEquation: [GL.FUNC_SUBTRACT, GL.FUNC_ADD],
  },
  normal: {
    [GL.BLEND]: true,
    blendFunc: [GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA, GL.ONE, GL.ONE_MINUS_SRC_ALPHA],
    blendEquation: [GL.FUNC_ADD, GL.FUNC_ADD],
  },
});

export function blendingParameters(mode: BlendingMode = "normal") {
  return BLENDING_MODES[mode] ?? BLENDING_MODES.normal;
}
