import {
  scaleQuantize,
  ScaleQuantize,
  scaleLinear,
  scalePow,
  scaleLog,
  scaleQuantile,
  ScaleQuantile,
  ScaleLinear,
  ScalePower,
  ScaleLogarithmic,
} from "d3-scale";
import { Accessor } from "./accessor";

type ScaleType =
  | ScaleLinear<any, any>
  | ScalePower<any, any>
  | ScaleLogarithmic<any, any>
  | ScaleQuantize<any>
  | ScaleQuantile<any>;

export default class ScaleAccessor {
  type: string;
  name: string;
  value: Accessor;
  field: string;
  data: any[];
  scale: ScaleType;
  legend: boolean;

  constructor({ type, name, value: field, data, domain, range, exponent, base, legend }: any) {
    this.type = type;
    this.name = name;
    this.field = field;
    this.data = data;
    this.legend = legend;

    this.scale = createScale({ type, domain: domain ?? data, range, exponent, base });
    this.value = createAccessor(this.scale, data);
  }

  get isContinuous() {
    return "interpolate" in this.scale;
  }
}

function createScale({ type, domain, range, exponent, base }: any): ScaleType {
  switch (type) {
    case "linear":
      return scaleLinear()
        .domain(domain ?? [])
        .range(range);
    case "power":
      return scalePow()
        .domain(domain ?? [])
        .range(range)
        .exponent(exponent);
    case "log":
      return scaleLog()
        .domain(domain ?? [])
        .range(range)
        .base(base);
    case "quantize":
      return scaleQuantize()
        .domain(domain ?? [])
        .range(range);
    case "quantile":
      return scaleQuantile()
        .domain(domain ?? [])
        .range(range);
    default:
      throw TypeError(`scale type: ${type} not supported`);
  }
}

function createAccessor(scale: any, data: any[]): Accessor {
  // TODO: replace nulls with undefined for unknown value mapping - could be performance overhead
  return (object, { index }) => scale(data[index]);
}
