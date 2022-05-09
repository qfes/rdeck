import { EditableGeoJsonLayer } from "@nebula.gl/layers";
import { PathStyleExtension } from "@deck.gl/extensions";
import type { FeatureCollection } from "geojson";

const LIGHT_BLUE = [3, 169, 244] as const;
const LINE_COLOR: Color = [...LIGHT_BLUE, 255];
const FILL_COLOR: Color = [...LIGHT_BLUE, 0.1 * 255];

type EditInfo = {
  updatedData?: FeatureCollection;
  editType?: string;
  featureIndexes?: number[];
  editContext?: any;
};

type EditHandler = (info: EditInfo) => void;
type ChangeHandler = EditHandler;

export type EditableLayerProps = Omit<
  typeof EditableGeoJsonLayer.defaultProps,
  "data" | "dataTransform"
> & {
  onChange: ChangeHandler;
  getDashArray: [number, number];
};

export class EditableLayer extends EditableGeoJsonLayer {
  static defaultProps: EditableLayerProps = {
    ...EditableGeoJsonLayer.defaultProps,
    selectedFeatureIndexes: [0],
    pickingDepth: 0,
    onChange: () => {},
    // line & handle size
    getRadius: 5,
    getLineWidth: 2,
    getTentativeLineWidth: 2,

    // colours
    getLineColor: LINE_COLOR,
    getTentativeLineColor: LINE_COLOR,
    getEditHandlePointOutlineColor: LINE_COLOR,
    getFillColor: FILL_COLOR,
    getTentativeFillColor: FILL_COLOR,
    getEditHandlePointColor: [0, 0, 0, 0],

    getDashArray: [4, 2],
    extensions: [new PathStyleExtension({ dash: true })],
  };

  constructor(props: EditableLayerProps, ...additionalProps: EditableLayerProps[]) {
    const onEdit = getProp("onEdit", props, ...additionalProps);
    const onChange = getProp("onChange", props, ...additionalProps);

    // @ts-ignore
    super(props, ...additionalProps, { onEdit: handleEdit(onEdit, onChange) });
  }
}

const CHANGE_EVENTS = Object.freeze([
  "addFeature",
  "addPosition",
  "removePosition",
  "finishMovePosition",
  "translated",
]);

function handleEdit(onEdit?: EditHandler, onChange?: ChangeHandler) {
  return ({ updatedData, editType, editContext }: EditInfo) => {
    // drawing a new polygon? delete any current polygons
    if (editType === "updateTentativeFeature" && updatedData && updatedData.features.length !== 0) {
      updatedData.features.length = 0;
    }

    onEdit?.({ updatedData, editType, editContext });

    if (editType != null && CHANGE_EVENTS.includes(editType)) {
      onChange?.({ updatedData, editType, editContext });
    }
  };
}

function getProp<K extends keyof P, P extends object>(name: K, ...props: P[]): P[K] | undefined {
  return props
    .map((p) => p[name])
    .reverse()
    .find((x) => x !== undefined);
}
