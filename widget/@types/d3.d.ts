/* eslint-disable @typescript-eslint/no-unused-vars */
import "d3-scale";

declare module "d3-scale" {
  export interface ScaleContinuousNumeric<Range, Output> {
    unknown(): Range;
    unknown(value: Range): this;
  }

  export interface ScaleThreshold<Domain extends number | string | Date, Range> {
    unknown(): Range;
    unknown(value: Range): this;
  }

  export interface ScaleQuantize<Range> {
    unknown(): Range;
    unknown(value: Range): this;
  }
}
