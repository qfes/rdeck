import * as deck from "./deck-bundle";
import { Layer, LayerProps } from "deck.gl";
import { Feature, FeatureCollection } from "geojson";

import { isObject, parseColor, Color } from "./util";
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
    const colorProps = getColorProps(props);

    const scales = getScales(props);
    const scaleProps = Object.fromEntries(scales.map(({ name, value }) => [name, value]));

    // @ts-ignore
    this.layer = new deck[type](Object.assign(accessors, props, colorProps, scaleProps));
    this.legend = { name: props.id || type, scales: scales.filter((scale) => scale.legend) };
  }

  static create(props: RDeckLayerProps) {
    return new RDeckLayer(props);
  }
}

function isColor(name: string) {
  return name.endsWith("Color");
}

function isScalable(name: string) {
  return /(Radius|Elevation|Color)$/.test(name);
}

function getColorProps(props: Record<string, any>) {
  type ColorEntry = [string, Color | Color[]];
  const entries: ColorEntry[] = Object.entries(props)
    .filter(([name, value]) => isColor(name) && typeof value === "string")
    .map(([name, value]) => [name, parseColor(value)]);

  if ("colorRange" in props) {
    entries.push([
      "colorRange",
      props.colorRange.map((color: string | Color) => parseColor(color)),
    ]);
  }

  return Object.fromEntries(entries) as Record<string, Color | Color[]>;
}

function getScales(props: Record<string, any>) {
  const isScale = (value: any) => isObject(value) && "type" in value;

  const scales = Object.entries(props)
    .filter(([name, value]) => isScalable(name) && isScale(value))
    .map(([name, scaleProps]) => {
      let range = scaleProps.range;
      if (isColor(name)) {
        range = range.map((color: string | Color) => parseColor(color));
      }

      return new ScaleAccessor({
        ...scaleProps,
        range,
        name,
        data: getColumn(props.data, scaleProps.value),
      });
    });

  return scales;
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
