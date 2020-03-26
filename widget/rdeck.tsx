import React, { useMemo, useState, useCallback, Fragment } from "react";
import { DeckGL, DeckProps, PickInfo } from "deck.gl";
import { StaticMap, StaticMapProps } from "react-map-gl";

import Layer, { RDeckLayerProps } from "./layer";
import Tooltip from "./tooltip";
import Legend from "./legend";

import "./rdeck.css";

export interface RDeckProps {
  props: DeckProps & StaticMapProps;
  layers: RDeckLayerProps[];
}

export default React.forwardRef<DeckGL, RDeckProps>((props, deckgl) => {
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
});

const useHover = () => {
  const [state, setState] = useState<PickInfo<any> | null>(null);

  const handleHover = useCallback((info: PickInfo<any>) => {
    // not picked or no tooltip prop
    if (!info.picked || !info?.layer.props.tooltip) return setState(null);

    setState(info);
  }, []);

  return [state, handleHover] as [PickInfo<any> | null, (info: PickInfo<any>) => void];
};
