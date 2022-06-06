import { useEffect, useRef, useState, RefObject } from "react";
import type { DeckGLProps } from "@deck.gl/react";
import { MapProps } from "react-map-gl";

import { Layer, LayerProps, VisibilityInfo } from "./layer";
import { Map } from "./map";
import { LayerSelector, Legend, EditorPanel } from "./controls";
import styles from "./rdeck.css";
import { classNames } from "./util";
import type { EditorProps } from "./editor";

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
  editor: EditorProps | null;
}

export function RDeck({
  props,
  layers,
  theme,
  lazyLoad,
  layerSelector,
  onLayerVisibilityChange,
  editor,
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
        {editor && <EditorPanel {...editor} />}
      </div>
      {shouldRender && <Map {...{ props, layers: _layers, editor }} />}
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
