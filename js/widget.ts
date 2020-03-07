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
        if ("initialBounds" in props) {
          let viewport = new WebMercatorViewport({ width, height });
          props.initialViewState = viewport.fitBounds(props.initialBounds);
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

  const rows = entries
    .map(
      ([key, value]) =>
        `<tr><td class="col-name">${key}</td><td class = "col-value">${value}</td></tr>`
    )
    .join("");
  return {
    html: `<div class="layer-name">${name}</div><table><tbody>${rows}</tbody></table>`
  };
}

/* register widget */
// @ts-ignore
HTMLWidgets.widget(binding);

export default binding;
