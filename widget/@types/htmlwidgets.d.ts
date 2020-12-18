import { AppProps } from "../app";

/* exposed global */
export as namespace HTMLWidgets;

export function widget(definition: Binding): void;

export interface Binding {
  name: string;
  type: "output";
  sizing?: object;

  factory(el: HTMLElement, width: number, height: number): Widget;
}

export interface Widget {
  renderValue(x: RDeckProps): void;
  resize(width: number, height: number): void;
}

export const shinyMode: boolean;
