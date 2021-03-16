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
          this.layers = [...this.layers, layer];
          return this.#render();
        }

        const merged = { ..._layer, ...layer, data: layer.data ?? _layer.data };
        this.layers = this.layers.map((x) => (x === _layer ? merged : x));
        this.#render();
      });

      // update map
      Shiny.addCustomMessageHandler(`${el.id}:deck`, ({ props, theme, lazyLoad }: RDeckProps) => {
        this.props = { ...this.props, ...props };
        this.theme = theme ?? this.theme;
        this.lazyLoad = lazyLoad ?? this.lazyLoad;
        this.#render();
      });
    }
  }

  renderValue({ props, layers, theme, lazyLoad }: WidgetProps) {
    this.props = props;
    this.layers = layers;
    this.theme = theme;
    this.lazyLoad = lazyLoad;
    this.#render();
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
    this.layers = this.layers.map((x) =>
      x.name in visibility ? { ...x, visible: visibility[x.name] } : x
    );

    this.#render();
  }

  #render = () => {
    const { props, layers, theme, lazyLoad } = this;
    const width = this.#width;
    const height = this.#height;
    ReactDOM.render(<App {...{ props, layers, theme, lazyLoad, width, height }} />, this.#el);
  };
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
