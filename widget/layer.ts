import * as deck from "./deck-bundle";
import { Layer, LayerProps } from "deck.gl";
import { isObject } from "./util";
import { Scale } from "./scale";
import { accessors } from "./accessor";

export interface RDeckLayerProps extends Omit<LayerProps<any>, "data"> {
  type: string;
  data: DataFrame | GeoJSON.GeoJsonObject;
  tooltip: boolean | string[];
}

export default class RDeckLayer {
  layer: Layer<any>;
  constructor({ type, ...props }: RDeckLayerProps) {
    const colorProps = Object.entries(props).filter(
      ([name, value]) => /get.*color/i.test(name) && isObject(value)
    );

    // TODO: do something with the scales to create a legend
    const scales: [string, Scale][] = colorProps.map(([name, scale]) => [
      name,
      new Scale(scale, props.data),
    ]);

    const scaleProps = Object.fromEntries(scales.map(([name, scale]) => [name, scale.accessor]));

    // @ts-ignore
    this.layer = new deck[type](Object.assign(accessors, props, scaleProps));
  }

  static create(props: RDeckLayerProps) {
    return new RDeckLayer(props);
  }
}
