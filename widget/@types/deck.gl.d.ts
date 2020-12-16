declare module "deck.gl" {
  export { InitialViewStateProps, LayerProps } from "@deck.gl/core";
}

declare module "@deck.gl/core" {
  export { PickInfo, InitialViewStateProps } from "@deck.gl/core/lib/deck";
  export { LayerProps } from "@deck.gl/core/lib/layer";
  import { DeckProps } from "@deck.gl/core/lib/deck";
  type deckProps = "id" | "width" | "height" | "controller" | "viewState";

  export type MapViewProps = Partial<Pick<DeckProps, deckProps>> & {
    x?: string | number;
    y?: string | number;
    repeat?: boolean;
  };
  export interface MapView extends React.Component<MapViewProps> {}
}

declare module "@deck.gl/core/lib/deck" {
  export interface PickInfo<D> {
    picked: boolean | null;
  }
}

declare module "@deck.gl/core/lib/layer" {
  export interface LayerProps<D> {
    name: string | null;
    tooltip: TooltipInfo | null;
  }
}

declare module "@deck.gl/react" {
  export { DeckGLProps } from "@deck.gl/react/deckgl";
}
