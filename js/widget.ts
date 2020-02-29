import { DeckGL, WebMercatorViewport } from "@deck.gl/core";
import Layer from "./layer";

const binding: HTMLWidgets.Binding = {
  name: "rdeck",
  type: "output",
  factory(el, width, height) {
    let _deckgl: DeckGL;
    return {
      get deckgl() {
        return _deckgl;
      },
      renderValue({ props, layers }) {
        /* initial bounds */
        if ("initialBounds" in props) {
          let viewport = new WebMercatorViewport({ width, height });
          props.initialViewState = viewport.fitBounds(props.initialBounds);
        }

        _deckgl = new DeckGL({
          container: el,
          ...props,
          layers: layers.map(Layer.create)
        });
      },
      /* deck.gl handles resize automatically */
      resize(widgth, height) {}
    };
  }
};

/* register widget */
// @ts-ignore
HTMLWidgets.widget(binding);

export default binding;
