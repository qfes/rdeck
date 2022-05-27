import { createRoot, Root } from "react-dom/client";
import type { InitialViewStateProps, PickInfo } from "@deck.gl/core";
import { RDeck, RDeckProps, DeckProps } from "./rdeck";
import type { LayerProps } from "./layer";
import { debounce, pick } from "./util";
import { getViewState } from "./viewport";
import { getPickedObject } from "./picking";

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

type WidgetProps = Pick<RDeckProps, "props" | "layers" | "theme" | "layerSelector" | "lazyLoad">;

export class Widget implements HTMLWidgets.Widget, WidgetProps {
  #el: HTMLElement;
  props: DeckProps = { blendingMode: "normal" };
  layers: LayerProps[] = [];
  theme: "kepler" | "light" = "kepler";
  layerSelector: boolean = true;
  lazyLoad: boolean = false;
  #root: Root;

  constructor(el: HTMLElement, width: number, height: number) {
    this.#el = el;
    this.#root = createRoot(el);
    this.onClick = this.onClick.bind(this);
    this.onViewStateChange = this.onViewStateChange.bind(this);

    if (HTMLWidgets.shinyMode) {
      const debouncedRender = debounce((props = {}) => this.renderValue(props), 50);

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

        debouncedRender({ layers: this.layers });
      });

      // update map
      Shiny.addCustomMessageHandler(`${el.id}:deck`, ({ props, theme, lazyLoad }: RDeckProps) => {
        this.renderValue({
          props: { ...this.props, ...props },
          theme: theme,
          lazyLoad: lazyLoad,
        });
      });
    }

    this.setLayerVisibility = this.setLayerVisibility.bind(this);
  }

  renderValue({ props, layers, theme, layerSelector, lazyLoad }: Partial<WidgetProps> = {}) {
    // merge in new props with existing state
    const _props = {
      props: {
        ...this.props,
        ...props,
        onClick: this.onClick,
        onViewStateChange: debounce(this.onViewStateChange, 50),
      },
      layers: layers ?? this.layers,
      theme: theme ?? this.theme,
      layerSelector: layerSelector ?? this.layerSelector,
      lazyLoad: lazyLoad ?? this.lazyLoad,
    };

    // overwritten on initialBounds change
    if (_props.props.initialBounds != null) {
      delete _props.props.initialViewState;
    }

    Object.assign(this, _props);

    this.#root.render(<RDeck {..._props} onLayerVisibilityChange={this.setLayerVisibility} />);
  }

  // deck.gl handles resize automatically
  resize(width: number, height: number): void {}

  /**
   * Get widget id
   */
  get id(): string {
    return this.#el.id;
  }

  /**
   * Set layers' visibility. Layers not included in visibility are unaltered.
   * @param visibility the layers visibility
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

  onClick(info: PickInfo<any>) {
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

  onViewStateChange({ viewState }: { viewState: InitialViewStateProps }) {
    if (HTMLWidgets.shinyMode) {
      const data = getViewState(viewState);

      Shiny.setInputValue(`${this.id}_viewstate`, data, { priority: "event" });
    }
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
