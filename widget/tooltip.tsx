import type { PickInfo } from "@deck.gl/core";
import { getPickedObject } from "./picking";
import styles from "./tooltip.css";

export interface TooltipProps {
  info: PickInfo<any> | null;
}

export function Tooltip({ info }: TooltipProps) {
  if (info == null || info.layer.props.tooltip == null) return null;

  const { x, y } = info;
  const { name, tooltip } = info.layer.props;

  const data = getPickedObject(info, tooltip.dataType)!;
  const names = tooltip.cols === true ? Object.keys(data) : tooltip.cols;

  return (
    <div className={styles.tooltip} style={{ transform: `translate(${x}px, ${y}px)` }}>
      <div className={styles.layerName}>{name}</div>
      <table className={styles.table}>
        <tbody>
          {names.map((name) => (
            <tr key={name}>
              <td className={styles.fieldName}>{name}</td>
              <td className={styles.fieldValue}>{String(data[name] ?? null)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
