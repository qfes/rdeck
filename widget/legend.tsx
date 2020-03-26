import React, { memo, useMemo } from "react";
import styles from "./legend.css";
import ScaledAccessor from "./scale";
import { words, rgba } from "./util";

export interface LegendProps {
  layers: LayerProps[];
}

const Legend = ({ layers }: LegendProps) => {
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
  scales: ScaledAccessor[];
}

const Layer = ({ name, scales }: LayerProps) => {
  return (
    <div className={styles.layer}>
      <div className={styles.layerName}>{name}</div>
      {scales.map((scale) => (
        <Scale key={scale.name} {...scale} />
      ))}
    </div>
  );
};

interface ScaleProps extends ScaledAccessor {}

const Scale = ({ name, field, scale }: ScaleProps) => {
  const scaleName = words(name.replace(/^get/, ""));
  const isColor = /color$/i.test(name);
  const colors: [string, any][] = useMemo(() => {
    return isColor ? scale.ticks(5).map((tick) => [rgba(scale(tick)), tick]) : [];
  }, [scale, isColor]);

  return (
    <div className={styles.scale}>
      <div className={styles.scaleName}>{scaleName}</div>
      <span className={styles.scaleBy}>by </span>
      <span className={styles.fieldName}>{field}</span>
      {isColor && (
        <svg className={styles.colors} height={10 + 14 * (colors.length - 1)}>
          {colors.map(([color, tick], index) => (
            <svg key={tick} y={14 * index}>
              <rect width={20} height={10} fill={color} />
              <text className={styles.tick} x={28} y={8}>
                {tick}
              </text>
            </svg>
          ))}
        </svg>
      )}
    </div>
  );
};

export default memo(Legend);
