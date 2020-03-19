import { scaleQuantize } from "d3-scale";
import { Color } from "@deck.gl/core/utils/color";
import { Accessor } from "./accessor";

interface ScaleProps {
  domain: [number, number];
  range: Color[];
  value: string;
}

export class Scale {
  scale: any;
  accessor: Accessor;

  constructor(scale: ScaleProps, data: any) {
    const value = data.frame[scale.value];

    this.scale = scaleQuantize<any>()
      .domain(scale.domain ?? getDomain(value))
      .range(scale.range)
      .nice();

    this.accessor = createAccessor(this.scale, value);
  }
}

function createAccessor(scale: Function, value: any[]): Accessor {
  return (object, { index }) => scale(value[index]);
}

function getDomain(values: number[]): [number, number] {
  const min = Math.min.apply(undefined, values);
  const max = Math.max.apply(undefined, values);

  return [min, max];
}
