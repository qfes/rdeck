import { createRoot, Root } from "react-dom/client";
import { StrictMode } from "react";
import type { PickInfo, ViewStateChangeParams } from "@deck.gl/core";
import type { FeatureCollection } from "geojson";

import { RDeck } from "./rdeck";
import type { LayerProps, VisibilityInfo } from "./layer";
import { pick } from "./util";
import { getViewState } from "./viewport";
import { getPickedObject } from "./picking";
import { Store } from "./store";

export class Widget {
  #root: Root;
  #element: Element;
  get element() {
    return this.#element;
  }

  #state: Store;
  get state() {
    return this.#state;
  }

  constructor(element: Element, props: Partial<Store>) {
    this.#element = element;
    this.#root = createRoot(element);
    this.#state = new Store(props, () => this.render());

    // FIXME: move to service
    if (HTMLWidgets.shinyMode) {
      // update layers
      Shiny.addCustomMessageHandler(`${element.id}:layer`, (layer: LayerProps) => {
        // FIXME: batch upserts
        this.state.upsertLayer(layer);
      });

      // update map
      Shiny.addCustomMessageHandler(`${element.id}:deck`, (state: Partial<Store>) => {
        this.state.setState(state);
      });
    }
  }

  render() {
    let { deckgl, mapgl, editor, ...props } = this.#state;

    deckgl = {
      ...deckgl,
      onClick: this.#handleClick,
      onViewStateChange: this.#handleViewStateChange,
    };

    if (editor != null) {
      // @ts-ignore
      editor = {
        ...editor,
        upload: this.#handleUpload,
      };
    }

    // overwritten
    if (deckgl.initialBounds != null) {
      delete deckgl.initialViewState;
    }

    this.#root.render(
      <StrictMode>
        <RDeck
          {...{
            ...props,
            deckgl,
            mapgl,
            editor,
            onLayerVisibilityChange: this.state.setLayerVisibility,
          }}
        />
      </StrictMode>
    );
  }

  /**
   * Set layers' visibility. Layers not included in visibility are unaltered.
   * @param layersVisibility the layers whose visibility is to be changed
   */
  setLayerVisibility(layersVisibility: VisibilityInfo[]) {
    return this.#state.setLayerVisibility(layersVisibility);
  }

  // FIXME: move to store
  #handleClick = (info: PickInfo<any>, event: MouseEvent): void => {
    this.#state.deckgl.onClick?.(info, event);
    if (HTMLWidgets.shinyMode) {
      const data = {
        coordinate: info.coordinate,
        ...getViewState(info.viewport),
        layer: pick(info.layer?.props, "id", "name", "groupName"),
        object: getPickedObject(info),
      };

      Shiny.setInputValue(`${this.element.id}_click`, data, { priority: "event" });
    }
  };

  // FIXME: move to store
  #handleViewStateChange = (params: ViewStateChangeParams): void => {
    this.#state.deckgl.onViewStateChange?.(params);
    if (HTMLWidgets.shinyMode) {
      const data = getViewState(params.viewState);

      Shiny.setInputValue(`${this.element.id}_viewstate`, data, { priority: "event" });
    }
  };

  // FIXME: move to store
  #handleUpload = (geojson: FeatureCollection): void => {
    if (HTMLWidgets.shinyMode) {
      // we need to parse the json with geojsonsf
      Shiny.setInputValue(`${this.element.id}_editorupload`, {
        geojson: JSON.stringify(geojson),
      });
    }
  };
}
