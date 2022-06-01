import { EditableGeoJsonLayer } from "@nebula.gl/layers";
import { PathStyleExtension } from "@deck.gl/extensions";
import {
  ViewMode,
  CompositeMode,
  ModifyMode,
  TranslateMode,
  DrawPolygonMode,
  DrawPolygonByDraggingMode,
  EditAction,
} from "@nebula.gl/edit-modes";
import type { FeatureCollection } from "geojson";
import { PolygonEditorMode } from "../types";

const LIGHT_BLUE = [3, 169, 244] as const;
const LINE_COLOR: Color = [...LIGHT_BLUE, 255];
const FILL_COLOR: Color = [...LIGHT_BLUE, 0.1 * 255];
const TRANSPARENT: Color = [0, 0, 0, 0];

export type EditHandler = (action: EditAction<FeatureCollection>) => void;
export type ChangeHandler = EditHandler;

export type EditableLayerProps = Omit<
  typeof EditableGeoJsonLayer.defaultProps,
  "name" | "groupName" | "tooltip"
> & {
  data?: FeatureCollection;
  onChange?: ChangeHandler;
  dash?: boolean;
  getDashArray?: [number, number];
};

// @ts-ignore
export interface EditableLayer extends EditableGeoJsonLayer {
  props: EditableLayerProps;
}

// @ts-ignore
export class EditableLayer extends EditableGeoJsonLayer {
  static defaultProps: EditableLayerProps = {
    ...EditableGeoJsonLayer.defaultProps,
    selectedFeatureIndexes: [0],
    pickingDepth: 0,
    onChange: () => {},
    // translate in mercator
    modeConfig: {
      screenSpace: true,
      viewport: {},
    },
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
    getEditHandlePointColor: TRANSPARENT,

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
  return function ({ updatedData, editType, editContext }: EditAction<FeatureCollection>) {
    // drawing a new polygon? delete any current polygons
    if (editType === "updateTentativeFeature" && updatedData && updatedData.features.length !== 0) {
      updatedData.features.length = 0;
    }

    // @ts-ignore
    this.data = updatedData;
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

const EDITOR_MODES = Object.seal({
  view: new ViewMode(),
  modify: new CompositeMode([new TranslateMode(), new ModifyMode()]),
  polygon: new DrawPolygonMode(),
  lasso: new DrawPolygonByDraggingMode(),
});

export function nebulaMode(mode?: PolygonEditorMode) {
  return EDITOR_MODES[mode ?? "view"] ?? EDITOR_MODES.view;
}
