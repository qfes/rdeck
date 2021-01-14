import type { Layer } from "@deck.gl/core";
import {
  ArcLayer,
  IconLayer,
  LineLayer,
  PathLayer,
  PointCloudLayer,
  ScatterplotLayer,
  SolidPolygonLayer,
} from "./deck-bundle";

import { isDataFrame } from "./data-frame";

type LayerType = typeof Layer;

function overrideEncodePickingColor(Layer: LayerType) {
  const _encodePickingColor = Layer.prototype.encodePickingColor;
  Layer.prototype.encodePickingColor = function encodePickingColor(i: number, target = []) {
    let { data } = this.props;

    // multi-geometry
    if (isDataFrame(data) && Array.isArray(data.indices)) {
      const group = data.indices[i];
      // encode index at first instance of group
      return _encodePickingColor.call(this, data.indices.indexOf(group), target);
    }

    return _encodePickingColor.call(this, i, target);
  };
}

const Layers = [
  ArcLayer,
  IconLayer,
  LineLayer,
  PathLayer,
  PointCloudLayer,
  ScatterplotLayer,
  SolidPolygonLayer,
] as LayerType[];

Layers.forEach((Layer) => overrideEncodePickingColor(Layer));
