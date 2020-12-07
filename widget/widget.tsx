import React from "react";
import ReactDOM from "react-dom";

import { App } from "./app";
import styles from "./app.css";

const binding: HTMLWidgets.Binding = {
  name: "rdeck",
  type: "output",
  factory(el, width, height) {
    el.classList.add(styles.rdeck);
    return {
      renderValue({ props, layers }) {
        ReactDOM.render(<App {...{ props, layers, width, height }} />, el);
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
