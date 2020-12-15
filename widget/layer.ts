import * as deck from "./deck-bundle";
import { Layer as DeckLayer, LayerProps as DeckLayerProps } from "deck.gl";
import { TextLayerProps } from "@deck.gl/layers/text-layer/text-layer";
import { FeatureCollection } from "geojson";

import { parseColor } from "./color";
import { AccessorScale, accessorScale, isAccessorScale } from "./scale";
import { accessor, Accessor, isAccessor } from "./accessor";

type LayerData = string | DataFrame | FeatureCollection;
type Entry<T> = [string, T];

export interface LayerProps extends Omit<DeckLayerProps<any>, "data"> {
  type: string;
  name: string;
  data: LayerData | null;
  tooltip: TooltipInfo | null;
}

export class Layer {
  type: string;
  props: LayerProps;
  scales: AccessorScale<any>[];

  constructor({ type, ...props }: LayerProps) {
    const entries = Object.entries(props);
    const colors = getColors(entries);
    const accessors = getAccessors(entries);

    this.type = type;
    this.props = Object.fromEntries([
      ...entries,
      ...colors,
      ...accessors.map(([name, value]) => [name, value.getData]),
      ["updateTriggers", getUpdateTriggers(accessors)],
    ]);

    this.scales = accessors
      .filter(([, value]) => isAccessorScale(value))
      .map(([, value]) => value as AccessorScale<number | Color>);

    // load font
    if (type === "TextLayer" && "fonts" in document) {
      const _props = props as TextLayerProps<any>;
      // @ts-ignore
      document.fonts.load(`16px ${_props.fontFamily}`);
    }
  }

  static create(props: LayerProps) {
    return new Layer(props);
  }

  renderLayer(): DeckLayer<any, any> {
    // @ts-ignore
    return new deck[this.type](this.props);
  }

  renderLegend() {
    // top-most layer on top of legend
    const scales = this.scales.filter((scale) => scale.legend);
    return { id: this.props.id!, name: this.props.name, scales };
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

function getAccessors(entries: Entry<any>[]): Entry<Accessor | AccessorScale<any>>[] {
  return entries
    .filter(([, value]) => isAccessor(value))
    .map(([name, value]) => [
      name,
      isAccessorScale(value) ? accessorScale(value, name) : accessor(value, name),
    ]);
}

function getUpdateTriggers(entries: Entry<Accessor | AccessorScale<any>>[]) {
  const scaleProps = (accessor: any) => {
    const { getData, scaleData, palette, ...props } = accessor;
    return props;
  };

  const propTriggers = entries.map(([name, accessor]) => [name, scaleProps(accessor)]);
  return Object.fromEntries(propTriggers);
}
