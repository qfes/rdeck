import React, { useMemo } from "react";
import {
  AccessorScale,
  AccessorScaleCategory,
  AccessorScaleContinuous,
  AccessorScaleDiscrete,
  isColorScale,
  isContinuousScale,
  isDiscreteScale,
} from "./scale";
import { rgba } from "./color";
import { words } from "./util";
import styles from "./legend.css";

const TICK_HEIGHT = 16;

type LegendProps = {
  layers: LayerProps[];
};

export function Legend({ layers }: LegendProps) {
  if (layers.length === 0) return null;

  return (
    <div className={styles.legend}>
      {layers.map((layer) => (
        <Layer key={layer.name} {...layer} />
      ))}
    </div>
  );
}

type LayerProps = {
  name: string;
  scales: AccessorScale<number | Color>[];
};

function Layer({ name, scales }: LayerProps) {
  if (scales.length === 0) return null;

  return (
    <div className={styles.layer}>
      <div className={styles.layerName}>{name}</div>
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
      <span className={styles.fieldName}>{scale.col}</span>
      {isColor && isContinuous && <Continuous {...(scale as AccessorScaleContinuous<Color>)} />}
      {isColor && isDiscrete && <Discrete {...(scale as AccessorScaleDiscrete<Color>)} />}
      {isColor && scale.scale === "category" && (
        <Category {...(scale as AccessorScaleCategory<Color>)} />
      )}
    </div>
  );
}

const Continuous = ({ range, ticks }: AccessorScaleContinuous<Color>) => {
  const id = useId("gradient");
  const colors = range.map(rgba);
  const lines = ticks.map((_, index) => index).slice(1, -1);

  const gradientHeight = TICK_HEIGHT * (ticks.length - 1);
  const height = gradientHeight + 12;

  return (
    <svg className={styles.colorScale} height={height} shapeRendering="crispEdges">
      <svg y={4}>
        <defs>
          <linearGradient id={id} x1={0} x2={0} y1={0} y2={1}>
            {colors.map((color, index) => (
              <stop key={index} offset={index / (colors.length - 1)} stopColor={color} />
            ))}
          </linearGradient>
        </defs>
        <rect width={20} height={gradientHeight} fill={`url(#${id})`} />
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
      <Ticks {...{ ticks }} x={28} y={-4} />
    </svg>
  );
};

const Discrete = ({ ticks, range }: AccessorScaleDiscrete<Color>) => {
  const colors = range.map(rgba);
  const scaleHeight = TICK_HEIGHT * (ticks.length - 1);
  const height = scaleHeight + 12;

  return (
    <svg className={styles.colorScale} height={height} shapeRendering="crispEdges">
      <svg y={4}>
        {colors.map((color, index) => (
          <rect width={20} height={TICK_HEIGHT} y={index * TICK_HEIGHT} fill={color} />
        ))}
      </svg>
      <Ticks {...{ ticks, TICK_HEIGHT }} x={28} y={-4} />
    </svg>
  );
};

function Category({ domain: ticks, range }: AccessorScaleCategory<Color>) {
  const colors = range.map(rgba);

  const height = TICK_HEIGHT * ticks.length;

  return (
    <svg className={styles.colorScale} height={height}>
      <svg>
        {colors.map((color, index) => (
          <rect key={index} width={20} height={14} y={1 + index * TICK_HEIGHT} fill={color} />
        ))}
      </svg>
      <Ticks {...{ ticks, TICK_HEIGHT }} x={28} />
    </svg>
  );
}

type TicksProps = {
  ticks: any[];
  x?: string | number;
  y?: string | number;
};

function Ticks({ ticks, x = 0, y = 0 }: TicksProps) {
  return (
    <svg {...{ x, y }}>
      {ticks.map((tick, index) => (
        <text key={index} className={styles.tick} y={TICK_HEIGHT * index} dy={12}>
          {tick}
        </text>
      ))}
    </svg>
  );
}

const useId = (prefix: string) => {
  return useMemo(() => {
    return `${prefix}-${counter()}`;
  }, [prefix]);
};

const counter = (() => {
  let count = 0;
  return () => count++;
})();
