import "mapbox-gl";
import "mapbox-gl/dist/mapbox-gl.css";

import { Fragment, useCallback, useEffect, useRef, useState } from "react";
import { PickInfo, MapView } from "@deck.gl/core";
import { DeckGL } from "@deck.gl/react";
import { _AggregationLayer } from "@deck.gl/aggregation-layers";
import { Map as MapGL, MapProps as MapGLProps } from "react-map-gl";

import { Deck, DeckProps } from "./deck";
import { Layer } from "./layer";
import { Tooltip } from "./tooltip";
import { blendingParameters } from "./blending";
import { createEditableLayer, EditorProps } from "./editor";

export type MapProps = {
  deckgl: DeckProps;
  mapgl: MapGLProps;
  layers: Layer[];
  editor: EditorProps | null;
};

export function Map({ deckgl, mapgl, layers, editor }: MapProps) {
  const deck = useRef<DeckGL>(null);
  const [info, handleHover] = useHover();

  const { controller, blendingMode, onClick: handleClick, ...deckProps } = deckgl;

  const parameters = {
    ...deckgl.parameters,
    ...(blendingMode && blendingParameters(blendingMode)),
  };

  // layer animation loop
  const [time, setTime] = useState(0);
  const animating = layers.some((layer) => layer.type === "TripsLayer");
  useAnimation(animating, (time) => setTime(time));

  const _layers: any = layers.map((layer) => (layer.type != null ? layer.renderLayer(time) : null));
  const editableLayer = createEditableLayer(editor);
  const isEditing = editor != null && editor.mode !== "view";

  return (
    <Fragment>
      <DeckGL
        // @ts-ignore
        Deck={Deck}
        ref={deck}
        {...{ ...deckProps, parameters }}
        layers={[..._layers, editableLayer]}
        // remove picking callbacks when editing
        onHover={!isEditing ? handleHover : undefined}
        onClick={!isEditing ? handleClick : undefined}
        getCursor={editableLayer?.getCursor.bind(editableLayer)}
      >
        <MapView id="map" controller={controller} repeat>
          {/* @ts-ignore} */}
          {mapgl.mapStyle && <MapGL {...mapgl} />}
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
