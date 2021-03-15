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

    return new RDeckWidget(el, width, height);
  },
};

type LayersVisibility = Record<string, boolean>;

class RDeckWidget implements HTMLWidgets.Widget {
  props: DeckProps = { blendingMode: "normal" };
  layers: LayerProps[] = [];
  theme: "kepler" | "light" = "kepler";
  lazyLoad: boolean = false;

  constructor(private readonly el: HTMLElement, private width: number, private height: number) {
    if (HTMLWidgets.shinyMode) {
      // update layers
      Shiny.addCustomMessageHandler(`${el.id}:layer`, (layer: LayerProps) => {
        const _layer = this.layers.find((x) => x.id === layer.id);
        if (!_layer) {
          this.layers = [...this.layers, layer];
          return this.render();
        }

        const merged = { ..._layer, ...layer, data: layer.data ?? _layer.data };
        this.layers = this.layers.map((x) => (x === _layer ? merged : x));
        this.render();
      });

      // update map
      Shiny.addCustomMessageHandler(`${el.id}:deck`, ({ props, theme, lazyLoad }: RDeckProps) => {
        this.props = { ...this.props, ...props };
        this.theme = theme ?? this.theme;
        this.lazyLoad = lazyLoad ?? this.lazyLoad;
        this.render();
      });
    }
  }

  renderValue({ props, layers, theme, lazyLoad }: AppProps) {
    this.props = Object.freeze(props);
    // @ts-ignore
    this.layers = Object.freeze(layers);
    this.theme = theme;
    this.lazyLoad = lazyLoad;
    this.render();
  }

  // deck.gl handles resize automatically
  resize(width: number, height: number) {}

  /**
   * Set layers' visibility
   * @param visibility the new layer visibility
   */
  setLayersVisibility(visibility: LayersVisibility) {
    this.layers = this.layers.map((x) => ({ ...x, visible: visibility[x.name] ?? true }));
    this.render();
  }

  private render() {
    const { props, layers, theme, lazyLoad, width, height } = this;
    ReactDOM.render(<App {...{ props, layers, theme, lazyLoad, width, height }} />, this.el);
  }
}

/* register widget */
HTMLWidgets.widget(binding);
