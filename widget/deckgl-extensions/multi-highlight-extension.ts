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

import { isTable } from "../table";

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
            if (isTable(data) && Array.isArray(data.featureIds)) {
              const startIndex = getStartIndex(data.featureIds, index);
              return layer.encodePickingColor(startIndex, target);
            }

            // sub-layer, where parent data is a dataframe with flattened geometries?
            const parentData = object?.__source?.parent?.props.data;
            if (isTable(parentData) && Array.isArray(parentData.featureIds)) {
              const startIndex = getStartIndex(parentData.featureIds, object.__source.index);
              return layer.encodePickingColor(startIndex, target);
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

type BaseLayer = Layer<any, any>;
function isPrimitiveLayer(layer: BaseLayer | LayerExtension): layer is BaseLayer {
  return Layers.some((Layer) => layer instanceof Layer);
}

function getStartIndex(featureIds: number[], index: number) {
  return featureIds.indexOf(featureIds[index]);
}
