import { PathLayer } from "@deck.gl/layers";
import { TripsLayer } from "@deck.gl/geo-layers";
import type { TripsLayerProps } from "@deck.gl/geo-layers/trips-layer/trips-layer";

const pathDraw = PathLayer.prototype.draw;

export interface ContinuousTripsLayerProps<D> extends TripsLayerProps<D> {
  fadeTrail: boolean;
  animationSpeed: number;
  loopLength: number;
}

export class ContinuousTripsLayer<D, P extends ContinuousTripsLayerProps<D>> extends TripsLayer<D, P> {
  draw(params: any) {
    const { fadeTrail, trailLength, animationSpeed, loopLength } = this.props;
    const loopTime = 1000 * (loopLength / animationSpeed);
    const currentTime = loopLength * ((Date.now() % loopTime) / loopTime);

    params.uniforms = {
      ...params.uniforms,
      fadeTrail,
      trailLength,
      currentTime,
    };

    pathDraw.call(this, params);
    this.setNeedsRedraw();
  }
}

ContinuousTripsLayer.defaultProps = {
  ...TripsLayer.defaultProps,
  animationSpeed: 30,
  loopLength: 1800,
};
