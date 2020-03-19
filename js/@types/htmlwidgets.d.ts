import { DeckGLProps, DeckGL } from "@deck.gl/core";
import { RDeckLayerProps } from "../layer";

/* exposed global */
export as namespace HTMLWidgets;

export function widget(definition: Binding): void;

export interface Binding {
  name: string;
  type: "output";
  sizing?: object;

  factory(el: Element, width: number, height: number): Widget;
}

export interface Widget {
  readonly deckgl: DeckGL;
  renderValue(x: { props: DeckGLProps; layers: RDeckLayerProps[] }): void;
  resize(width: number, height: number): void;
}
