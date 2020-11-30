declare module "*.css";

type Bounds = [[number, number], [number, number]];

interface DataFrame {
  length: number;
  frame: Record<string, any[]>;
}

type DataType = "table" | "object" | "geojson";

interface TooltipInfo {
  type: "tooltip";
  cols: string[];
  dataType: DataType;
}
