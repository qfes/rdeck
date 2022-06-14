import { PathStyleExtension } from "@deck.gl/extensions";
import {
  ViewMode,
  ModifyMode,
  TransformMode,
  DrawPolygonMode,
  DrawPolygonByDraggingMode,
  DrawLineStringMode,
  DrawPointMode,
  utils,
} from "@nebula.gl/edit-modes";
import type {
  GeoJsonEditMode,
  EditAction,
  ModeProps,
  PointerMoveEvent,
  ClickEvent,
} from "@nebula.gl/edit-modes";
import { EditableGeoJsonLayer as _EditableGeoJsonLayer } from "@nebula.gl/layers";
import type { FeatureCollection, Feature } from "geojson";

import type { EditorToolboxProps } from "./controls";
import type { EditorMode } from "./types";
import { isSuperset, difference, union } from "./utils";
import { memoize } from "./util";

export type EditorProps = EditorToolboxProps & {
  setGeoJson?: (geojson: FeatureCollection) => void;
  selectFeatures?: (featureIndices: number[]) => void;
};

const LIGHT_BLUE = [3, 169, 244] as const;
const MUTED_BLUE = [116, 117, 129] as const;

const LINE_COLOR: Color = [...LIGHT_BLUE, 0.85 * 255];
const MUTED_LINE_COLOR: Color = [...MUTED_BLUE, 0.85 * 255];

const FILL_COLOR: Color = [...LIGHT_BLUE, 0.15 * 255];
const MUTED_FILL_COLOR: Color = [...MUTED_BLUE, 0.15 * 255];

const TRANSPARENT: Color = [0, 0, 0, 0];

export function createEditableLayer(props: EditorProps | null) {
  if (props == null) return null;

  const { geojson, selectedFeatureIndices, setGeoJson, selectFeatures } = props;
  const mode = nebulaMode(props.mode);
  const isEditing = !READONLY_MODES.includes(mode);

  function handleEdit({ updatedData, editType, editContext }: EditAction<FeatureCollection>) {
    if (editType === "updateTentativeFeature") return;

    // NOTE: update internal state for in-progress edits
    // @ts-ignore
    this.data = updatedData;

    if (editType === "selectFeature") {
      selectFeatures?.(editContext.selectedIndices ?? []);
      return;
    }

    if (EDIT_EVENTS.has(editType)) {
      setGeoJson?.(updatedData);
      if (editType === "addFeature") {
        selectFeatures?.([...selectedFeatureIndices, ...editContext.featureIndexes]);
      }
    }
  }

  return new EditableGeoJsonLayer({
    data: geojson,
    selectedFeatureIndexes: selectedFeatureIndices,
    mode,
    modeConfig: {
      screenSpace: true,
      viewport: {},
    },
    onEdit: handleEdit,

    // picking
    pickable: mode !== EDITOR_MODES.view,
    pickingLineWidthExtraPixels: 5,
    pickingDepth: 0,

    // line & handle size
    getRadius: 6,
    getLineWidth: 1.5,
    getTentativeLineWidth: 1.5,
    lineWidthScale: 1,

    // colours
    getFillColor: mode === EDITOR_MODES.view ? TRANSPARENT : getFillColor,
    getLineColor: getLineColor,
    getTentativeLineColor: LINE_COLOR,
    getEditHandlePointOutlineColor: LINE_COLOR,
    getTentativeFillColor: FILL_COLOR,
    getEditHandlePointColor: TRANSPARENT,

    // @ts-ignore
    getDashArray: isEditing ? [4, 2] : [0, 0],
    extensions: [new PathStyleExtension({ dash: true })],

    _subLayerProps: {
      geojson: {
        dataComparator: featuresEqual,
        _dataDiff: featuresDiff,
      },
      guides: {
        dataComparator: featuresEqual,
        _dataDiff: featuresDiff,
      },
    },
  });
}

function getFillColor(feature: Feature, isSelected: boolean, mode: EditorMode) {
  return isSelected ? FILL_COLOR : MUTED_FILL_COLOR;
}

function getLineColor(feature: Feature, isSelected: boolean, mode: EditorMode) {
  return isSelected ? LINE_COLOR : MUTED_LINE_COLOR;
}

function featuresEqual(newData: FeatureCollection, oldData: FeatureCollection) {
  return Object.is(newData.features, oldData.features);
}

type DataDiff = { startRow: number; endRow: number };
// optimise updates for the modify-features case
function featuresDiff(newData: FeatureCollection, oldData: FeatureCollection): DataDiff[] | string {
  const newFeatures = newData.features;
  const oldFeatures = oldData.features;

  if (newFeatures.length !== oldFeatures.length) return "A new data container was supplied";

  // modified existing features?
  const diff: DataDiff[] = [];
  const length = newFeatures.length;
  for (let i = 0; i < length; ++i) {
    if (newFeatures[i] !== oldFeatures[i]) {
      diff.push({ startRow: i, endRow: i + 1 });
    }
  }

  return diff;
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

class EditableGeoJsonLayer extends _EditableGeoJsonLayer {
  onPointerMove(event: PointerMoveEvent): void {
    // performance optimisation for pointer move state
    this.state.lastPointerMoveEvent = event;
    const mode = this.getActiveMode();
    // @ts-ignore
    mode.handlePointerMove(event, this.getModeProps(this.props));
  }

  updateState(params: any): void {
    if (!params.changeFlags.propsOrDataChanged) return;
    super.updateState(params);
  }

  setState(updateObject: any): void {
    if (this.props.mode === EDITOR_MODES.modify) return super.setState(updateObject);

    // optimise cursor update in non-modify mode
    for (const key in updateObject) {
      if (key !== "cursor" || updateObject.cursor !== this.state.cursor)
        return super.setState(updateObject);
    }
  }
}

class SelectMode extends ViewMode {
  handlePointerMove(event: PointerMoveEvent, props: ModeProps<any>): void {
    const isPicked = event?.picks?.length !== 0;
    props.onUpdateCursor(isPicked ? "pointer" : null);
  }

  handleClick(event: ClickEvent, props: ModeProps<any>): void {
    const isPicked = event?.picks.length !== 0;
    if (!isPicked) return;

    const current = new Set(props.selectedIndexes);
    const picked = new Set(event.picks.map((x) => x.index));

    // all picked already selected? unselect picked, else select picked
    const selected = isSuperset(current, picked)
      ? difference(current, picked)
      : union(current, picked);

    props.onEdit?.({
      updatedData: props.data,
      editType: "selectFeature",
      editContext: {
        selectedIndices: [...selected],
      },
    });
  }
}

// memoize nebula util function
utils.getEditHandlesForGeometry = memoize(utils.getEditHandlesForGeometry);

const EDITOR_MODES: Record<EditorMode, typeof GeoJsonEditMode> = Object.seal({
  view: ViewMode,
  select: SelectMode,
  modify: ModifyMode,
  transform: TransformMode,
  linestring: DrawLineStringMode,
  point: DrawPointMode,
  polygon: DrawPolygonMode,
  lasso: DrawPolygonByDraggingMode,
});

const READONLY_MODES = [EDITOR_MODES.view, EDITOR_MODES.select];

function nebulaMode(mode?: EditorMode) {
  return EDITOR_MODES[mode ?? "view"] ?? EDITOR_MODES.view;
}
