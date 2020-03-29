import React, { memo, useMemo } from "react";
import styles from "./legend.css";
import ScaleAccessor from "./scale";
import { words, rgba } from "./util";

export interface LegendProps {
  layers: LayerProps[];
}

const Legend = ({ layers }: LegendProps) => {
  if (layers.length === 0) return null;

  return (
    <div className={styles.legend}>
      {layers.map((layer) => (
        <Layer key={layer.name} {...layer} />
      ))}
    </div>
  );
};

interface LayerProps {
  name: string;
  scales: ScaleAccessor[];
}

const Layer = ({ name, scales }: LayerProps) => {
  if (scales.length === 0) return null;

  return (
    <div className={styles.layer}>
      <div className={styles.layerName}>{name}</div>
      {scales.map((scale) => (
        <Scale key={scale.name} {...scale} isContinuous={scale.isContinuous} />
      ))}
    </div>
  );
};

type ScaleProps = ScaleAccessor;

const Scale = ({ name, field, scale, isContinuous }: ScaleProps) => {
  const scaleName = words(name.replace(/^get/, ""));
  const isColor = /color$/i.test(name);

  return (
    <div className={styles.scale}>
      <div className={styles.scaleName}>{scaleName}</div>
      <span className={styles.scaleBy}>by </span>
      <span className={styles.fieldName}>{field}</span>
      {isColor && !isContinuous && <Discrete scale={scale} />}
      {isColor && isContinuous && <Continuous scale={scale} />}
    </div>
  );
};

type DiscreteProps = Pick<ScaleProps, "scale">;

const Discrete = ({ scale }: DiscreteProps) => {
  const colors: [string, any][] = useMemo(() => {
    return "ticks" in scale ? scale.ticks(6).map((tick) => [rgba(scale(tick)), tick]) : [];
  }, [scale]);

  const height = 10 + 14 * (colors.length - 1);

  return (
    <svg className={styles.colorScale} height={height}>
      {colors.map(([color, tick], index) => (
        <svg key={tick} y={14 * index}>
          <rect width={20} height={10} fill={color} />
          <text className={styles.tick} x={28} y={8}>
            {tick}
          </text>
        </svg>
      ))}
    </svg>
  );
};

const Continuous = ({ scale }: Pick<ScaleProps, "scale">) => {
  const id = useId("gradient");

  const colors: string[] = useMemo(() => {
    return scale.ticks(6).map((tick) => rgba(scale(tick)));
  }, [scale]);

  const ticks: string[] = useMemo(() => {
    return scale.ticks(6);
  }, [scale]);

  const height = 10 + 14 * (colors.length - 1);

  return (
    <svg className={styles.colorScale} height={height} width="100%">
      <defs>
        <linearGradient id={id} x1={0} x2={0} y1={0} y2={1}>
          {colors.map((color, index) => (
            <stop key={index} offset={index / (colors.length - 1)} stopColor={color} />
          ))}
        </linearGradient>
      </defs>
      <rect width={20} height="100%" fill={`url(#${id})`} />
      <svg x={28}>
        {ticks.map((tick, index) => (
          <text key={index} className={styles.tick} y={8 + index * 14}>
            {tick}
          </text>
        ))}
      </svg>
    </svg>
  );
};

const useId = (prefix: string) => {
  return useMemo(() => {
    return `${prefix}-${counter()}`;
  }, [prefix]);
};

const counter = (() => {
  let count = 0;
  return () => count++;
})();

export default memo(Legend);