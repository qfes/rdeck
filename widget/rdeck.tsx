import { useEffect, useRef, useState, RefObject } from "react";
import type { DeckGLProps } from "@deck.gl/react";
import { MapProps } from "react-map-gl";

import { Layer, LayerProps, VisibilityInfo } from "./layer";
import { Map } from "./map";
import { LayerSelector, Legend, PolygonEditor, PolygonEditorProps } from "./controls";
import styles from "./rdeck.css";
import { classNames } from "./util";

export type DeckProps = DeckGLProps &
  Pick<MapProps, "mapboxAccessToken" | "mapStyle"> & {
    initialBounds?: Bounds;
    blendingMode: BlendingMode;
  };

export interface RDeckProps {
  props: DeckProps;
  layers: LayerProps[];
  theme: "kepler" | "light";
  lazyLoad: boolean;
  layerSelector: boolean;
  onLayerVisibilityChange: (layers: VisibilityInfo[]) => void;
  polygonEditor: PolygonEditorProps | null;
}

export function RDeck({
  props,
  layers,
  theme,
  lazyLoad,
  layerSelector,
  onLayerVisibilityChange,
  polygonEditor,
}: RDeckProps) {
  const _layers = layers.map(Layer.create);

  const container = useRef<HTMLDivElement>(null);
  const inViewport = useInViewport(container, lazyLoad);
  const shouldRender = !lazyLoad || inViewport;

  return (
    <div ref={container} className={classNames(styles.rdeck, theme)}>
      <div className={classNames(styles.controlContainer, styles.left)}>
        {layerSelector && (
          <LayerSelector
            layers={_layers
              .filter((layer) => layer.props.visibilityToggle)
              .map((layer) => layer.renderSelector())
              .reverse()}
            onVisibilityChange={onLayerVisibilityChange}
          />
        )}
      </div>
      <div className={classNames(styles.controlContainer, styles.right)}>
        <Legend
          layers={_layers
            .filter((layer) => layer.props.visible)
            .map((layer) => layer.renderLegend())
            .reverse()}
        />
      </div>
      <div className={classNames(styles.controlContainer, styles.top)}>
        {polygonEditor && <PolygonEditor {...polygonEditor} />}
      </div>
      {shouldRender && <Map props={props} layers={_layers} polygonEditor={polygonEditor} />}
    </div>
  );
}

function useInViewport(ref: RefObject<HTMLElement>, enabled: boolean) {
  const [state, setState] = useState(false);

  useEffect(() => {
    if (enabled && ref.current) {
      const observer = new IntersectionObserver(
        (entries) => {
          setState(entries[0].isIntersecting);
        },
        { threshold: 0 }
      );

      observer.observe(ref.current);
      return () => observer.disconnect();
    }
  }, [enabled, ref]);

  return state;
}
