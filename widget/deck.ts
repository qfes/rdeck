import { Deck as _Deck, DeckProps as _DeckProps } from "@deck.gl/core";
import { fitBounds } from "@math.gl/web-mercator";
import type { Bounds, BlendingMode } from "./types";
import { getElementSize } from "./util";

export interface DeckProps extends Partial<_DeckProps> {
  initialBounds?: Bounds;
  blendingMode?: BlendingMode;
}

export class Deck extends _Deck {
  static defaultProps = {
    ..._Deck.defaultProps,
    initialBounds: null,
  };

  // @ts-ignore: all deck props should be optional
  declare props: DeckProps;

  setProps(props: Partial<DeckProps>): void {
    const initialBounds = props.initialBounds;
    if (initialBounds != null && !boundsEqual(initialBounds, this.props.initialBounds)) {
      // constrain to web mercator limits
      // https://en.wikipedia.org/wiki/Web_Mercator_projection
      const [xmin, ymin, xmax, ymax] = initialBounds;
      const bounds: [[number, number], [number, number]] = [
        [Math.max(xmin, -180), Math.max(ymin, -85.051129)],
        [Math.min(xmax, 180), Math.min(ymax, 85.051129)],
      ];

      // update canvas, get map pixel dimensions
      this._setCanvasSize(props);
      const { width, height } = this._getMapSize();

      // fit & overwrite
      props = {
        ...props,
        initialViewState: {
          ...fitBounds({ height, width, bounds }),
          // visgl/deck.gl#6883
          bearing: 0,
          pitch: 0,
        },
      };
    }

    super.setProps(props);
  }

  _getMapSize(): { width: number; height: number } {
    const canvas = this.canvas;
    if (canvas == null) return { width: this.width, height: this.height };

    // map is hidden? get dimensions from first visible ancestor and widget dimensions
    if (canvas.clientWidth === 0 && canvas.clientHeight === 0) {
      const root = canvas.closest(".rdeck.html-widget");
      if (root != null) return getElementSize(root);
    }

    return { width: canvas.clientWidth, height: canvas.clientHeight };
  }
}

function boundsEqual<T>(bounds?: T[] | null, prevBounds?: T[] | null): boolean {
  // reference equal
  if (bounds === prevBounds) return true;

  // nullish equal
  if (bounds == null && prevBounds == null) return true;
  if (bounds == null || prevBounds == null) return false;

  // element-wise equal
  return bounds?.every((coord, index) => coord === prevBounds?.[index]);
}
