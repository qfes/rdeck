/* eslint-disable @typescript-eslint/no-unused-vars */

declare module "deck.gl" {
  // @ts-ignore
  export * from "@danmarshall/deckgl-typings/deck.gl";
}

declare module "@deck.gl/core" {
  import { DeckProps } from "@deck.gl/core/lib/deck";
  import { LayerProps } from "@deck.gl/core/lib/layer";
  export { PickInfo, InitialViewStateProps } from "@deck.gl/core/lib/deck";
  export { LayerProps, DeckProps };

  interface MapViewProps
    extends Partial<Pick<DeckProps, "id" | "width" | "height" | "controller" | "viewState">> {
    x?: string | number;
    y?: string | number;
    repeat?: boolean;
  }

  export interface MapView extends React.Component<React.PropsWithChildren<MapViewProps>> {}

  export interface Layer<D, P extends LayerProps<D>> {
    getAttributeManager(): AttributeManager | null;
  }

  export type AccessorFn<In, Out> = (object: In, info: ObjectInfo<In, Out>) => Out;
  export type ObjectInfo<In, Out> = {
    index: number;
    data: In;
    target: Out;
  };
  export interface AttributeManager {
    addInstanced(attributes: Record<string, AccessorParameters>): void;
  }

  export interface AccessorParameters {
    type: number;
    size: number;
    accessor?: AccessorFn<any, any>;
    update?: (attribute: any, numInstances: any) => void;
    shaderAttributes?: Record<string, any>;
  }

  export interface Viewport {
    altitude: number;
    bearing: number;
    pitch: number;
    zoom: number;
    longitude: number;
    latitude: number;
    center: [number, number, number];
    getBounds(): [number, number, number, number];
  }
}

declare module "@deck.gl/core/lib/deck" {
  import { Viewport } from "@deck.gl/core";
  export interface PickInfo<D> {
    viewport: Viewport;
  }
}

declare module "@deck.gl/core/lib/layer" {
  export interface LayerProps<D> {
    name: string | null;
    groupName: string | null;
    tooltip: TooltipInfo | null;
  }
}

declare module "@deck.gl/geo-layers" {
  export { TileLayerProps } from "@deck.gl/geo-layers/tile-layer/tile-layer";
}

declare module "@deck.gl/react" {
  export { DeckGLProps } from "@deck.gl/react/deckgl";
}
