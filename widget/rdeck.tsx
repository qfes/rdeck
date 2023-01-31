import { useRef, forwardRef, useImperativeHandle } from "react";
import type { MapProps } from "react-map-gl";

import type { DeckProps } from "./deck";
import { Map, MapRef } from "./map";
import { Layer, LayerProps, VisibilityInfo } from "./layer";
import { LayerSelector, Legend, EditorToolbox, LegendRef } from "./controls";
import type { EditorProps } from "./editor";
import styles from "./rdeck.module.css";
import { classNames } from "./util";
import { getSnapshot } from "./utils";

export interface RDeckProps {
  theme: "kepler" | "light";
  deckgl: DeckProps;
  mapgl: MapProps;
  layers: LayerProps[];
  layerSelector: boolean;
  onLayerVisibilityChange: (layersVisibility: VisibilityInfo[]) => void;
  editor: EditorProps | null;
}

export type SnapshotOptions = {
  filename?: string;
  legend?: boolean;
  size?: [number, number];
};

export type RDeckRef = {
  getSnapshot({ legend }: SnapshotOptions): Promise<Blob | null>;
};

export const RDeck = forwardRef<RDeckRef, RDeckProps>(
  (
    { theme, deckgl, mapgl, layers, layerSelector = false, onLayerVisibilityChange, editor },
    ref
  ) => {
    const mapRef = useRef<MapRef>(null);
    const legendRef = useRef<LegendRef>(null);
    useImperativeHandle(
      ref,
      () => ({
        async getSnapshot({ legend = true, size }) {
          const map = mapRef.current;
          const mapLegend = legendRef.current;

          const mapImage = await map?.getImage();
          if (mapImage == null) return null;

          const legendImage = legend ? await mapLegend?.getImage() : null;
          return getSnapshot(mapImage, legendImage ?? null, size);
        },
      }),
      []
    );

    const _layers = layers?.map(Layer.create) ?? [];

    return (
      <div className={classNames(styles.rdeck, theme)}>
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
            ref={legendRef}
            layers={_layers
              .filter((layer) => layer.isVisible)
              .map((layer) => layer.renderLegend())
              .reverse()}
          />
        </div>
        <div className={classNames(styles.controlContainer, styles.top)}>
          {editor && <EditorToolbox {...editor} />}
        </div>
        <Map ref={mapRef} {...{ deckgl, mapgl, layers: _layers, editor }} />
      </div>
    );
  }
);

RDeck.displayName = "RDeck";
