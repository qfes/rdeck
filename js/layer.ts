import deck from "@deck.gl/layers";
import { default as Layer, LayerProps } from "@deck.gl/core/lib/layer";

interface DeckLayerProps {
  type: string;
  props: LayerProps<any>;
}

type Accessor = (object: object, { index, data }: { index: number; data: any }) => any;

export default class DeckLayer {
  static create({ type, props }: DeckLayerProps): Layer<any> {
    // @ts-ignore
    return new deck[type](Object.assign(accessors, props)) as Layer;
  }
}

const accessors: { [property: string]: Accessor } = {
  getHexagon: (object, { index, data }) => data.frame.hexaon[index],
  getHexagons: (object, { index, data }) => data.frame.hexaons[index],
  getS2Token: (object, { index, data }) => data.frame.token[index],
  getIcon: (object, { index, data }) => data.frame.icon[index],
  getText: (object, { index, data }) => data.frame.text[index],
  getPath: (object, { index, data }) => data.frame.path[index],
  getPolygon: (object, { index, data }) => data.frame.polygon[index],
  getPosition: (object, { index, data }) => data.frame.position[index],
  getSourcePosition: (object, { index, data }) => data.frame.sourcePosition[index],
  getTargetPosition: (object, { index, data }) => data.frame.targetPosition[index]
};
