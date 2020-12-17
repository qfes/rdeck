import React, { useCallback, useRef, useState } from "react";
import { DeckGL, DeckGLProps } from "@deck.gl/react";
import { Layer as DeckLayer, MapView, PickInfo } from "@deck.gl/core";
import { StaticMap, StaticMapProps } from "react-map-gl";
import Tooltip from "./tooltip";

type MapProps = {
  props: DeckGLProps & StaticMapProps;
  layers: DeckLayer<any, any>[];
};

export function Map({ props, layers }: MapProps) {
  const deckgl = useRef<DeckGL>(null);
  const [info, handleHover] = useHover();

  const { mapboxApiAccessToken, mapStyle, mapOptions, controller, ...deckProps } = props;

  return (
    <DeckGL ref={deckgl} {...deckProps} layers={layers} onHover={handleHover}>
      {mapStyle && (
        <MapView id="map" controller={controller} repeat={true}>
          {/* @ts-ignore */}
          <StaticMap reuseMaps {...{ mapboxApiAccessToken, mapStyle, mapOptions }} />
        </MapView>
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
