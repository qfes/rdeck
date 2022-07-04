import type { FeatureCollection, GeoJsonProperties, Geometry } from "geojson";

import { download, equal } from "../utils";
import type { EditorProps } from "../editor";
import type { EditorMode } from "../types";

const EMPTY_GEOJSON: FeatureCollection = Object.freeze({
  type: "FeatureCollection",
  features: [],
});

export class EditorState implements Partial<EditorProps> {
  mode: EditorMode = "view";
  geojson: FeatureCollection = EMPTY_GEOJSON;
  selectedFeatureIndices: number[] = [];
  // handlers
  onSetMode = (mode: EditorMode) => this.setMode(mode);
  onSelectFeatures = (featureIndices: number[]) => this.selectFeatures(featureIndices);
  onSetGeoJson = (geojson: FeatureCollection) => this.setGeoJson(geojson);
  onDeleteSelected = (selectedIndices: number[]) => this.deleteSelected(selectedIndices);
  onUpload = (geojson: FeatureCollection) => {};
  onDownload = (geojson: FeatureCollection) => this.download(geojson);

  constructor(props?: Partial<EditorProps>) {
    Object.assign(this, props);
  }

  setState(state: Partial<EditorState> = {}) {
    Object.assign(this, state);
  }

  setMode(mode: EditorMode): void {
    switch (mode) {
      case "modify":
        this.mode = this.selectedFeatureIndices?.length ? "modify" : "view";
        break;
      case "select":
        this.mode = this.geojson?.features.length ? "select" : "view";
        break;
      default:
        this.mode = mode;
        break;
    }
  }

  selectFeatures(featureIndices: number[]): void {
    this.selectedFeatureIndices = featureIndices;
  }

  setGeoJson(geojson: FeatureCollection): void {
    this.geojson = geojson;
  }

  deleteSelected(selectedIndices: number[]): void {
    const features = this.geojson.features.filter((_, i) => !selectedIndices.includes(i));
    Object.assign(this, {
      mode: ["modify", "transform"].includes(this.mode) ? "view" : this.mode,
      selectedFeatureIndices: [],
      geojson: {
        ...this.geojson,
        features,
      },
    });
  }

  // FIXME: migrate from widget
  upload?: (geojson: FeatureCollection) => void;

  download(geojson: FeatureCollection): void {
    const data = new Blob([JSON.stringify(geojson)], { type: "application/geo+json" });
    download(data, "rdeck.geojson");
    this.setMode("view");
  }
}

type ChangeProps = Pick<EditorProps, "mode" | "geojson" | "selectedFeatureIndices">;
export class UndoableEditorState extends EditorState {
  #current: number = -1;
  readonly #history: ChangeProps[] = [];

  get canUndo() {
    return this.#current > 0;
  }

  get canRedo() {
    return this.#current < this.#history.length - 1;
  }

  onUndo = () => this.undo();
  onRedo = () => this.redo();

  constructor(props?: Partial<EditorProps>) {
    super(props);
    this.#pushChange();
  }

  #pushChange(change: ChangeProps = this) {
    const newState = pick(change);
    const currentState = this.#history[this.#current];

    if (equal(newState, currentState)) return;

    // delete future values
    this.#history.length = this.#current + 1;
    // push change onto history stack
    this.#current = this.#history.push(newState) - 1;
  }

  #updateCurrentState(change: ChangeProps = this) {
    this.#history[this.#current] = pick(change);
  }

  undo() {
    if (!this.canUndo) return;

    this.#current -= 1;
    Object.assign(this, this.#history[this.#current]);
  }

  redo() {
    if (!this.canRedo) return;

    this.#current += 1;
    Object.assign(this, this.#history[this.#current]);
  }

  setState(state?: Partial<EditorState>): void {
    super.setState(state);
    this.#updateCurrentState();
  }

  setMode(mode: EditorMode): void {
    super.setMode(mode);
    this.#updateCurrentState();
  }

  selectFeatures(featureIndices: number[]): void {
    super.selectFeatures(featureIndices);
    this.#updateCurrentState();
  }

  setGeoJson(geojson: FeatureCollection<Geometry, GeoJsonProperties>): void {
    super.setGeoJson(geojson);
    this.#pushChange();
  }

  deleteSelected(selectedIndices: number[]): void {
    super.deleteSelected(selectedIndices);
    this.#pushChange();
  }
}

function pick({ mode, geojson, selectedFeatureIndices }: ChangeProps): ChangeProps {
  return { mode, geojson, selectedFeatureIndices };
}
