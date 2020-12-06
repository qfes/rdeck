import React, { useMemo, useState, useCallback, Fragment, useRef } from "react";
import { DeckGL, DeckProps, PickInfo } from "deck.gl";
import { StaticMap, StaticMapProps, WebMercatorViewport } from "react-map-gl";

import { Layer, LayerProps } from "./layer";
import Tooltip from "./tooltip";
import Legend from "./legend";

export interface RDeckProps {
  props: DeckProps & StaticMapProps & { initialBounds: Bounds | null };
  layers: LayerProps[];
  width: number;
  height: number;
}

export function RDeck({ props, layers, width, height }: RDeckProps) {
  const deckgl = useRef<DeckGL>(null);
  const {
    mapboxApiAccessToken,
    mapStyle,
    mapOptions,
    initialBounds,
    initialViewState,
    ...deckProps
  } = props;

  /* fit bounds */
  const _initialViewState = useMemo(() => {
    if (!Array.isArray(initialBounds)) {
      return initialViewState;
    }

    const viewport = new WebMercatorViewport({ width, height });
    const { longitude, latitude, zoom } = viewport.fitBounds(initialBounds);

    return { ...initialViewState, longitude, latitude, zoom };
  }, [initialBounds, initialViewState, width, height]);

  const _layers = useMemo(() => layers.map(Layer.create), [layers]);
  const deckglLayers = _layers.map((x) => x.layer);
  const legendLayers = _layers.map((x) => x.legend);

  const [info, handleHover] = useHover();

  return (
    <Fragment>
      <DeckGL
        ref={deckgl}
        {...deckProps}
        initialViewState={_initialViewState}
        layers={deckglLayers}
        onHover={handleHover}
      >
        {mapboxApiAccessToken && (
          <StaticMap {...{ mapboxApiAccessToken, mapStyle, mapOptions, width, height }} />
        )}
      </DeckGL>
      <Tooltip info={info} />
      {/* <Legend layers={legendLayers} /> */}
    </Fragment>
  );
}

const useHover = () => {
  const [state, setState] = useState<PickInfo<any> | null>(null);

  const handleHover = useCallback((info: PickInfo<any>) => {
    // not picked or no tooltip prop
    if (!info.picked || !info.layer.props.tooltip) return setState(null);

    setState(info);
  }, []);

  return [state, handleHover] as [PickInfo<any> | null, (info: PickInfo<any>) => void];
};
