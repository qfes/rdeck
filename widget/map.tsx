import "mapbox-gl";
import "mapbox-gl/dist/mapbox-gl.css";

import {
  forwardRef,
  Fragment,
  useCallback,
  useImperativeHandle,
  useRef,
  useState,
} from "react";
import { PickInfo, MapView } from "@deck.gl/core";
import { DeckGL, DeckGLRef } from "@deck.gl/react";
import { _AggregationLayer } from "@deck.gl/aggregation-layers";
import { Map as MapGL, MapProps as MapGLProps, MapRef as MapGLRef } from "react-map-gl";

import { Deck, DeckProps } from "./deck";
import { Layer } from "./layer";
import { Tooltip } from "./tooltip";
import { blendingParameters } from "./blending";
import { createEditableLayer, EditorProps } from "./editor";
import { getMapImage } from "./utils";

export type MapProps = {
  deckgl: DeckProps;
  mapgl: MapGLProps;
  layers: Layer[];
  editor: EditorProps | null;
};

export type MapRef = {
  getImage(): Promise<HTMLCanvasElement | null>;
};

export const Map = forwardRef<MapRef, MapProps>(({ deckgl, mapgl, layers, editor }, ref) => {
  const deckglRef = useRef<DeckGLRef>(null);
  const mapglRef = useRef<MapGLRef>(null);

  useImperativeHandle(
    ref,
    () => ({
      async getImage() {
        const deck = deckglRef.current?.deck;
        if (deck == null) return null;

        const mapbox = mapglRef.current?.getMap();
        return getMapImage(deck, mapbox ?? null);
      },
    }),
    []
  );

  const [info, handleHover] = useHover();

  let { blendingMode, controller, onClick: handleClick, ...deckProps } = deckgl;

  const parameters = {
    ...deckgl.parameters,
    ...(blendingMode && blendingParameters(blendingMode)),
  };

  const editableLayer = createEditableLayer(editor);
  const isEditing = editor != null && !["view", "select"].includes(editor.mode);
  const _layers = layers.map((x) =>
    x.type != null ? x.renderLayer({ pickable: !isEditing && x.props.pickable }) : null
  );

  // disable double-click zoom for editor
  if (isEditing && controller) {
    controller = {
      // @ts-ignore
      ...controller,
      doubleClickZoom: false,
    };
  }

  return (
    <Fragment>
      <DeckGL
        // @ts-ignore
        Deck={Deck}
        // @ts-ignore
        ref={deckglRef}
        {...{ ...deckProps, parameters }}
        layers={[..._layers, editableLayer]}
        // remove picking callbacks when editing
        onHover={!isEditing ? handleHover : undefined}
        onClick={!isEditing ? handleClick : undefined}
        getCursor={editableLayer?.getCursor.bind(editableLayer)}
      >
        <MapView id="map" controller={controller} repeat>
          {/* @ts-ignore} */}
          {mapgl.mapStyle && <MapGL ref={mapglRef} {...mapgl} />}
        </MapView>
      </DeckGL>
      {info && <Tooltip info={info} />}
    </Fragment>
  );
});

Map.displayName = "Map";

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
