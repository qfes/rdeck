import { FeatureCollection } from "geojson";
import { AppProps } from "../app";

declare global {
  type RDeckProps = Omit<AppProps, "height" | "width">;

  type Bounds = [number, number, number, number];
  type Color = [number, number, number, number];
  type DataType = "table" | "object" | "geojson";
  type BlendingMode = "normal" | "additive" | "subtractive";

  interface DataFrame {
    length: number;
    geometry: Record<string, GeometryType>;
    indices?: number[];
    frame: Record<string, any[]>;
  }

  type GeometryType =
    | "POINT"
    | "LINESTRING"
    | "POLYGON"
    | "MULTIPOINT"
    | "MULTILINESTRING"
    | "MULTIPOLYGON";

  type LayerData = DataFrame | Record<string, any> | FeatureCollection | string | null;

  interface TooltipInfo {
    type: "tooltip";
    cols: true | string[];
    dataType: DataType;
  }
}
