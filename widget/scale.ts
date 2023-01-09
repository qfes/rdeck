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
  ScaleSymLog,
  scaleSymlog,
  ScaleThreshold,
  scaleThreshold,
  scaleIdentity,
  ScaleIdentity,
} from "d3-scale";
import type { PickInfo, AccessorFn } from "@deck.gl/core";
import type { Color } from "./types";
import { Accessor, getPickValue, getValue, isAccessor } from "./accessor";
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

export type AccessorScaleIdentity<Range> = AccessorScaleBase<Range> & {
  scale: "identity";
  scaleData: ScaleIdentity<Range>;
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
  | AccessorScaleCategory<Range>
  | AccessorScaleIdentity<Range>;

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
    case "identity":
      return scaleIdentity<T>().unknown(accessor.unknown);
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

function accessorFn({ col }: Accessor, scaleData: ScaleFn): AccessorFn<any, any> {
  const fn = getValue(col);
  return (object, { data, index, target }) => scaleData(fn(object, { data, index, target }));
}

function highlightFn({ col }: Accessor, scaleData: ScaleFn): (info: PickInfo) => Color {
  const fn = getPickValue(col);
  // @ts-ignore
  return (info) => scaleData(fn(info));
}
