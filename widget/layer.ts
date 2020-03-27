import * as deck from "./deck-bundle";
import { Layer, LayerProps } from "deck.gl";
import { Feature, FeatureCollection } from "geojson";

import { isObject } from "./util";
import ScaleAccessor from "./scale";
import { accessors } from "./accessor";

type LayerData = DataFrame | Feature | FeatureCollection;

export interface RDeckLayerProps extends Omit<LayerProps<any>, "data"> {
  type: string;
  data: LayerData;
  tooltip: boolean | string[];
}

export default class RDeckLayer {
  layer: Layer<any>;
  legend: {
    name: string;
    scales: ScaleAccessor[];
  };

  constructor({ type, ...props }: RDeckLayerProps) {
    // FIXME: add additional scalable props
    const colorProps: [string, any][] = Object.entries(props).filter(
      ([name, value]) => /get.*color$/i.test(name) && isObject(value)
    );

    const scales = colorProps.map(([name, scaleProps]) => {
      return new ScaleAccessor({
        ...scaleProps,
        name,
        data: getColumn(props.data, scaleProps.value),
      });
    });

    const scaleProps = Object.fromEntries(scales.map(({ name, value }) => [name, value]));

    // @ts-ignore
    this.layer = new deck[type](Object.assign(accessors, props, scaleProps));
    this.legend = { name: props.id || type, scales };
  }

  static create(props: RDeckLayerProps) {
    return new RDeckLayer(props);
  }
}

function getColumn(data: LayerData, name: string): any[] {
  if (Array.isArray(data) && data.length === 0) return [];

  // data frame
  if ("frame" in data) {
    return data.frame[name];
  }

  if ("type" in data) {
    const getProperty = (feature: GeoJSON.Feature) => feature.properties?.[name];

    switch (data.type) {
      case "Feature":
        return getProperty(data);
      case "FeatureCollection":
        return data.features.map(getProperty);
    }
  }

  throw TypeError("data type not suppported");
}
/*
{
  type: "quantize" | "quantile" | "linear",

}

{
  power: exponent
  log: base
}

log & power ticks are weirds
*/
