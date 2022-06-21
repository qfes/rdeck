import { useEffect, useRef, useState, RefObject } from "react";
import type { MapProps } from "react-map-gl";

import type { DeckProps } from "./deck";
import { Map } from "./map";
import { Layer, LayerProps, VisibilityInfo } from "./layer";
import { LayerSelector, Legend, EditorToolbox } from "./controls";
import type { EditorProps } from "./editor";
import styles from "./rdeck.css";
import { classNames } from "./util";

export interface RDeckProps {
  theme: "kepler" | "light";
  deckgl: DeckProps;
  mapgl: MapProps;
  layers: LayerProps[];
  lazyLoad: boolean;
  layerSelector: boolean;
  onLayerVisibilityChange: (layersVisibility: VisibilityInfo[]) => void;
  editor: EditorProps | null;
}

export function RDeck({
  theme,
  deckgl,
  mapgl,
  layers,
  lazyLoad = false,
  layerSelector = false,
  onLayerVisibilityChange,
  editor,
}: RDeckProps) {
  const _layers = layers?.map(Layer.create) ?? [];

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
        {editor && <EditorToolbox {...editor} />}
      </div>
      {shouldRender && <Map {...{ deckgl, mapgl, layers: _layers, editor }} />}
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
