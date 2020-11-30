import {
  scaleLinear,
  ScaleLinear,
  scaleLog,
  ScaleLogarithmic,
  scaleOrdinal,
  ScaleOrdinal,
  scalePow,
  ScalePower,
  ScaleQuantile,
  scaleQuantize,
  ScaleQuantize,
} from "d3";
import { Feature } from "geojson";
import { Accessor, AccessorFn, isAccessor } from "./accessor";
import { parseColor } from "./color";

type ScaleFn = (data: any) => number | Color;

type AccessorScaleBase = Accessor & {
  name: string;
  range: (number | Color)[];
  legend: boolean;
};

export type AccessorScaleLinear = AccessorScaleBase & {
  scale: "linear";
  domain: number[];
  scaleData: ScaleLinear<number, number | Color>;
};

export type AccessorScaleLog = AccessorScaleBase & {
  scale: "log";
  domain: number[];
  base: number;
  scaleData: ScaleLogarithmic<number, number | Color>;
};

export type AccessorScalePower = AccessorScaleBase & {
  scale: "power";
  domain: number[];
  exponent: number;
  scaleData: ScalePower<number, number | Color>;
};

export type AccessorScaleQuantize = AccessorScaleBase & {
  scale: "quantize";
  domain: [number, number];
  scaleData: ScaleQuantize<number | Color>;
};

export type AccessorScaleQuantile = AccessorScaleBase & {
  scale: "quantile";
  domain: [number, number];
  scaleData: ScaleQuantile<number | Color>;
};

export type AccessorScaleOrdinal = AccessorScaleBase & {
  scale: "ordinal";
  domain: string[];
  scaleData: ScaleOrdinal<string, number | Color>;
};

export type AccessorScale =
  | AccessorScaleLinear
  | AccessorScaleLog
  | AccessorScalePower
  | AccessorScaleQuantize
  | AccessorScaleQuantile
  | AccessorScaleOrdinal;

export function isAccessorScale(obj: any): obj is AccessorScale {
  return isAccessor(obj) && "scale" in obj;
}

export function accessorScale(obj: AccessorScale, name: string): AccessorScale {
  if (name.endsWith("Color")) {
    obj = {
      ...obj,
      // colours can have a range consisting of hex strings
      range: obj.range.map((color: any) => parseColor(color))
    }
  }

  const scaleData = scaleFn(obj) as any;
  const getData = accessorFn(obj, scaleData) as AccessorFn<any>
  return {
    ...obj,
    name,
    getData,
    scaleData,
  };
}

function scaleFn(accessor: AccessorScale) {
  type T = number | Color;
  switch (accessor.scale) {
    case "linear":
      return scaleLinear<T>().domain(accessor.domain).range(accessor.range);
    case "log":
      return scaleLog<T>().domain(accessor.domain).range(accessor.range).base(accessor.base);
    case "power":
      return scalePow<T>()
        .domain(accessor.domain)
        .range(accessor.range)
        .exponent(accessor.exponent);
    case "quantize":
      return scaleQuantize<T>().domain(accessor.domain).range(accessor.range);
    case "quantile":
      return scaleQuantize<T>().domain(accessor.domain).range(accessor.range);
    case "ordinal":
      return scaleOrdinal<T>().domain(accessor.domain).range(accessor.range);
    default:
      throw TypeError(`scale ${(accessor as any).scale} not supported`);
  }
}

// TODO: replace nulls with undefined for unknown value mapping
function accessorFn({ col, dataType }: Accessor, scaleData: ScaleFn): AccessorFn<any> {
  switch (dataType) {
    case "table":
      return tableFn(col, scaleData);
    case "object":
      return objectFn(col, scaleData);
    case "geojson":
      return geojsonFn(col, scaleData);
    default:
      throw TypeError(`${dataType} not supported`);
  }
}

function geojsonFn(col: string, scaleData: ScaleFn): AccessorFn<Feature> {
  // object.properties will always exist
  return (object) => scaleData(object.properties![col]);
}

function objectFn(col: string, scaleData: ScaleFn): AccessorFn<Record<string, any>> {
  return (object) => scaleData(object[col]);
}

function tableFn(col: string, scaleData: ScaleFn): AccessorFn<DataFrame> {
  return (object, { index, data }) => scaleData(data.frame[col][index]);
}
