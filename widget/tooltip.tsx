import type { PickInfo } from "@deck.gl/core";
import { FEATURE_ID, getPickedObject } from "./picking";
import styles from "./tooltip.module.css";

export interface TooltipProps {
  info: PickInfo<any>;
}

export function Tooltip({ info }: TooltipProps) {
  if (!info.picked || info.layer.props.tooltip == null) return null;

  const { x, y } = info;
  const { name, tooltip } = info.layer.props;

  const object = getPickedObject(info)!;
  delete object[FEATURE_ID];
  const names: string[] = tooltip.cols === true ? Object.keys(object) : tooltip.cols;

  return (
    <div className={styles.tooltip} style={{ transform: `translate(${x}px, ${y}px)` }}>
      <div className={styles.layerName}>{name}</div>
      <table className={styles.table}>
        <tbody>
          {names.map((name) => (
            <tr key={name}>
              <td className={styles.fieldName}>{name}</td>
              <td className={styles.fieldValue}>{String(object[name] ?? null)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
