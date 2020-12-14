import React, { useMemo } from "react";
import { DeckProps, InitialViewStateProps } from "deck.gl";
import { StaticMapProps, WebMercatorViewport } from "react-map-gl";

import { Layer, LayerProps } from "./layer";
import { Map } from "./map";
import { Legend } from "./legend";
import styles from "./app.css";

export interface AppProps {
  props: DeckProps & StaticMapProps & { initialBounds?: Bounds };
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
      <Legend layers={_layers.map((x) => x.legend)} />
    </div>
  );
}

function useBounds(
  width: number,
  height: number,
  initialBounds?: Bounds,
  initialViewState?: InitialViewStateProps,
) {
  return useMemo(() => {
    if (!Array.isArray(initialBounds)) {
      return initialViewState;
    }

    const [xmin, ymin, xmax, ymax] = initialBounds;
    const bounds: [[number, number], [number, number]] = [
      [xmin, Math.max(ymin, -85)],
      [xmax, Math.min(ymax, 85)],
    ];

    // tabs create zero-height map when not active
    const _height = height > 0 ? height : width;
    const viewport = new WebMercatorViewport({ width, height: _height });
    const { longitude, latitude, zoom } = viewport.fitBounds(bounds);

    return { ...initialViewState, longitude, latitude, zoom };
  }, [initialBounds, initialViewState, width, height]);
}
