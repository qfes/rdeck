import React, { useMemo, useState, useCallback, Fragment, memo, useRef } from "react";
import { DeckGL, DeckProps, PickInfo } from "deck.gl";
import { StaticMap, StaticMapProps, WebMercatorViewport } from "react-map-gl";

import Layer, { RDeckLayerProps } from "./layer";
import Tooltip from "./tooltip";
import Legend from "./legend";

export interface RDeckProps {
  props: DeckProps & StaticMapProps & { initialBounds: Bounds | null };
  layers: RDeckLayerProps[];
  width: number;
  height: number;
}

const RDeck = ({ props, layers, width, height }: RDeckProps) => {
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

  const [deckLayers, legendLayers] = useMemo(() => {
    const rdeckLayers = layers.map(Layer.create);

    return [rdeckLayers.map(({ layer }) => layer), rdeckLayers.map(({ legend }) => legend)];
  }, [layers]);

  const [info, handleHover] = useHover();

  return (
    <Fragment>
      <DeckGL
        ref={deckgl}
        {...deckProps}
        initialViewState={_initialViewState}
        layers={deckLayers}
        onHover={handleHover}
      >
        {mapboxApiAccessToken && (
          <StaticMap {...{ mapboxApiAccessToken, mapStyle, mapOptions, width, height }} />
        )}
      </DeckGL>
      <Tooltip info={info} />
      <Legend layers={legendLayers} />
    </Fragment>
  );
};

export default memo(RDeck);

const useHover = () => {
  const [state, setState] = useState<PickInfo<any> | null>(null);

  const handleHover = useCallback((info: PickInfo<any>) => {
    // not picked or no tooltip prop
    if (!info.picked || !info?.layer.props.tooltip) return setState(null);

    setState(info);
  }, []);

  return [state, handleHover] as [PickInfo<any> | null, (info: PickInfo<any>) => void];
};
