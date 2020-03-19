import { DeckGL, WebMercatorViewport } from "@deck.gl/core";
import Layer from "./layer";
import { getTooltip } from "./tooltip";
import "./widget.css";

const binding: HTMLWidgets.Binding = {
  name: "rdeck",
  type: "output",
  factory(el, width, height) {
    let _deckgl: DeckGL;
    let _layers: Layer[];

    return {
      get deckgl() {
        return _deckgl;
      },
      renderValue({ props, layers }) {
        /* initial bounds */
        if (Array.isArray(props.initialBounds)) {
          const viewport = new WebMercatorViewport({ width, height });

          const { longitude, latitude, zoom } = viewport.fitBounds([
            props.initialBounds.slice(0, 2),
            props.initialBounds.slice(2, 4)
          ]);

          props.initialViewState = {
            ...props.initialViewState,
            longitude,
            latitude,
            zoom
          };
        }

        _layers = layers.map(Layer.create);

        _deckgl = new DeckGL({
          container: el,
          ...props,
          layers: _layers.map(x => x.layer),
          getTooltip
        });
      },
      /* deck.gl handles resize automatically */
      resize(width, height) {}
    };
  }
};
/* register widget */
// @ts-ignore
HTMLWidgets.widget(binding);

export default binding;
