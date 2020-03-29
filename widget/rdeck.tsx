import React, { useMemo, useState, useCallback, Fragment, memo, useRef } from "react";
import { DeckGL, DeckProps, PickInfo } from "deck.gl";
import { StaticMap, StaticMapProps } from "react-map-gl";

import Layer, { RDeckLayerProps } from "./layer";
import Tooltip from "./tooltip";
import Legend from "./legend";

export interface RDeckProps {
  props: DeckProps & StaticMapProps;
  layers: RDeckLayerProps[];
}

const RDeck = (props: RDeckProps) => {
  const deckgl = useRef<DeckGL>(null);
  const { mapboxApiAccessToken, mapStyle, mapOptions, ...deckProps } = props.props;
  const [deckLayers, legendLayers] = useMemo(() => {
    const layers = props.layers.map(Layer.create);

    return [layers.map(({ layer }) => layer), layers.map(({ legend }) => legend)];
  }, [props.layers]);

  const [info, handleHover] = useHover();

  return (
    <Fragment>
      <DeckGL ref={deckgl} {...deckProps} layers={deckLayers} onHover={handleHover}>
        {mapboxApiAccessToken && <StaticMap {...{ mapboxApiAccessToken, mapStyle, mapOptions }} />}
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