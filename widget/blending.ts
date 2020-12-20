import { default as GL } from "@luma.gl/constants";

export function blendingParameters(mode: BlendingMode = "normal") {
  switch (mode) {
    case "additive":
      return {
        [GL.BLEND]: true,
        blendFunc: [GL.SRC_ALPHA, GL.DST_ALPHA],
        blendEquation: GL.FUNC_ADD,
      };
    case "subtractive":
      return {
        [GL.BLEND]: true,
        blendFunc: [GL.ONE, GL.ONE_MINUS_DST_COLOR, GL.SRC_ALPHA, GL.DST_ALPHA],
        blendEquation: [GL.FUNC_SUBTRACT, GL.FUNC_ADD],
      };
    case "normal":
    default:
      return {
        [GL.BLEND]: true,
        blendFunc: [GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA, GL.ONE, GL.ONE_MINUS_SRC_ALPHA],
        blendEquation: [GL.FUNC_ADD, GL.FUNC_ADD],
      };
  }
}
