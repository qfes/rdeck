import { PathStyleExtension } from "@deck.gl/extensions";
import {
  ViewMode,
  CompositeMode,
  ModifyMode,
  TranslateMode,
  DrawPolygonMode,
  DrawPolygonByDraggingMode,
  EditAction,
  ModeProps,
  PointerMoveEvent,
} from "@nebula.gl/edit-modes";
import type { FeatureCollection } from "geojson";
import { EditableGeoJsonLayer } from "nebula.gl";
import type { EditorPanelProps } from "./controls";
import type { EditorMode } from "./types";

export type EditorProps = EditorPanelProps & {
  setGeoJson?: (action: EditAction<FeatureCollection>) => void;
};

const LIGHT_BLUE = [3, 169, 244] as const;
const LINE_COLOR: Color = [...LIGHT_BLUE, 255];
const FILL_COLOR: Color = [...LIGHT_BLUE, 0.1 * 255];
const TRANSPARENT: Color = [0, 0, 0, 0];

export function createEditableLayer(props: EditorProps | null) {
  if (props == null) return null;

  const { mode, geojson, setGeoJson } = props;

  return new EditableGeoJsonLayer({
    data: geojson,
    selectedFeatureIndexes: [0],
    mode: nebulaMode(mode),
    modeConfig: {
      screenSpace: true,
      viewport: {},
    },
    onEdit: handleEdit(setGeoJson),

    // line & handle size
    getRadius: 5,
    getLineWidth: 2,
    getTentativeLineWidth: 2,

    // colours
    getFillColor: mode === "view" ? TRANSPARENT : FILL_COLOR,
    getLineColor: LINE_COLOR,
    getTentativeLineColor: LINE_COLOR,
    getEditHandlePointOutlineColor: LINE_COLOR,
    getTentativeFillColor: FILL_COLOR,
    getEditHandlePointColor: TRANSPARENT,

    // @ts-ignore
    getDashArray: mode === "view" ? [0, 0] : [4, 2],
    extensions: [new PathStyleExtension({ dash: true })],
  });
}

type EditHandler = (action: EditAction<FeatureCollection>) => void;

// wrapper for EditableGeoJsonLayer.props.onEdit. avoid unnecessary re-renders
function handleEdit(onEdit?: EditHandler) {
  return function ({ updatedData, editType, editContext }: EditAction<FeatureCollection>) {
    // drawing a new polygon? delete any current polygons
    if (editType === "updateTentativeFeature" && updatedData.features.length !== 0) {
      updatedData.features.length = 0;
    }

    // @ts-ignore
    this.data = updatedData;

    if (EDIT_EVENTS.has(editType)) {
      onEdit?.({ updatedData, editType, editContext });
    }
  };
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

const EDITOR_MODES = Object.seal({
  view: new ViewMode(),
  modify: new TranslateModifyMode(),
  polygon: new DrawPolygonMode(),
  lasso: new DrawPolygonByDraggingMode(),
});

function nebulaMode(mode?: EditorMode) {
  return EDITOR_MODES[mode ?? "view"] ?? EDITOR_MODES.view;
}
