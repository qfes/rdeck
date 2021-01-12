import React, { Fragment, useCallback, useEffect, useRef, useState } from "react";
import { DeckGL, DeckGLProps } from "@deck.gl/react";
import { MapView, PickInfo } from "@deck.gl/core";
import { StaticMap, StaticMapProps } from "react-map-gl";
import { Layer } from "./layer";
import Tooltip from "./tooltip";
import { blendingParameters } from "./blending";

export type MapProps = {
  props: DeckGLProps & StaticMapProps & { blendingMode: BlendingMode };
  layers: Layer[];
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

  const [_layers, setLayers] = useState(() => layers.map((layer) => layer.renderLayer()));
  const animating = layers.filter((layer) => layer.type === "TripsLayer").length !== 0;

  useAnimation(animating, () => setLayers(layers.map((layer) => layer.renderLayer())));

  return (
    <Fragment>
      <DeckGL
        ref={deckgl}
        {...deckProps}
        parameters={_parameters}
        layers={_layers}
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

const useAnimation = (enabled: boolean, onFrame: () => void) => {
  const animation = useRef<number>(0);

  const animate = () => {
    onFrame();
    animation.current = window.requestAnimationFrame(animate);
  };

  useEffect(() => {
    if (enabled) {
      animation.current = window.requestAnimationFrame(animate);
      return () => window.cancelAnimationFrame(animation.current);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [enabled]);
};
