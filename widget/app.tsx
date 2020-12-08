import React, { useMemo } from "react";
import { DeckProps } from "deck.gl";
import { StaticMapProps, WebMercatorViewport } from "react-map-gl";

import { Layer, LayerProps } from "./layer";
import { Map } from "./map";
import { Legend } from "./legend";
import "./app.css";

export interface AppProps {
  props: DeckProps & StaticMapProps & { initialBounds: Bounds | null };
  layers: LayerProps[];
  theme: "kepler" | "light";
  width: number;
  height: number;
}

export function App({ props, layers, theme = "kepler", width, height }: AppProps) {
  const { initialBounds, initialViewState, ...deckglProps } = props;

  /* fit bounds */
  const _initialViewState = useMemo(() => {
    if (!Array.isArray(initialBounds)) {
      return initialViewState;
    }

    const viewport = new WebMercatorViewport({ width, height });
    const { longitude, latitude, zoom } = viewport.fitBounds(initialBounds);

    return { ...initialViewState, longitude, latitude, zoom };
  }, [initialBounds, initialViewState, width, height]);

  const _layers = layers.map(Layer.create);
  const className = `.rdeck ${theme}`;

  return (
    <div className={className}>
      <Map props={{...deckglProps, initialViewState: _initialViewState }} layers={_layers} />
      <Legend layers={_layers.map(x => x.legend)} />
    </div>
  );
}
