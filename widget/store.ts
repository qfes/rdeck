import type { Effect, InitialViewStateProps, PickInfo, ViewStateChangeParams } from "@deck.gl/core";
import type { EditAction } from "@nebula.gl/edit-modes";
import type { FeatureCollection, Geometry, GeoJsonProperties } from "geojson";
import type { MapProps } from "react-map-gl";

import type { DeckProps } from "./deck";
import type { EditorProps } from "./editor";
import type { LayerProps, VisibilityInfo } from "./layer";
import type { EditorMode } from "./types";
import { ChangeHandler, Observable, observable } from "./utils";

const GLOBE: InitialViewStateProps = {
  longitude: 0,
  latitude: 0,
  zoom: 0,
  pitch: 0,
  bearing: 0,
};

export class DeckState implements DeckProps {
  useDevicePixels?: number | boolean;
  pickingRadius?: number;
  blendingMode?: BlendingMode;
  effects?: Effect[];
  controller?: boolean;
  initialViewState?: InitialViewStateProps = GLOBE;
  initialBounds?: Bounds;

  onViewStateChange?: (params: ViewStateChangeParams) => any;
  onClick?: (info: PickInfo, event: MouseEvent) => void;

  constructor(props?: Partial<DeckProps>) {
    Object.assign(this, props);
  }
}

export class MapState implements MapProps {
  mapboxAccessToken?: string;
  mapStyle?: string;
  reuseMaps?: boolean = true;

  constructor(props?: Partial<MapProps>) {
    Object.assign(this, props);
  }
}

const EMPTY_GEOJSON: FeatureCollection = Object.freeze({
  type: "FeatureCollection",
  features: [],
});

export class EditorState implements EditorProps {
  mode: EditorMode = "view";
  geojson: FeatureCollection<Geometry, GeoJsonProperties> = EMPTY_GEOJSON;
  selectedFeatureIndices: number[] = [];

  constructor(props?: Partial<EditorProps>) {
    Object.assign(this, props);

    this.setMode = this.setMode.bind(this);
    this.selectFeatures = this.selectFeatures.bind(this);
    this.setGeoJson = this.setGeoJson.bind(this);
    this.deleteSelected = this.deleteSelected.bind(this);
    this.download = this.download.bind(this);
  }

  setMode(mode: EditorMode): void {
    this.mode = mode;
  }

  selectFeatures(featureIndices: number[]): void {
    this.selectedFeatureIndices = featureIndices;
  }

  setGeoJson(geojson: FeatureCollection): void {
    this.geojson = geojson;
  }

  deleteSelected(selectedIndices: number[] = [0]): void {
    const features = this.geojson.features.filter((_, i) => !selectedIndices.includes(i));
    Object.assign(this, {
      mode: this.mode === "modify" ? "view" : this.mode,
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
  }
}

export class Store implements Observable {
  theme: "kepler" | "light" = "kepler";

  #deckgl = new DeckState();
  get deckgl() {
    return this.#deckgl;
  }

  set deckgl(value) {
    this.#deckgl = observable(new DeckState(value), this.#emitChange);
  }

  #mapgl = new MapState();
  get mapgl() {
    return this.#mapgl;
  }

  set mapgl(value) {
    this.#mapgl = observable(new MapState(value), this.#emitChange);
  }

  layers: LayerProps[] = [];
  layerSelector = false;
  lazyLoad = false;

  #editor: EditorState | null = null;
  get editor() {
    return this.#editor;
  }

  set editor(value) {
    this.#editor = value != null ? observable(new EditorState(value), this.#emitChange) : null;
  }

  onChange?: ChangeHandler;
  readonly #emitChange = () => this.onChange?.();

  constructor(state: Partial<Store> = {}, onChange?: ChangeHandler) {
    this.setState(state);

    Reflect.defineProperty(this, "onChange", {
      configurable: false,
      enumerable: false,
      value: onChange,
      writable: true,
    });

    this.setLayerVisibility = this.setLayerVisibility.bind(this);

    // observe all properties
    observable(this, this.#emitChange);
  }

  setState({ deckgl, mapgl, editor, ...state }: Partial<Store> = {}) {
    Object.assign(this, {
      ...state,
      // merge objects
      deckgl: { ...this.deckgl, ...deckgl },
      mapgl: { ...this.mapgl, ...mapgl },
    });

    if (editor !== undefined) {
      // @ts-ignore
      this.editor = editor != null ? { ...this.editor, ...editor } : null;
    }
  }

  upsertLayer(layer: LayerProps): void {
    const existing = this.layers.find((x) => x.id === layer.id);
    // append if not found
    if (existing == null) {
      this.layers = [...this.layers, layer];
      return;
    }

    // merge existing
    const merged = {
      ...existing,
      ...layer,
      // if visible is null, use existing
      visible: layer.visible ?? existing?.visible,
      // if data is not supplied / is falsey from shiny, use existing
      data: layer.data ?? existing?.data ?? null,
    };

    // update
    this.layers = this.layers.map((x) => (x === existing ? merged : x));
  }

  /**
   * Set layers' visibility. Layers not included in visibility are unaltered.
   * @param layersVisibility the layers whose visibility is to be changed
   */
  setLayerVisibility(layersVisibility: VisibilityInfo[]): void {
    if (layersVisibility.length === 0) return;

    const isMatch = (layerVisiblity: VisibilityInfo, layer: LayerProps) => {
      const nameEqual = layerVisiblity.name === layer.name;
      const groupEqual = layerVisiblity.groupName === layer.groupName;

      return (
        (nameEqual && groupEqual) ||
        // all layers in a group
        (layerVisiblity.name == null && layerVisiblity.groupName != null && groupEqual)
      );
    };

    this.layers = this.layers.map((layer) => {
      const visibility = layersVisibility.find(
        (x) => isMatch(x, layer) && x.visible !== layer.visible
      );
      return visibility ? { ...layer, visible: visibility.visible } : layer;
    });
  }
}
