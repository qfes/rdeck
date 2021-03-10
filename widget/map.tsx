import "mapbox-gl";
import { Fragment, useCallback, useEffect, useRef, useState } from "react";
import { PickInfo, MapView } from "@deck.gl/core";
import { DeckGL, DeckGLProps } from "@deck.gl/react";
import { StaticMap, StaticMapProps } from "react-map-gl";
import { Layer } from "./layer";
import { Tooltip } from "./tooltip";
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

  // layer animation loop
  const [time, setTime] = useState(0);
  const animating = layers.filter((layer) => layer.type === "TripsLayer").length !== 0;
  useAnimation(animating, (time) => setTime(time));

  const _layers = layers.map((layer) => layer.renderLayer(time));

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

const useAnimation = (enabled: boolean, onFrame: (time: number) => void) => {
  const animation = useRef<number>(0);
  const startTime = useRef<number>(Date.now());

  const animate = () => {
    onFrame(Date.now() - startTime.current);
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
