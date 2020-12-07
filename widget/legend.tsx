import React, { Fragment, useMemo } from "react";
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
  const tickHeight = 16;

  const scaleHeight = tickHeight * (ticks.length - 1);
  const height = scaleHeight + 11;

  return (
    <svg className={styles.colorScale} height={height} width="100%">
      <defs>
        <linearGradient id={id} x1={0} x2={0} y1={0} y2={1}>
          {colors.map((color, index) => (
            <stop key={index} offset={index / (colors.length - 1)} stopColor={color} />
          ))}
        </linearGradient>
      </defs>
      <rect width={20} y={5.5} height={scaleHeight} fill={`url(#${id})`} />
      <Ticks {...{ ticks, tickHeight }} x={30} />
      <Lines {...{ ticks, tickHeight }} x={0} y={5} width={26} />
    </svg>
  );
};

const Discrete = ({ ticks, range }: AccessorScaleDiscrete<Color>) => {
  const colors = range.map(rgba);
  const tickHeight = 16;

  const scaleHeight = tickHeight * (ticks.length - 1);
  const height = scaleHeight + 11;

  return (
    <svg className={styles.colorScale} height={height}>
      <svg y={5.5}>
        {colors.map((color, index) => (
          <rect width={20} height={tickHeight} y={index * tickHeight} fill={color} />
        ))}
      </svg>
      <Ticks {...{ ticks, tickHeight }} x={30} />
      <Lines {...{ ticks, tickHeight }} x={0} y={5} width={26} />
    </svg>
  );
};

function Category({ domain: ticks, range }: AccessorScaleCategory<Color>) {
  const colors = range.map(rgba);
  const tickHeight = 16;

  const height = tickHeight * ticks.length;

  return (
    <svg className={styles.colorScale} height={height}>
      <svg y={1}>
        {colors.map((color, index) => (
          <rect width={20} height={14} y={1 + index * tickHeight} fill={color} />
        ))}
      </svg>
      <Ticks {...{ ticks, tickHeight }} x={30} y={4} />
    </svg>
  );
}

type LinesProps = {
  ticks: any[];
  tickHeight: number;
  width: string | number;
  x?: string | number;
  y?: string | number;
};

function Lines({ ticks, tickHeight, width, x = 0, y = 4 }: LinesProps) {
  const getY = (index: number) => {
    const offset = index === ticks.length - 1 ? 0 : 0.5;
    return tickHeight * index + offset;
  };

  return (
    <svg {...{ width, x, y }}>
      {ticks.map((_, index) => (
        <line
          key={index}
          className={styles.line}
          shapeRendering="crispEdges"
          x2="100%"
          y1={getY(index)}
          y2={getY(index)}
        />
      ))}
    </svg>
  );
}

type TicksProps = {
  ticks: any[];
  tickHeight: number;
  x?: string | number;
  y?: string | number;
};

function Ticks({ ticks, tickHeight, x = 0, y = 0 }: TicksProps) {
  return (
    <svg {...{ x, y }}>
      {ticks.map((tick, index) => (
        <text key={index} className={styles.tick} y={tickHeight * index} dy={8}>
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
