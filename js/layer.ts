import deck from "@deck.gl/layers";
import { default as Layer, LayerProps } from "@deck.gl/core/lib/layer";
import { PickInfo } from "@deck.gl/core";

interface DeckLayerProps extends LayerProps<any> {
  type: string;
}

export default class DeckLayer {
  static create({ type, ...props }: DeckLayerProps): Layer<any> {
    props.onHover = DeckLayer.onHover;
    // @ts-ignore
    return new deck[type](Object.assign(accessors, props)) as Layer;
  }

  static onHover(info: PickInfo<any>) {
    const { id, name, tooltip, data } = info.layer.props;
    // not picked or no tooltip config
    if (!(info.picked && tooltip)) return;
    // no data
    if (!(info.object || data.frame)) return;

    const getEntry = info.object
      ? (key: string) => [key, info.object[key]]
      : (key: string) => [key, data.frame[key][info.index]];

    return {
      name: name ?? id,
      entries: [tooltip].flat().map(getEntry)
    };
  }
}

type Accessor = (object: object, { index, data }: { index: number; data: any }) => any;

const accessors: { [property: string]: Accessor } = {
  getHexagon: (object, { index, data }) => data.frame.hexagon[index],
  getHexagons: (object, { index, data }) => data.frame.hexagons[index],
  getS2Token: (object, { index, data }) => data.frame.token[index],
  getIcon: (object, { index, data }) => data.frame.icon[index],
  getText: (object, { index, data }) => data.frame.text[index],
  getPath: (object, { index, data }) => data.frame.path[index],
  getPolygon: (object, { index, data }) => data.frame.polygon[index],
  getPosition: (object, { index, data }) => data.frame.position[index],
  getSourcePosition: (object, { index, data }) => data.frame.sourcePosition[index],
  getTargetPosition: (object, { index, data }) => data.frame.targetPosition[index]
};
