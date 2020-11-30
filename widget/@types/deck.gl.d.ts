declare module "@deck.gl/core" {
  export { PickInfo } from "@deck.gl/core/lib/deck";
  export { LayerProps } from "@deck.gl/core/lib/layer";
}

declare module "deck.gl" {
  export { LayerProps } from "@deck.gl/core";
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
