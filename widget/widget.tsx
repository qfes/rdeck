import { createRoot, Root } from "react-dom/client";
import type { InitialViewStateProps, PickInfo } from "@deck.gl/core";
import { EditAction } from "@nebula.gl/edit-modes";
import type { FeatureCollection } from "geojson";
import { RDeck, RDeckProps, DeckProps } from "./rdeck";
import type { LayerProps } from "./layer";
import type { EditorMode } from "./types";
import { debounce, pick } from "./util";
import { getViewState } from "./viewport";
import { getPickedObject } from "./picking";
import { EditorProps } from "./editor";

export const binding: HTMLWidgets.Binding = {
  name: "rdeck",
  type: "output",
  factory(el, width, height) {
    return new Widget(el, width, height);
  },
};

type LayerVisibilityProps = Pick<LayerProps, "groupName" | "visible"> & {
  name: string | null;
};

type WidgetProps = Omit<RDeckProps, "onLayerVisibilityChange">;

export class Widget implements HTMLWidgets.Widget, WidgetProps {
  readonly #element: HTMLElement;
  readonly #root: Root;

  props: DeckProps = { blendingMode: "normal" };
  layers: LayerProps[] = [];
  theme: "kepler" | "light" = "kepler";
  layerSelector: boolean = true;
  lazyLoad: boolean = false;
  editor: EditorProps | null = null;

  constructor(el: HTMLElement, width: number, height: number) {
    this.#element = el;
    this.#root = createRoot(el);

    // event handlers
    this.handleClick = this.handleClick.bind(this);
    this.handleViewStateChange = debounce(this.handleViewStateChange.bind(this), 50);
    this.setLayerVisibility = this.setLayerVisibility.bind(this);
    this.handleEditorModeChange = this.handleEditorModeChange.bind(this);
    this.handleEditorGeoJsonChange = this.handleEditorGeoJsonChange.bind(this);
    this.handleEditorDeleteSelected = this.handleEditorDeleteSelected.bind(this);
    this.handleEditorDownload = this.handleEditorDownload.bind(this);
    this.handleEditorUpload = this.handleEditorUpload.bind(this);

    if (HTMLWidgets.shinyMode) {
      const render = debounce((props) => this.renderValue(props), 50);

      // update layers
      Shiny.addCustomMessageHandler(`${el.id}:layer`, (layer: LayerProps) => {
        const _layer = this.layers.find((x) => x.id === layer.id);
        const merged = {
          ..._layer,
          ...layer,
          // if visible is null, use existing
          visible: layer.visible ?? _layer?.visible,
          // if data is not supplied / is falsey from shiny, use existing
          data: layer.data ?? _layer?.data ?? null,
        };

        // upsert
        this.layers =
          _layer == null
            ? [...this.layers, merged]
            : this.layers.map((x) => (x === _layer ? merged : x));

        render({ layers: this.layers });
      });

      // update map
      Shiny.addCustomMessageHandler(`${el.id}:deck`, (props: RDeckProps) => {
        this.renderValue(props);
      });
    }
  }

  renderValue({
    props = this.props,
    layers = this.layers,
    theme = this.theme,
    layerSelector = this.layerSelector,
    editor = this.editor,
    lazyLoad = this.lazyLoad,
  }: Partial<WidgetProps> = {}) {
    // merge props
    props = {
      ...this.props,
      ...props,
      onClick: this.handleClick,
      onViewStateChange: this.handleViewStateChange,
    };

    // overwritten on initialBounds change
    if (props.initialBounds != null) {
      delete props.initialViewState;
    }

    if (editor != null) {
      editor = {
        ...editor,
        geojson: editor.geojson ?? { type: "FeatureCollection", features: [] },
        setMode: this.handleEditorModeChange,
        setGeoJson: this.handleEditorGeoJsonChange,
        deleteSelected: this.handleEditorDeleteSelected,
        upload: this.handleEditorUpload,
        download: this.handleEditorDownload,
      };
    }

    Object.assign(this, { props, layers, theme, layerSelector, editor, lazyLoad });

    this.#root.render(
      <RDeck
        {...{ props, layers, theme, layerSelector, editor, lazyLoad }}
        onLayerVisibilityChange={this.setLayerVisibility}
      />
    );
  }

  // deck.gl handles resize automatically
  resize(width: number, height: number): void {}

  /**
   * Get widget id
   */
  get id(): string {
    return this.#element.id;
  }

  /**
   * Set layers' visibility. Layers not included in visibility are unaltered.
   * @param layers the layers whose visibility is to be changed
   */
  setLayerVisibility(layers: LayerVisibilityProps[]): void {
    if (layers.length === 0) return;

    const isMatch = (layerVisiblity: LayerVisibilityProps, layer: LayerProps) => {
      const nameEqual = layerVisiblity.name === layer.name;
      const groupEqual = layerVisiblity.groupName === layer.groupName;

      return (
        (nameEqual && groupEqual) ||
        // all layers in a group
        (layerVisiblity.name == null && layerVisiblity.groupName != null && groupEqual)
      );
    };

    const _layers = this.layers.map((layer) => {
      const _layer = layers.find((x) => isMatch(x, layer) && x.visible !== layer.visible);
      return _layer ? { ...layer, visible: _layer.visible } : layer;
    });

    this.renderValue({ layers: _layers });
  }

  // event handlers
  private handleClick(info: PickInfo<any>): void {
    if (HTMLWidgets.shinyMode) {
      const data = {
        coordinate: info.coordinate,
        ...getViewState(info.viewport),
        layer: pick(info.layer?.props, "id", "name", "groupName"),
        object: getPickedObject(info),
      };

      Shiny.setInputValue(`${this.id}_click`, data, { priority: "event" });
    }
  }

  private handleViewStateChange({ viewState }: { viewState: InitialViewStateProps }): void {
    if (HTMLWidgets.shinyMode) {
      const data = getViewState(viewState);

      Shiny.setInputValue(`${this.id}_viewstate`, data, { priority: "event" });
    }
  }

  private handleEditorModeChange(mode: EditorMode): void {
    if (this.editor == null) return;

    this.renderValue({
      editor: { ...this.editor, mode },
    });
  }

  private handleEditorGeoJsonChange({
    updatedData,
    editType,
  }: EditAction<FeatureCollection>): void {
    if (this.editor == null) return;

    const editMap: Record<string, EditorMode> = {
      addFeature: "modify",
      deleteFeature: "view",
    };

    this.renderValue({
      editor: { ...this.editor, mode: editMap[editType] ?? this.editor.mode, geojson: updatedData },
    });
  }

  private handleEditorDeleteSelected(selectedIndices: number[] = [0]): void {
    if (this.editor == null) return;

    const features = this.editor.geojson.features.filter((_, i) => !selectedIndices.includes(i));

    this.renderValue({
      editor: { ...this.editor, geojson: { type: "FeatureCollection", features } },
    });
  }

  private handleEditorUpload(geojson: FeatureCollection): void {
    if (this.editor != null && HTMLWidgets.shinyMode) {
      // we need to parse the json with geojsonsf
      Shiny.setInputValue(`${this.id}_editedpolygon`, {
        polygon: JSON.stringify(geojson),
      });
    }
  }

  private handleEditorDownload(geojson: FeatureCollection): void {
    if (this.editor == null) return;

    const data = new Blob([JSON.stringify(geojson)], { type: "application/geo+json" });
    // download
    const el = document.createElement("a");
    el.href = URL.createObjectURL(data);
    el.download = "rdeck.geojson";
    el.click();
  }
}

type WidgetContainer = HTMLElement & { htmlwidget_data_init_result: Widget };

/**
 * Get an rdeck widget instance by id
 * @param id the widget id
 * @returns {Widget}
 */
export function getWidgetById(id: string): Widget | null {
  const element = document.getElementById(id) as WidgetContainer | null;
  return element?.htmlwidget_data_init_result ?? null;
}

/**
 * Get all rdeck widget instances
 */
export function getWidgets(): Widget[] {
  const elements = [...document.querySelectorAll(".rdeck.html-widget")] as WidgetContainer[];
  return elements.map((x) => x.htmlwidget_data_init_result).filter((x) => x instanceof Widget);
}

/* register widget */
HTMLWidgets.widget(binding);
