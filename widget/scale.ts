import { scaleQuantize, ScaleQuantize } from "d3-scale";
import { Accessor } from "./accessor";

export default class ScaledAccessor {
  type = "quantize";
  name: string;
  value: Accessor;
  field: string;
  data: any[];
  scale: ScaleQuantize<any>;

  constructor(props: any) {
    const { name, field, data } = props;
    this.name = name;
    this.field = field;
    this.data = data;

    this.scale = scaleQuantize<any>()
      .domain(props.domain ?? getDomain(data))
      .range(props.range)
      .nice();

    this.value = createAccessor(this.scale, data);
  }
}

function createAccessor(scale: any, data: any[]): Accessor {
  // replace nulls with undefined for unknown value mapping - could be performance overhead
  return (object, { index }) => scale(data[index] ?? undefined);
}

function getDomain(values: number[]): [number, number] {
  const min = Math.min.apply(undefined, values);
  const max = Math.max.apply(undefined, values);

  return [min, max];
}
