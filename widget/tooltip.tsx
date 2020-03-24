import React, { memo } from "react";
import { PickInfo } from "deck.gl";
import styles from "./tooltip.css";

export interface TooltipProps {
  info: PickInfo<any> | null;
}

const Tooltip = ({ info }: TooltipProps) => {
  // TODO: move logic to hover handle
  if (info == null) return null;

  const { index, layer, x, y } = info;
  const { id: name, tooltip, data } = layer.props;
  const isColumnar = info.object == null;
  const object = isColumnar ? data.frame : info.object;

  // TODO: do something sensible with array properties
  const getValue = isColumnar ? (key: string) => object[key][index] : (key: string) => object[key];
  const names = typeof tooltip === "boolean" ? Object.keys(object) : [tooltip].flat();

  return (
    <div className={styles.tooltip} style={{ transform: `translate(${x}px, ${y}px)` }}>
      <div className={styles.layerName}>{name}</div>
      <table>
        <tbody>
          {names.map((name) => (
            <tr key={name}>
              <td className={styles.fieldName}>{name}</td>
              <td className={styles.fieldValue}>{JSON.stringify(getValue(name))}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default memo(Tooltip);
