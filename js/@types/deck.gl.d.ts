declare module "@deck.gl/core" {
  import { Deck, DeckProps } from "@deck.gl/core";
  import { PickInfo } from "@deck.gl/core/lib/deck";

  export class DeckGL extends Deck {
    constructor(props: DeckGLProps);
  }

  export interface DeckGLProps extends DeckProps {
    container?: Element | string;
    map?: any;
    mapStyle: string;
    mapboxApiAccessToken: string;
    initialBounds?: [[number, number], [number, number]];
    getTooltip?: (info: PickInfo<any>) => TooltipInfo | undefined | null;
  }

  export interface TooltipInfo {
    html: string;
    className?: string;
    style?: CssProps;
  }

  export interface WebMercatorViewport {
    longitude: number;
    latitude: number;
    zoom: number;
    pitch: number;
    bearing: number;
  }

  export { PickInfo } from "@deck.gl/core/lib/deck";
}

declare module "@deck.gl/core/lib/deck" {
  export interface PickInfo<D> {
    picked?: boolean;
    handled?: { name: string; entries: [[string, any]] };
  }
}

declare module "@deck.gl/core/lib/layer" {
  export interface LayerProps<D> {
    name?: string;
    tooltip?: string[];
  }

  interface Layer<D> {
    props: LayerProps<D>;
  }
}
