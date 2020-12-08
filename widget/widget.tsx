import React from "react";
import ReactDOM from "react-dom";
import { App } from "./app";

const binding: HTMLWidgets.Binding = {
  name: "rdeck",
  type: "output",
  factory(el, width, height) {
    return {
      renderValue({ props, layers, theme }) {
        ReactDOM.render(<App {...{ props, layers, theme, el, width, height }} />, el);
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
