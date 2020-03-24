import React, { useMemo, useState, useCallback, Fragment } from "react";
import { DeckGL, DeckProps, PickInfo } from "deck.gl";
import { StaticMap, StaticMapProps } from "react-map-gl";
import Tooltip from "./tooltip";
import Layer from "./layer";
import "./rdeck.css";

export interface RDeckProps {
  props: DeckProps & StaticMapProps;
  layers: any[];
}

export default React.forwardRef<DeckGL, RDeckProps>((props, deckgl) => {
  const { mapboxApiAccessToken, mapStyle, mapOptions, ...deckProps } = props.props;
  const layers = useMemo(() => props.layers.map(Layer.create), [props.layers]);

  const [info, handleHover] = useHover();

  return (
    <Fragment>
      <DeckGL ref={deckgl} {...deckProps} layers={layers.map((x) => x.layer)} onHover={handleHover}>
        {mapboxApiAccessToken && <StaticMap {...{ mapboxApiAccessToken, mapStyle, mapOptions }} />}
      </DeckGL>
      <Tooltip info={info} />
    </Fragment>
  );
});

const useHover = () => {
  const [state, setState] = useState<PickInfo<any> | null>(null);

  const handleHover = useCallback((info: PickInfo<any>, event) => {
    // not picked or no tooltip prop
    if (!info.picked || !info?.layer.props.tooltip) return setState(null);

    setState(info);
  }, []);

  return [state, handleHover];
};
