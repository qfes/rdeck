import { DeckGL, PickInfo, WebMercatorViewport } from "@deck.gl/core";
import Layer from "./layer";
import "./widget.css";
import { LayerProps } from "@deck.gl/core/lib/layer";

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

        _deckgl = new DeckGL({
          container: el,
          ...props,
          layers: layers.map(Layer.create),
          getTooltip
        });
      },
      /* deck.gl handles resize automatically */
      resize(width, height) {}
    };
  }
};

function getTooltip(info: PickInfo<any>) {
  if (!(info.picked && info.handled)) return;
  let { name, entries } = info.handled;

  const row = ([key, value]: [string, any]) =>
    `<tr><td class="col-name">${key}</td><td class="col-value">${value}</td></tr>`;

  const rows = entries.map(row).join("");
  return {
    html: `<div class="layer-name">${name}</div><table><tbody>${rows}</tbody></table>`
  };
}

/* register widget */
// @ts-ignore
HTMLWidgets.widget(binding);

export default binding;
