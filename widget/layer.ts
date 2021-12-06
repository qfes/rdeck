import * as deck from "./deck-bundle";
import type { Layer as DeckLayer, LayerProps as DeckLayerProps } from "@deck.gl/core";
import type { BitmapLayerProps } from "@deck.gl/layers";
import type { TileLayerProps } from "@deck.gl/geo-layers";
import type { FeatureCollection } from "geojson";

import { parseColor } from "./color";
import { AccessorScale, accessorScale, isAccessorScale } from "./scale";
import { accessor, Accessor, isAccessor } from "./accessor";
import { blendingParameters } from "./blending";
import { flattenGeometries, isDataFrame } from "./data-frame";
import { MultiHighlightExtension } from "./multi-highlight-extension";

type LayerData = string | DataFrame | FeatureCollection;
type Entry<T> = [string, T];

export type LegendInfo = Pick<LayerProps, "id" | "name"> & {
  scales: AccessorScale<number | Color>[];
};

export type VisibilityInfo = Pick<LayerProps, "id" | "name" | "groupName"> & {
  visible: boolean;
};

export interface LayerProps extends Omit<DeckLayerProps<any>, "data"> {
  type: string;
  name: string;
  groupName: string | null;
  data: LayerData | null;
  blendingMode: BlendingMode;
  visibilityToggle: boolean;
  tooltip: TooltipInfo | null;
}

interface TripsLayerProps extends LayerProps {
  currentTime: number;
  loopLength: number;
  animationSpeed: number;
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
    const _props = Object.fromEntries([
      ...entries,
      ...colors,
      ...accessors.map(([name, value]) => [name, value.getData]),
      ...getWeightProps(entries),
      ["visible", props.visible ?? true],
      ["updateTriggers", getUpdateTriggers(accessors)],
      ["parameters", getParameters(props.parameters, props.blendingMode)],
    ]);

    // multi-geometry highlight
    if (isDataFrame(_props.data)) {
      _props.data = flattenGeometries(_props.data);
      _props.extensions = [new MultiHighlightExtension(), ...(_props.extensions ?? [])];
    }

    // tile-layer
    type TileProps = TileLayerProps<any> & BitmapLayerProps<any> & { tile: any };
    if (type === "TileLayer") {
      _props.renderSubLayers = (props: TileProps) => {
        const {
          bbox: { west, south, east, north },
          x,
          y,
          z,
        } = props.tile;

        return new deck.BitmapLayer({
          ...props,
          data: [{ z, x, y }],
          image: props.data,
          bounds: [west, south, east, north],
        });
      };
    }

    this.props = _props;

    this.scales = accessors
      .filter(([, value]) => isAccessorScale(value))
      .map(([, value]) => value as AccessorScale<number | Color>);

    // load font
    if (type === "TextLayer" && "fonts" in document) {
      // @ts-ignore
      document.fonts.load(`16px ${props.fontFamily}`);
    }
  }

  static create(props: LayerProps) {
    return new Layer(props);
  }

  renderLayer(time?: number): DeckLayer<any, any> {
    // animate trips layer
    if (this.type === "TripsLayer" && time !== undefined) {
      const props = this.props as TripsLayerProps;
      const { loopLength, animationSpeed } = props;
      const animationTime = loopLength / animationSpeed;
      const ratioComplete = ((time / 1000) % animationTime) / animationTime;
      props.currentTime = ratioComplete * loopLength;
    }
    // @ts-ignore
    return new deck[this.type]({ ...this.props });
  }

  renderLegend(): LegendInfo {
    const scales = this.scales.filter((scale) => scale.legend);
    return { id: this.props.id!, name: this.props.name, scales };
  }

  renderSelector(): VisibilityInfo {
    return {
      id: this.props.id!,
      groupName: this.props.groupName,
      name: this.props.name,
      visible: this.props.visible ?? true,
    };
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

function getParameters(parameters: any, blendingMode: BlendingMode) {
  return {
    ...parameters,
    ...blendingParameters(blendingMode),
  };
}

// getColorWeight & getElevationWeight must be functions
function getWeightProps(entries: Entry<any>[]) {
  return entries
    .filter(([name]) => name === "getColorWeight" || name === "getElevationWeight")
    .filter(([, value]) => value !== null && typeof value !== "function" && !isAccessor(value))
    .map(([name, value]) => [name, () => value]);
}
