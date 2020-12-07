import React, { useMemo, useState, useCallback, Fragment, useRef } from "react";
import { DeckGL, DeckProps, PickInfo } from "deck.gl";
import { StaticMap, StaticMapProps, WebMercatorViewport } from "react-map-gl";

import { Layer, LayerProps } from "./layer";
import { Map } from "./map";
import { Legend } from "./legend";

export interface AppProps {
  props: DeckProps & StaticMapProps & { initialBounds: Bounds | null };
  layers: LayerProps[];
  width: number;
  height: number;
}

export function App({ props, layers, width, height }: AppProps) {

  const { initialBounds, initialViewState } = props;

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
  console.log("render");

  return (
    <Fragment>
      <Map props={{...props, initialViewState: _initialViewState }} layers={_layers} />
      <Legend layers={_layers.map(x => x.legend)} />
    </Fragment>
  );
}
