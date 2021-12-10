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
        pickingColors: {
          type: GL.UNSIGNED_BYTE,
          size: 3,
          accessor: (object, { index, data, target }) => {
            // data is a dataframe, with flattened geometries?
            if (isDataFrame(data) && Array.isArray(data.indices)) {
              return layer.encodePickingColor(data.indices.indexOf(data.indices[index]), target);
            }

            // sub-layer, where parent data is a dataframe with flattened geometries?
            const parentData = object?.__source?.parent?.props.data;
            if (isDataFrame(parentData) && Array.isArray(parentData.indices)) {
              return layer.encodePickingColor(
                parentData.indices.indexOf(parentData.indices[object.__source.index]),
                target
              );
            }

            // default
            return layer.encodePickingColor(object?.__source.index ?? index, target);
          },
          shaderAttributes: {
            pickingColors: {
              divisor: 0,
            },
            instancePickingColors: {
              divisor: 1,
            },
          },
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
