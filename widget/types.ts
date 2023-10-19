export type BlendingMode = "normal" | "additive" | "subtractive";
export type Color = [number, number, number] | [number, number, number, number];
export type Bounds = [number, number, number, number];
export type EditorMode =
  | "view"
  | "select"
  | "modify"
  | "transform"
  | "point"
  | "linestring"
  | "polygon"
  | "lasso";

export type TooltipInfo = {
  type: "tooltip";
  cols: true | string[];
}
