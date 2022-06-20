import type { FeatureCollection } from "geojson";

import type { EditorProps } from "../editor";
import type { EditorMode } from "../types";

const EMPTY_GEOJSON: FeatureCollection = Object.freeze({
  type: "FeatureCollection",
  features: [],
});

export class EditorState implements EditorProps {
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
    // download
    const el = document.createElement("a");
    el.href = URL.createObjectURL(data);
    el.download = "rdeck.geojson";
    el.click();

    this.setMode("view");
  }
}
