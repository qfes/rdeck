import { PathStyleExtension } from "@deck.gl/extensions";
import {
  ViewMode,
  CompositeMode,
  ModifyMode,
  TranslateMode,
  SnappableMode,
  DrawPolygonMode,
  DrawPolygonByDraggingMode,
  DrawLineStringMode,
  DrawPointMode,
} from "@nebula.gl/edit-modes";
import type {
  GeoJsonEditMode,
  EditAction,
  ModeProps,
  PointerMoveEvent,
} from "@nebula.gl/edit-modes";
import type { FeatureCollection } from "geojson";
import { EditableGeoJsonLayer } from "nebula.gl";
import type { EditorPanelProps } from "./controls";
import type { EditorMode } from "./types";
import { PickInfo } from "@deck.gl/core";

export type EditorProps = EditorPanelProps & {
  setGeoJson?: (geojson: FeatureCollection) => void;
  selectFeatures?: (featureIndices: number[]) => void;
};

const LIGHT_BLUE = [3, 169, 244] as const;
const MUTED_BLUE = [116, 117, 129] as const;
const LINE_COLOR: Color = [...LIGHT_BLUE, 255];
const FILL_COLOR: Color = [...LIGHT_BLUE, 0.15 * 255];
const TRANSPARENT: Color = [0, 0, 0, 0];

export function createEditableLayer(props: EditorProps | null) {
  if (props == null) return null;

  const { geojson, selectedFeatureIndices, setGeoJson, selectFeatures } = props;
  const mode = nebulaMode(props.mode);
  const isEditing = !READONLY_MODES.includes(mode);

  function handleClick({ index }: PickInfo) {
    if (mode !== EDITOR_MODES.select) return;

    selectFeatures?.(
      selectedFeatureIndices.includes(index)
        ? selectedFeatureIndices.filter((x) => x !== index)
        : [...selectedFeatureIndices, index]
    );
  }

  function handleEdit({ updatedData, editType, editContext }: EditAction<FeatureCollection>) {
    // NOTE: update internal state for in-progress edits
    // @ts-ignore
    this.data = updatedData;

    if (EDIT_EVENTS.has(editType)) {
      setGeoJson?.(updatedData);
    }
    if (editType === "addFeature") {
      selectFeatures?.([...selectedFeatureIndices, ...editContext.featureIndexes]);
    }
  }

  return new EditableGeoJsonLayer({
    data: geojson,
    selectedFeatureIndexes: selectedFeatureIndices,
    mode: mode,
    modeConfig: {
      screenSpace: true,
      viewport: {},
      enableSnapping: true,
    },
    onEdit: handleEdit,
    onClick: handleClick,
    pickable: mode !== EDITOR_MODES.view,

    // line & handle size
    getRadius: 5,
    getLineWidth: 1.5,
    getTentativeLineWidth: 1.5,

    // colours
    getFillColor: (feature, isSelected, mode) =>
      mode === EDITOR_MODES.view
        ? TRANSPARENT
        : isSelected
        ? FILL_COLOR
        : [...MUTED_BLUE, 0.15 * 255],
    getLineColor: (feature, isSelected, mode) => (isSelected ? LINE_COLOR : [...MUTED_BLUE, 255]),
    getTentativeLineColor: LINE_COLOR,
    getEditHandlePointOutlineColor: LINE_COLOR,
    getTentativeFillColor: FILL_COLOR,
    getEditHandlePointColor: TRANSPARENT,

    // @ts-ignore
    getDashArray: isEditing ? [4, 2] : [0, 0],
    extensions: [new PathStyleExtension({ dash: true })],
  });
}

const EDIT_EVENTS = Object.freeze(
  new Set([
    "addPosition",
    "removePosition",
    "addFeature",
    "finishMovePosition",
    "scaled",
    "rotated",
    "translated",
    "extruded",
    "split",
  ])
);

class TranslateModifyMode extends CompositeMode {
  constructor(modes = [new TranslateMode(), new ModifyMode()]) {
    super(modes);
  }

  // avoid losing translate cursor
  handlePointerMove(event: PointerMoveEvent, props: ModeProps<any>): void {
    const cursors: Array<string | null | undefined> = [];
    const setCursor = (cursor: string | null | undefined) => cursors.unshift(cursor);

    const _props = { ...props, onUpdateCursor: setCursor };
    this._modes.forEach((mode) => mode.handlePointerMove(event, _props));

    props.onUpdateCursor(cursors.find((cursor) => cursor != null));
  }
}

class SelectMode extends ViewMode {
  handlePointerMove(event: PointerMoveEvent, props: ModeProps<any>): void {
    const isPicked = event?.picks?.length !== 0;
    props.onUpdateCursor(isPicked ? "pointer" : null);
  }
}

const EDITOR_MODES: Record<EditorMode, typeof GeoJsonEditMode> = Object.seal({
  view: ViewMode,
  select: SelectMode,
  modify: TranslateModifyMode,
  linestring: DrawLineStringMode,
  point: DrawPointMode,
  polygon: DrawPolygonMode,
  lasso: DrawPolygonByDraggingMode,
});

const READONLY_MODES = [EDITOR_MODES.view, EDITOR_MODES.select];

function nebulaMode(mode?: EditorMode) {
  return EDITOR_MODES[mode ?? "view"] ?? EDITOR_MODES.view;
}
