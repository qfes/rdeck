import type { ScaleLinear, ScaleLogarithmic, ScalePower } from "d3-scale";
import {
  AccessorScale,
  AccessorScaleCategory,
  AccessorScaleContinuous,
  AccessorScaleDiscrete,
  isColorScale,
  isContinuousScale,
  isDiscreteScale,
} from "./scale";
import type { LegendInfo } from "./layer";
import { rgba } from "./color";
import { words } from "./util";
import styles from "./legend.css";

const TICK_HEIGHT = 16;
const TICK_FONT_SIZE = 11;

export type LegendProps = {
  layers: LegendInfo[];
};

export function Legend({ layers }: LegendProps) {
  if (layers.length === 0) return null;

  return (
    <div className={styles.legend}>
      {layers.map((layer) => (
        <Layer key={layer.id} {...layer} />
      ))}
    </div>
  );
}

function Layer({ name, scales }: LegendInfo) {
  if (scales.length === 0) return null;

  return (
    <div className={styles.layer}>
      <div className={styles.layerName} title={name}>
        {name}
      </div>
      {scales.map((scale) => (
        <Scale key={scale.name} {...scale} />
      ))}
    </div>
  );
}

function Scale(scale: AccessorScale<number | Color>) {
  const scaleName = words(scale.name.replace(/^get/, ""));
  const isColor = isColorScale(scale);
  const isContinuous = isContinuousScale(scale);
  const isDiscrete = isDiscreteScale(scale);

  return (
    <div className={styles.scale}>
      <div className={styles.scaleName}>{scaleName}</div>
      <span className={styles.scaleBy}>by </span>
      <span className={styles.fieldName} title={scale.col}>
        {scale.col}
      </span>
      {isColor && isContinuous && <Continuous {...(scale as AccessorScaleContinuous<Color>)} />}
      {isColor && isDiscrete && <Discrete {...(scale as AccessorScaleDiscrete<Color>)} />}
      {isColor && scale.scale === "category" && (
        <Category {...(scale as AccessorScaleCategory<Color>)} />
      )}
    </div>
  );
}

const Continuous = ({ ticks, scaleData }: AccessorScaleContinuous<Color>) => {
  const lines = ticks.map((_, index) => index).slice(1, -1);
  const gradientHeight = TICK_HEIGHT * (ticks.length - 1);
  const height = gradientHeight + TICK_FONT_SIZE + 1;

  return (
    <svg className={styles.colorScale} height={height} shapeRendering="crispEdges">
      <svg y={5}>
        <image
          width={20}
          height={gradientHeight}
          href={getColorGradient(scaleData)}
          preserveAspectRatio="none"
        />
        {lines.map((index) => (
          <line
            key={index}
            className={styles.line}
            x2={20}
            y1={TICK_HEIGHT * index}
            y2={TICK_HEIGHT * index}
          />
        ))}
      </svg>
      <Ticks ticks={ticks} y={-2} />
    </svg>
  );
};

const Discrete = ({ ticks, range }: AccessorScaleDiscrete<Color>) => {
  const colors = range.map(rgba);
  const scaleHeight = TICK_HEIGHT * (ticks.length - 1);
  const height = scaleHeight + TICK_FONT_SIZE + 1;

  return (
    <svg className={styles.colorScale} height={height} shapeRendering="crispEdges">
      <svg y={5}>
        {colors.map((color, index) => (
          <rect key={index} width={20} height={TICK_HEIGHT} y={index * TICK_HEIGHT} fill={color} />
        ))}
      </svg>
      <Ticks ticks={ticks} y={-2} />
    </svg>
  );
};

function Category({ ticks, range, unknownTick, unknown }: AccessorScaleCategory<Color>) {
  const _range = unknownTick ? [...range, unknown] : range;
  const _ticks = unknownTick ? [...ticks, unknownTick] : ticks;
  const colors = _range.map(rgba);
  const height = TICK_HEIGHT * _ticks.length;

  return (
    <svg className={styles.colorScale} height={height}>
      <svg>
        {colors.map((color, index) => (
          <rect key={index} width={20} height={14} y={1 + index * TICK_HEIGHT} fill={color} />
        ))}
      </svg>
      <Ticks ticks={_ticks} />
    </svg>
  );
}

type TicksProps = {
  ticks: any[];
  x?: string | number;
  y?: string | number;
};

function Ticks({ ticks, x = 28, y = 0 }: TicksProps) {
  return (
    <svg {...{ x, y }}>
      {ticks.map((tick, index) => (
        <text key={index} className={styles.tick} y={TICK_HEIGHT * index} dy={TICK_FONT_SIZE}>
          {String(tick)}
        </text>
      ))}
    </svg>
  );
}

type ScaleContinuous<T> = ScaleLinear<T, T> | ScalePower<T, T> | ScaleLogarithmic<T, T>;

function getColorGradient(scale: ScaleContinuous<Color>, n = 200): string {
  const length = scale.range().length;
  const range: any = [...Array(length).keys()].map((x) => x / (length - 1));
  const invert = scale.copy().range(range).invert;

  const canvas = document.createElement("canvas");
  const context = canvas.getContext("2d");
  canvas.width = 1;
  canvas.height = n;

  for (let i = 0; i < n; i++) {
    context!.fillStyle = rgba(scale(invert(i / n)));
    context!.fillRect(0, i, 1, 1);
  }

  return canvas.toDataURL();
}
