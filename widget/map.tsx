import React, { Fragment, useCallback, useRef, useState } from "react";
import { DeckGL, DeckGLProps } from "@deck.gl/react";
import { Layer as DeckLayer, MapView, PickInfo } from "@deck.gl/core";
import { StaticMap, StaticMapProps } from "react-map-gl";
import Tooltip from "./tooltip";
import { blendingParameters } from "./blending";

type MapProps = {
  props: DeckGLProps & StaticMapProps & { blendingMode: BlendingMode };
  layers: DeckLayer<any, any>[];
};

export function Map({ props, layers }: MapProps) {
  const deckgl = useRef<DeckGL>(null);
  const [info, handleHover] = useHover();

  const {
    mapboxApiAccessToken,
    mapStyle,
    mapOptions,
    controller,
    parameters,
    blendingMode,
    ...deckProps
  } = props;
  const _parameters = {
    ...parameters,
    ...blendingParameters(blendingMode),
  };

  return (
    <Fragment>
      <DeckGL
        ref={deckgl}
        {...deckProps}
        parameters={_parameters}
        layers={layers}
        onHover={handleHover}
      >
        <MapView id="map" controller={controller} repeat={true}>
          {/* @ts-ignore */}
          {mapStyle && <StaticMap reuseMaps {...{ mapboxApiAccessToken, mapStyle, mapOptions }} />}
        </MapView>
      </DeckGL>
      <Tooltip info={info} />
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
