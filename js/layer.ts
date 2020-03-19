import deck from "@deck.gl/layers";
import { LayerProps } from "@deck.gl/core/lib/layer";
import { PickInfo, Layer } from "@deck.gl/core";
import { isObject } from "./util";
import { Scale } from "./scale";
import { accessors } from "./accessor";

export interface RDeckLayerProps extends LayerProps<any> {
  type: string;
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
      new Scale(scale, props.data)
    ]);

    const scaleProps = Object.fromEntries(scales.map(([name, scale]) => [name, scale.accessor]));

    // @ts-ignore
    this.layer = new deck[type](Object.assign(accessors, props, scaleProps));
  }

  static create(props: RDeckLayerProps) {
    return new RDeckLayer(props);
  }
}

function onHover(info: PickInfo<any>) {
  const { id, tooltip, data } = info.layer.props;
  // not picked or no tooltip config
  if (!(info.picked && tooltip)) return;
  // no data
  if (!(info.object || data?.frame)) return;

  const index = info.index;
  const isColumnar = info.object == null;
  const object = isColumnar ? data.frame : info.object;

  const getValue = isColumnar ? (key: string) => object[key][index] : (key: string) => object[key];

  const names = typeof tooltip === "boolean" ? Object.keys(object) : [tooltip].flat();
  const entries = names.map(key => [key, getValue(key)]);

  return {
    name: id,
    entries
  };
}
