import {
  scaleLinear,
  ScaleLinear,
  scaleLog,
  ScaleLogarithmic,
  scaleOrdinal,
  ScaleOrdinal,
  scalePow,
  ScalePower,
  scaleQuantize,
  ScaleQuantize,
  ScaleThreshold,
  scaleThreshold,
  ScaleSymLog,
  scaleSymlog,
} from "d3-scale";
import type { PickInfo, AccessorFn } from "@deck.gl/core";
import type { Feature } from "geojson";
import { Accessor, isAccessor } from "./accessor";
import { parseColor } from "./color";

type ScaleFn = (data: any) => number | Color;

type AccessorScaleBase<Range> = Accessor & {
  name: string;
  domain: number[];
  range: Range[];
  palette?: Color[];
  unknown: Range;
  legend: boolean;
  ticks: string[];
  scaleBy?: string;
};

export type AccessorScaleLinear<Range> = AccessorScaleBase<Range> & {
  scale: "linear";
  scaleData: ScaleLinear<Range, Range>;
};

export type AccessorScalePower<Range> = AccessorScaleBase<Range> & {
  scale: "power";
  exponent: number;
  scaleData: ScalePower<Range, Range>;
};

export type AccessorScaleLog<Range> = AccessorScaleBase<Range> & {
  scale: "log";
  base: number;
  scaleData: ScaleLogarithmic<Range, Range>;
};

export type AccessorScaleSymlog<Range> = AccessorScaleBase<Range> & {
  scale: "symlog";
  scaleData: ScaleSymLog<Range, Range>;
};

export type AccessorScaleThreshold<Range> = AccessorScaleBase<Range> & {
  scale: "threshold";
  scaleData: ScaleThreshold<number, Range>;
};

export type AccessorScaleQuantile<Range> = AccessorScaleBase<Range> & {
  scale: "quantile";
  scaleData: ScaleThreshold<number, Range>;
};

export type AccessorScaleCategory<Range> = AccessorScaleBase<Range> & {
  scale: "category";
  domain: string[];
  unknownTick: string | null;
  scaleData: ScaleOrdinal<string, Range>;
};

export type AccessorScaleQuantize<Range> = AccessorScaleBase<Range> & {
  scale: "quantize";
  domain: [number, number];
  scaleData: ScaleQuantize<Range>;
};

export type AccessorScaleContinuous<Range> =
  | AccessorScaleLinear<Range>
  | AccessorScalePower<Range>
  | AccessorScaleLog<Range>
  | AccessorScaleSymlog<Range>;
export type AccessorScaleDiscrete<Range> =
  | AccessorScaleThreshold<Range>
  | AccessorScaleQuantile<Range>
  | AccessorScaleQuantize<Range>;
export type AccessorScale<Range> =
  | AccessorScaleContinuous<Range>
  | AccessorScaleDiscrete<Range>
  | AccessorScaleCategory<Range>;

export function isAccessorScale(obj: any): obj is AccessorScale<number | Color> {
  return isAccessor(obj) && "scale" in obj;
}

export function isColorScale(obj: AccessorScale<number | Color>): obj is AccessorScale<Color> {
  return "palette" in obj;
}

export function isContinuousScale<T>(obj: AccessorScale<T>): obj is AccessorScaleContinuous<T> {
  return (
    obj.scale === "linear" || obj.scale === "power" || obj.scale === "log" || obj.scale === "symlog"
  );
}

export function isDiscreteScale<T>(obj: AccessorScale<T>): obj is AccessorScaleDiscrete<T> {
  return obj.scale === "threshold" || obj.scale === "quantile" || obj.scale === "quantize";
}

export function accessorScale(
  obj: AccessorScale<number | Color>,
  name: string
): AccessorScale<number | Color> {
  if ("palette" in obj) {
    obj.range = obj.palette!.map((color) => parseColor(color));
    // @ts-ignore
    obj.unknown = parseColor(obj.unknown);
  }

  const scaleData = scaleFn(obj) as any;
  const getData: AccessorFn<any, any> =
    name === "highlightColor" ? highlightFn(obj, scaleData) : accessorFn(obj, scaleData);

  return {
    ...obj,
    name,
    getData,
    scaleData,
  };
}

function scaleFn(accessor: AccessorScale<any>) {
  type T = number | Color;

  switch (accessor.scale) {
    case "linear":
      return scaleLinear<T>()
        .domain(accessor.domain)
        .range(accessor.range)
        .unknown(accessor.unknown)
        .clamp(true);
    case "power":
      return scalePow<T>()
        .exponent(accessor.exponent)
        .domain(accessor.domain)
        .range(accessor.range)
        .unknown(accessor.unknown)
        .clamp(true);
    case "log":
      return scaleLog<T>()
        .base(accessor.base)
        .domain(accessor.domain)
        .range(accessor.range)
        .unknown(accessor.unknown)
        .clamp(true);
    case "symlog":
      return scaleSymlog<T>()
        .domain(accessor.domain)
        .range(accessor.range)
        .unknown(accessor.unknown)
        .clamp(true);
    case "threshold":
    case "quantile":
      return scaleThreshold<number, T>()
        .domain(accessor.domain)
        .range(accessor.range)
        .unknown(accessor.unknown);
    case "category":
      return scaleOrdinal<T>()
        .domain(accessor.domain)
        .range(accessor.range)
        .unknown(accessor.unknown);
    case "quantize":
      return scaleQuantize<T>()
        .domain(accessor.domain)
        .range(accessor.range)
        .unknown(accessor.unknown);
    default:
      throw TypeError(`scale ${(accessor as any).scale} not supported`);
  }
}

function accessorFn({ col, dataType }: Accessor, scaleData: ScaleFn): AccessorFn<any, any> {
  switch (dataType) {
    case "table":
      return tableData(col, scaleData);
    case "object":
      return objectData(col, scaleData);
    case "geojson":
      return geojsonData(col, scaleData);
    default:
      throw TypeError(`${dataType} not supported`);
  }
}

function highlightFn({ col, dataType }: Accessor, scaleData: ScaleFn): AccessorFn<any, any> {
  switch (dataType) {
    case "table":
      return tableHighlight(col, scaleData);
    case "object":
      return objectHighlight(col, scaleData);
    case "geojson":
      return geojsonHighlight(col, scaleData);
    default:
      throw TypeError(`${dataType} not supported`);
  }
}

function tableData(col: string, scaleData: ScaleFn): AccessorFn<DataFrame, any> {
  return (_, { index, data }) => scaleData(data.frame[col][index]);
}

function tableHighlight(col: string, scaleData: ScaleFn): AccessorFn<PickInfo<null>, any> {
  return ({ index, layer }) =>
    // @ts-ignore
    scaleData(layer.props.data!.frame[col][index]);
}

function objectData(col: string, scaleData: ScaleFn): AccessorFn<Record<string, any>, any> {
  return (object) => scaleData(object[col]);
}

function objectHighlight(
  col: string,
  scaleData: ScaleFn
): AccessorFn<PickInfo<Record<string, any>>, any> {
  return ({ object }) => scaleData(object[col]);
}

function geojsonData(col: string, scaleData: ScaleFn): AccessorFn<Feature, any> {
  return (object) => scaleData(object.properties![col]);
}

function geojsonHighlight(col: string, scaleData: ScaleFn): AccessorFn<PickInfo<Feature>, any> {
  return ({ object }) => scaleData(object.properties![col]);
}
