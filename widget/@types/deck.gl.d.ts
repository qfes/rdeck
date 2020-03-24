declare module "@deck.gl/core" {
  export { PickInfo } from "@deck.gl/core/lib/deck";
  export { LayerProps } from "@deck.gl/core/lib/layer";
}

declare module "deck.gl" {
  export { PickInfo, LayerProps } from "@deck.gl/core";
}

declare module "@deck.gl/core/lib/deck" {
  export interface PickInfo<D> {
    picked?: boolean;
  }
}
