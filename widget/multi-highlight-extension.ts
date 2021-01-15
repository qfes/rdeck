import { Layer, LayerExtension } from "@deck.gl/core";
import { default as GL } from "@luma.gl/constants";
import {
  ArcLayer,
  IconLayer,
  LineLayer,
  PathLayer,
  PointCloudLayer,
  ScatterplotLayer,
  SolidPolygonLayer,
} from "@deck.gl/layers";

import { isDataFrame } from "./data-frame";

export class MultiHighlightExtension extends LayerExtension {
  initializeState() {
    if (!isPrimitiveLayer(this)) {
      return;
    }

    const layer = this;
    const attributeManager = layer.getAttributeManager();

    if (attributeManager) {
      attributeManager.addInstanced({
        instancePickingColors: {
          type: GL.UNSIGNED_BYTE,
          size: 3,
          accessor: (_, { index, data, target }) =>
            layer.encodePickingColor(
              isDataFrame(data) && Array.isArray(data.indices)
                ? data.indices.indexOf(data.indices[index])
                : index,
              target
            ),
        },
      });
    }
  }
}

const Layers = [
  ArcLayer,
  IconLayer,
  LineLayer,
  PathLayer,
  PointCloudLayer,
  ScatterplotLayer,
  SolidPolygonLayer,
];

type BaseLayer = Layer<DataFrame, any>;
function isPrimitiveLayer(layer: BaseLayer | LayerExtension): layer is BaseLayer {
  return Layers.some((Layer) => layer instanceof Layer);
}
