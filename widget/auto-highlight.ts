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
    const data = this.props.data;
    return isDataFrame(data) && Array.isArray(data.indices)
      ? _encodePickingColor(data.indices[i], target)
      : _encodePickingColor(i, target);
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
