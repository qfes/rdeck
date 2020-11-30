import * as deck from "./deck-bundle";
import { Layer, LayerProps } from "deck.gl";
import { FeatureCollection } from "geojson";

import { parseColor } from "./color";
import { AccessorScale, accessorScale, isAccessorScale } from "./scale";
import { accessor, Accessor, isAccessor } from "./accessor";

type LayerData = string | DataFrame | FeatureCollection;
type Entry<T> = [string, T];

export interface RDeckLayerProps extends Omit<LayerProps<any>, "data"> {
  type: string;
  name: string;
  data: LayerData | null;
  tooltip: TooltipInfo | null;
}

export default class RDeckLayer {
  layer: Layer<any>;
  legend: {
    name: string;
    scales: AccessorScale[];
  };

  constructor({ type, ...props }: RDeckLayerProps) {
    const entries = Object.entries(props);

    const colors = convertColors(entries);
    const accessors = getAccessors(entries);

    // @ts-ignore
    this.layer = new deck[type](
      Object.fromEntries([
        ...entries,
        ...colors,
        ...accessors.map(([name, value]) => [name, value.getData]),
      ])
    );

    const scales = accessors
      .filter(([, value]) => isAccessorScale(value) && value.legend)
      .map(([, value]) => value as AccessorScale);

    this.legend = {
      name: props.name,
      scales,
    };
  }

  static create(props: RDeckLayerProps) {
    return new RDeckLayer(props);
  }
}

function isColor(name: string, value: any) {
  return name.endsWith("Color") && (Array.isArray(value) || typeof value === "string");
}

function convertColors(entries: Entry<any>[]): Entry<Color | Color[]>[] {
  const colors = entries
    .filter(([name, value]) => isColor(name, value))
    .map(([name, color]): Entry<Color> => [name, parseColor(color)]);

  const colorRange = entries.find(([name]) => name === "colorRange");
  if (colorRange) {
    colors.push([colorRange[0], colorRange[1].map(parseColor)]);
  }

  return colors;
}

function getAccessors(entries: Entry<any>[]): Entry<Accessor>[] {
  return entries
    .filter(([, value]) => isAccessor(value))
    .map(([name, value]) => [
      name,
      isAccessorScale(value) ? accessorScale(value, name) : accessor(value),
    ]);
}

// function convertScales(entries: Entry<Accessor | ScaleAccessor>[], data?: LayerData) {
//   const isScale = (value: any) => value.scale != null;

//   const scales = entries
//     .filter(([, value]) => isScale(value))
//     .map(([name, scale]) => {
//       let range = scale.range;
//       if (isColor(name)) {
//         range = range.map((color: string | Color) => parseColor(color));
//       }

//       return new ScaleAccessor({
//         ...scale,
//         range,
//         name,
//         data: null //getColumn(scale.value, data),
//       });
//     });

//   return scales;
// }

// function getColumn(name: string, data: LayerData): any[] {
//   if (Array.isArray(data) && data.length === 0) return [];

//   // data frame
//   if ("frame" in data) {
//     return data.frame[name];
//   }

//   if ("type" in data) {
//     const getProperty = (feature: GeoJSON.Feature) => feature.properties?.[name];

//     switch (data.type) {
//       case "Feature":
//         return getProperty(data);
//       case "FeatureCollection":
//         return data.features.map(getProperty);
//     }
//   }

//   throw TypeError("data type not suppported");
// }
