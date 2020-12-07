
import React, { useCallback, useRef, useState } from "react";
import DeckGL, { DeckProps, PickInfo } from "deck.gl";
import { StaticMap, StaticMapProps } from "react-map-gl";
import { Layer } from "./layer";
import Tooltip from "./tooltip";

type MapProps = {
  props: DeckProps & StaticMapProps;
  layers: Layer[];
}

export function Map({ props, layers }: MapProps) {
  const deckgl = useRef<DeckGL>(null);
  const [info, handleHover] = useHover();

  const {
    mapboxApiAccessToken,
    mapStyle,
    mapOptions,
    ...deckProps
  } = props;

  return (
    <DeckGL
      ref={deckgl}
      {...deckProps}
      layers={layers.map((x) => x.layer)}
      onHover={handleHover}
    >
      {mapboxApiAccessToken && (
        // @ts-ignore
        <StaticMap {...{ mapboxApiAccessToken, mapStyle, mapOptions }} />
      )}
      <Tooltip info={info} />
    </DeckGL>
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
