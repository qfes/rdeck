import "mapbox-gl";
import "mapbox-gl/dist/mapbox-gl.css";

import { Fragment, useCallback, useEffect, useRef, useState } from "react";
import { PickInfo, MapView } from "@deck.gl/core";
import { DeckGL } from "@deck.gl/react";
import { Map as MapGL } from "react-map-gl";
import { Deck } from "./deck";
import { Layer } from "./layer";
import { EditableLayer, nebulaMode } from "./layers";
import { Tooltip } from "./tooltip";
import { blendingParameters } from "./blending";
import { _AggregationLayer } from "@deck.gl/aggregation-layers";
import { DeckProps } from "./rdeck";
import { PolygonEditorProps } from "./controls";

export type MapProps = {
  props: DeckProps;
  layers: Layer[];
  polygonEditor: PolygonEditorProps | null;
};

export function Map({ props, layers, polygonEditor }: MapProps) {
  const deckgl = useRef<DeckGL>(null);
  const [info, handleHover] = useHover();

  const { mapboxAccessToken, mapStyle, controller, parameters, blendingMode, ...deckProps } = props;
  const _parameters = {
    ...parameters,
    ...blendingParameters(blendingMode),
  };
  // layer animation loop
  const [time, setTime] = useState(0);
  const animating = layers.some((layer) => layer.type === "TripsLayer");
  useAnimation(animating, (time) => setTime(time));

  const _layers: any = layers.map((layer) => (layer.type != null ? layer.renderLayer(time) : null));
  const editableLayer = renderEditableLayer(polygonEditor);

  return (
    <Fragment>
      <DeckGL
        Deck={Deck}
        ref={deckgl}
        {...deckProps}
        parameters={_parameters}
        layers={[..._layers, editableLayer]}
        onHover={handleHover}
      >
        <MapView id="map" controller={controller} repeat={true}>
          {mapStyle && <MapGL reuseMaps {...{ mapboxAccessToken, mapStyle }} />}
        </MapView>
      </DeckGL>
      {info && <Tooltip info={info} />}
    </Fragment>
  );
}

const useHover = () => {
  const [state, setState] = useState<PickInfo<any> | null>(null);

  const handleHover = useCallback((info: PickInfo<any>) => {
    // not picked or no tooltip prop
    if (!info.picked || !info.layer.props.tooltip || info.layer instanceof _AggregationLayer) {
      return setState(null);
    }

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

function renderEditableLayer(props: PolygonEditorProps | null) {
  if (props == null) return null;

  return new EditableLayer({
    mode: nebulaMode(props.mode),
    data: props.polygon,
    onChange: props.onPolygonChange,
    filled: props.mode !== "view",
    getDashArray: props.mode !== "view" ? [4, 2] : [0, 0],
  });
}
