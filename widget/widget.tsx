import ReactDOM from "react-dom";
import { App, AppProps, DeckProps } from "./app";
import type { LayerProps } from "./layer";
import { getElementDimensions } from "./util";

export const binding: HTMLWidgets.Binding = {
  name: "rdeck",
  type: "output",
  factory(el, width, height) {
    // compute el dimensions if initially hidden
    if (width === 0 || height === 0) {
      [width, height] = getElementDimensions(el);
    }

    return new Widget(el, width, height);
  },
};

type LayersVisibility = Record<string, boolean>;
type WidgetProps = Pick<AppProps, "props" | "layers" | "theme" | "lazyLoad">;

export class Widget implements HTMLWidgets.Widget, WidgetProps {
  #el: HTMLElement;
  #width: number;
  #height: number;
  props: DeckProps = { blendingMode: "normal" };
  layers: LayerProps[] = [];
  theme: "kepler" | "light" = "kepler";
  lazyLoad: boolean = false;

  constructor(el: HTMLElement, width: number, height: number) {
    this.#el = el;
    this.#width = width;
    this.#height = height;
    if (HTMLWidgets.shinyMode) {
      // update layers
      Shiny.addCustomMessageHandler(`${el.id}:layer`, (layer: LayerProps) => {
        const _layer = this.layers.find((x) => x.id === layer.id);
        if (!_layer) {
          return this.renderValue({ layers: [...this.layers, layer] });
        }

        const merged = { ..._layer, ...layer, data: layer.data ?? _layer.data };
        const layers = this.layers.map((x) => (x === _layer ? merged : x));
        this.renderValue({ layers });
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
  }

  renderValue({ props, layers, theme, lazyLoad }: Partial<WidgetProps>) {
    // merge in new props with existing state
    const _props = {
      props: props ?? this.props,
      layers: layers ?? this.layers,
      theme: theme ?? this.theme,
      lazyLoad: lazyLoad ?? this.lazyLoad,
    };
    Object.assign(this, _props);

    ReactDOM.render(<App {..._props} width={this.#width} height={this.#height} />, this.#el);
  }

  // deck.gl handles resize automatically
  resize(width: number, height: number) {}

  /**
   * Get widget id
   */
  get id() {
    return this.#el.id;
  }

  /**
   * Set layers' visibility. Layers not included in visibility are unaltered.
   * @param visibility the layers visibility
   */
  setLayerVisibility(visibility: LayersVisibility) {
    const layers = this.layers.map((x) =>
      x.name in visibility ? { ...x, visible: visibility[x.name] } : x
    );

    this.renderValue({ layers });
  }
}

type WidgetContainer = HTMLElement & { htmlwidget_data_init_result: Widget };

/**
 * Get an rdeck widget instance by id
 * @param id the widget id
 * @returns {Widget}
 */
export function getWidgetById(id: string) {
  const element = document.getElementById(id) as WidgetContainer;
  return element?.htmlwidget_data_init_result;
}

/**
 * Get all rdeck widget instances
 */
export function getWidgets() {
  const elements = [...document.querySelectorAll(".rdeck.html-widget")] as WidgetContainer[];
  return elements.map((x) => x.htmlwidget_data_init_result).filter((x) => x instanceof Widget);
}

/* register widget */
HTMLWidgets.widget(binding);
