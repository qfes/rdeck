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

  constructor(props?: Partial<EditorProps>) {
    Object.assign(this, props);

    this.setMode = this.setMode.bind(this);
    this.setGeoJson = this.setGeoJson.bind(this);
    this.deleteSelected = this.deleteSelected.bind(this);
    this.download = this.download.bind(this);
  }

  setMode(mode: EditorMode): void {
    this.mode = mode;
  }

  setGeoJson(action: EditAction<FeatureCollection<Geometry, GeoJsonProperties>>): void {
    Object.assign(this, {
      mode: action.editType === "addFeature" ? "modify" : this.mode,
      geojson: action.updatedData,
    });
  }

  deleteSelected(selectedIndices: number[] = [0]): void {
    const features = this.geojson.features.filter((_, i) => !selectedIndices.includes(i));
    Object.assign(this, {
      mode: "view",
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

  readonly #deckgl: DeckState;
  get deckgl() {
    return this.#deckgl;
  }

  readonly #mapgl: MapState;
  get mapgl() {
    return this.#mapgl;
  }

  layers: LayerProps[] = [];
  layerSelector: boolean = false;
  lazyLoad: boolean = false;

  readonly #editor: EditorState;
  get editor() {
    return this.#editor;
  }

  onChange?: ChangeHandler;
  readonly #emitChange = () => this.onChange?.();

  constructor(
    { theme, deckgl, mapgl, layers, layerSelector, editor, lazyLoad }: Partial<Store> = {},
    onChange?: ChangeHandler
  ) {
    this.theme = theme ?? "kepler";
    this.layerSelector = layerSelector ?? false;
    this.lazyLoad = lazyLoad ?? false;
    this.layers = layers ?? [];
    this.#deckgl = observable(new DeckState(deckgl), this.#emitChange);
    this.#mapgl = observable(new MapState(mapgl), this.#emitChange);
    this.#editor = observable(new EditorState(editor), this.#emitChange);
    this.setLayerVisibility = this.setLayerVisibility.bind(this);

    Reflect.defineProperty(this, "onChange", {
      configurable: false,
      enumerable: false,
      writable: true,
      value: onChange,
    });
    observable(this, this.#emitChange);
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
