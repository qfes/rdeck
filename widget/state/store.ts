import type { LayerProps, VisibilityInfo } from "../layer";
import { ChangeHandler, observable, Observable } from "../utils";
import { DeckState } from "./deck";
import { UndoableEditorState } from "./editor";
import { MapState } from "./map";

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
  layerSelector = true;

  #editor: UndoableEditorState | null = null;
  get editor() {
    return this.#editor;
  }

  set editor(value) {
    if (value == null) {
      this.#editor = null;
    } else if (this.#editor == null) {
      this.#editor = observable(new UndoableEditorState(value), this.#emitChange);
    } else {
      this.#editor.setState(value);
    }
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
