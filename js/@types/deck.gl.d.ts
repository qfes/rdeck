declare module "@deck.gl/core" {
  import { Deck, DeckProps } from "@deck.gl/core";
  import { Map } from "mapbox-gl";

  export class DeckGL extends Deck {
    constructor(props: DeckGLProps);
  }

  export interface DeckGLProps extends DeckProps {
    container?: Element | string;
    map?: any;
    mapStyle: string;
    mapboxApiAccessToken: string;
    initialBounds?: [[number, number], [number, number]];
  }
}
