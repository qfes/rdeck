import { InitialViewStateProps, Viewport, WebMercatorViewport } from "@deck.gl/core";

export function getViewState(view: Viewport | InitialViewStateProps) {
  const viewport = view instanceof Viewport ? view : new WebMercatorViewport(view);

  return {
    center: viewport.unprojectFlat(viewport.center),
    zoom: viewport.zoom,
    bounds: viewport.getBounds(),
  };
}
