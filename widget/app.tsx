import React, { useMemo } from "react";
import type { DeckProps, InitialViewStateProps } from "@deck.gl/core";
import { StaticMapProps, WebMercatorViewport } from "react-map-gl";

import { Layer, LayerProps } from "./layer";
import { Map } from "./map";
import { Legend } from "./legend";
import styles from "./app.css";

export interface AppProps {
  props: DeckProps & StaticMapProps & { initialBounds?: Bounds; blendingMode: BlendingMode };
  layers: LayerProps[];
  theme: "kepler" | "light";
  width: number;
  height: number;
}

export function App({ props, layers, theme = "kepler", width, height }: AppProps) {
  const { initialBounds, initialViewState, ...deckglProps } = props;

  /* fit bounds */
  const _initialViewState = useBounds(width, height, initialBounds, initialViewState);

  const _layers = layers.map(Layer.create);
  const className = `${styles.rdeck} ${theme}`;

  return (
    <div className={className}>
      <Map props={{ ...deckglProps, initialViewState: _initialViewState }} layers={_layers} />
      <Legend layers={_layers.map((layer) => layer.renderLegend()).reverse()} />
    </div>
  );
}

function useBounds(
  width: number,
  height: number,
  initialBounds?: Bounds,
  initialViewState?: InitialViewStateProps
) {
  return useMemo(() => {
    if (!Array.isArray(initialBounds)) {
      return initialViewState;
    }

    const [xmin, ymin, xmax, ymax] = initialBounds;
    // constrain to web mercator limits
    // https://en.wikipedia.org/wiki/Web_Mercator_projection
    const bounds: [[number, number], [number, number]] = [
      [Math.max(-180, xmin), Math.max(ymin, -85.051129)],
      [Math.min(180, xmax), Math.min(ymax, 85.051129)],
    ];

    const viewport = new WebMercatorViewport({ width, height });
    const { longitude, latitude, zoom } = viewport.fitBounds(bounds);

    return { ...initialViewState, longitude, latitude, zoom };
  }, [initialBounds, initialViewState, width, height]);
}
