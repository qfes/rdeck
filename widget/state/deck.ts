import type { Effect, InitialViewStateProps, PickInfo, ViewStateChangeParams } from "@deck.gl/core";
import type { DeckProps } from "../deck";
import type { BlendingMode, Bounds } from "../types";

const GLOBE: InitialViewStateProps = {
  longitude: 0,
  latitude: 0,
  zoom: 0,
  pitch: 0,
  bearing: 0,
};

export class DeckState implements DeckProps {
  useDevicePixels?: number | boolean;
  pickingRadius?: number;
  blendingMode?: BlendingMode;
  effects?: Effect[];
  controller?: boolean;
  initialViewState?: InitialViewStateProps = GLOBE;
  initialBounds?: Bounds;

  onViewStateChange?: (params: ViewStateChangeParams) => any;
  onClick?: (info: PickInfo, event: MouseEvent) => void;

  constructor(props?: Partial<DeckProps>) {
    Object.assign(this, props);
  }
}
