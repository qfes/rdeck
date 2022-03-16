import { InitialViewStateProps, WebMercatorViewport } from "@deck.gl/core";
import { pick } from "./util";

export function getViewState(viewState: WebMercatorViewport | InitialViewStateProps) {
  const viewport =
    viewState instanceof WebMercatorViewport ? viewState : new WebMercatorViewport(viewState);

  const props = pick(viewport, "longitude", "latitude", "zoom", "bearing", "pitch", "altitude");
  return {
    bounds: viewport.getBounds(),
    viewState: {
      ...props,
      center: viewport.unprojectFlat(viewport.center),
    },
  };
}
