import React from "react";
import ReactDOM from "react-dom";
import { WebMercatorViewport } from "react-map-gl";
import DeckGL from "deck.gl";
import RDeck from "./rdeck";

import styles from "./rdeck.css";

const binding: HTMLWidgets.Binding = {
  name: "rdeck",
  type: "output",
  factory(el, width, height) {
    el.classList.add(styles.rdeck);
    const ref = React.createRef<DeckGL>();
    return {
      get deckgl() {
        return ref.current;
      },
      renderValue({ props, layers }) {
        // TODO: move to RDeck
        if (Array.isArray(props.initialBounds)) {
          const viewport = new WebMercatorViewport({ width, height });
          const { longitude, latitude, zoom } = viewport.fitBounds([
            props.initialBounds.slice(0, 2),
            props.initialBounds.slice(2, 4),
          ]);

          props.initialViewState = {
            ...props.initialViewState,
            longitude,
            latitude,
            zoom,
          };
        }
        ReactDOM.render(<RDeck {...{ ref, props, layers }} />, el);
      },
      /* deck.gl handles resize automatically */
      resize(width, height) {},
    };
  },
};

/* register widget */
// @ts-ignore
HTMLWidgets.widget(binding);
export default binding;
