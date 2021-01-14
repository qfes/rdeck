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
    return isDataFrame(data) && Array.isArray(data.indices)
      ? _encodePickingColor(data.indices[i], target)
      : _encodePickingColor(i, target);
  };
}

function overridegetPickingInfo(Layer: LayerType) {
  const _getPickingInfo = Layer.prototype.getPickingInfo;
  Layer.prototype.getPickingInfo = function getPickingInfo(params) {
    let info = _getPickingInfo.call(this, params);
    let { data } = this.props;
    // multi-geometry
    if (isDataFrame(data) && Array.isArray(data.indices)) {
      info.index = data.indices.indexOf(info.index);
    }

    return info;
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
Layers.forEach((Layer) => overridegetPickingInfo(Layer));
