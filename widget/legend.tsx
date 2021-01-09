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
const TICK_FONT_SIZE = 10;

export type LegendProps = {
  layers: LegendLayerProps[];
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

export type LegendLayerProps = {
  id: string;
  name: string;
  scales: AccessorScale<number | Color>[];
};

function Layer({ name, scales }: LegendLayerProps) {
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

const Continuous = ({ range, domain, ticks }: AccessorScaleContinuous<Color>) => {
  const id = useId("gradient");
  const colors = range.map(rgba);
  const lines = ticks.map((_, index) => index).slice(1, -1);
  const domainSize = domain[domain.length - 1] - domain[0];

  const gradientHeight = TICK_HEIGHT * (ticks.length - 1);
  const height = gradientHeight + TICK_FONT_SIZE + 1;

  return (
    <svg className={styles.colorScale} height={height} shapeRendering="crispEdges">
      <svg y={5}>
        <defs>
          <linearGradient id={id} x2={0} y2={1}>
            {colors.map((color, index) => (
              <stop key={index} offset={index / colors.length} stopColor={color} />
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
      <Ticks {...{ ticks }} y={-2} />
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
      <Ticks {...{ ticks }} y={-2} />
    </svg>
  );
};

function Category({ ticks, range }: AccessorScaleCategory<Color>) {
  const colors = range.map(rgba);
  const height = TICK_HEIGHT * ticks.length;

  return (
    <svg className={styles.colorScale} height={height}>
      <svg>
        {colors.map((color, index) => (
          <rect key={index} width={20} height={14} y={1 + index * TICK_HEIGHT} fill={color} />
        ))}
      </svg>
      <Ticks {...{ ticks }} />
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

const useId = (prefix: string) => {
  return useMemo(() => {
    return `${prefix}-${counter()}`;
  }, [prefix]);
};

const counter = (() => {
  let count = 0;
  return () => count++;
})();
