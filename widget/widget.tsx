import React from "react";
import ReactDOM from "react-dom";
import { App } from "./app";
import { LayerProps } from "./layer";

const binding: HTMLWidgets.Binding = {
  name: "rdeck",
  type: "output",
  factory(el, width, height) {
    function render({ props, layers, theme }: RDeckProps) {
      ReactDOM.render(<App {...{ props, layers, theme, width, height }} />, el);
    }

    return {
      renderValue({ props, layers, theme }) {
        render({ props, layers, theme });

        /* TODO: move to app.tsx */
        if (HTMLWidgets.shinyMode) {
          /* update layer */
          Shiny.addCustomMessageHandler(`${el.id}:layer`, (layer: LayerProps) => {
            layers = mergeLayers(layers, layer);
            render({ props, layers, theme });
          });

          /* update map */
          Shiny.addCustomMessageHandler(`${el.id}:map`, (data: RDeckProps) => {
            props = { ...props, ...data.props };
            theme = data.theme;

            render({ props, layers, theme });
          });
        }
      },
      /* deck.gl handles resize automatically */
      resize(width, height) {},
    };
  },
};

function mergeLayers(layers: LayerProps[], layer: LayerProps) {
  const _layer = layers.find((x) => x.id === layer.id);
  if (!_layer) {
    return [...layers, layer];
  }

  // layer.data === undefined ? use value from props
  return layers.map((x) =>
    x !== _layer
      ? x
      : {
          ...layer,
          data: layer.data !== undefined ? layer.data : _layer.data,
        }
  );
}

/* register widget */
HTMLWidgets.widget(binding);
export default binding;
