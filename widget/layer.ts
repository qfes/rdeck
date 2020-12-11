import * as deck from "./deck-bundle";
import { Layer as DeckLayer, LayerProps as DeckLayerProps } from "deck.gl";
import { TextLayerProps } from "@deck.gl/layers/text-layer/text-layer";
import { FeatureCollection } from "geojson";

import { parseColor } from "./color";
import { AccessorScale, accessorScale, isAccessorScale } from "./scale";
import { accessor, Accessor, isAccessor } from "./accessor";
import { LegendLayerProps } from "./legend";

type LayerData = string | DataFrame | FeatureCollection;
type Entry<T> = [string, T];

export interface LayerProps extends Omit<DeckLayerProps<any>, "data"> {
  type: string;
  name: string;
  data: LayerData | null;
  tooltip: TooltipInfo | null;
}

export class Layer {
  layer: DeckLayer<any>;
  legend: LegendLayerProps;

  constructor({ type, ...props }: LayerProps) {
    const entries = Object.entries(props);

    const colors = getColors(entries);
    const accessors = getAccessors(entries);

    // @ts-ignore
    this.layer = new deck[type](
      Object.fromEntries([
        ...entries,
        ...colors,
        ...accessors.map(([name, value]) => [name, value.getData]),
      ])
    );

    // load font
    if (type === "TextLayer" && "fonts" in document) {
      const _props = props as TextLayerProps<any>;
      // @ts-ignore
      document.fonts.load(`16px ${_props.fontFamily}`);
    }

    const scales = accessors
      .filter(([, value]) => isAccessorScale(value) && value.legend)
      .map(([, value]) => value as AccessorScale<number | Color>);

    this.legend = {
      id: props.id!,
      name: props.name,
      scales,
    };
  }

  static create(props: LayerProps) {
    return new Layer(props);
  }
}

export function isColor([name, value]: [string, any]) {
  return name.endsWith("Color") && (Array.isArray(value) || typeof value === "string");
}

function getColors(entries: Entry<any>[]): Entry<Color | Color[]>[] {
  const colors = entries
    .filter(isColor)
    .map(([name, color]): Entry<Color> => [name, parseColor(color)]);

  const colorRange = entries.find(([name]) => name === "colorRange");
  if (colorRange) {
    colors.push([colorRange[0], colorRange[1].map((color: string | Color) => parseColor(color))]);
  }

  return colors;
}

function getAccessors(entries: Entry<any>[]): Entry<Accessor>[] {
  return entries
    .filter(([, value]) => isAccessor(value))
    .map(([name, value]) => [
      name,
      isAccessorScale(value) ? accessorScale(value, name) : accessor(value, name),
    ]);
}
