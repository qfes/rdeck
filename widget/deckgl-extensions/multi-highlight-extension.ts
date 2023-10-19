import { AccessorParameters, Layer, LayerExtension } from "@deck.gl/core";
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
    if (!isPrimitiveLayer(this)) return;

    const layer = this;
    const attributeManager = this.getAttributeManager();
    if (!attributeManager) return;

    const { pickingColors, instancePickingColors } = attributeManager.getAttributes();
    const attribute = pickingColors ?? instancePickingColors;

    if (!attribute) return;

    const instanced = instancePickingColors != null;
    const { id, type, size, noAlloc, shaderAttributes, accessor, update } = attribute.settings;

    const settings: AccessorParameters = {
      type,
      size,
      noAlloc,
      shaderAttributes,
      update,
      accessor: (object, { data, index, target }) => {
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
        return typeof accessor === "function"
          ? accessor(object, { data, index, target })
          : layer.encodePickingColor(object?.__source.index ?? index, target);
      },
    };

    if (instanced) attributeManager.addInstanced({ [id]: settings });
    else attributeManager.add({ [id]: settings });
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
