import type { PickInfo, ObjectInfo } from "@deck.gl/core";
import styles from "./tooltip.css";

export interface TooltipProps {
  info: PickInfo<any> | null;
}

export function Tooltip({ info }: TooltipProps) {
  if (info == null) return null;

  const { index, layer, x, y } = info;
  const { name, tooltip } = layer.props;

  const getData = accessorFn(tooltip!.dataType);
  // we only use data when it is stored as a dataframe
  const data = getData(info.object, { index, data: layer.props.data as any });
  const names = tooltip!.cols === true ? Object.keys(data) : tooltip!.cols;

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

type Info = Omit<ObjectInfo<DataFrame, any>, "target">;
type DataFn = (object: Record<string, any>, info: Info) => Record<string, any>;

function accessorFn(dataType: DataType): DataFn {
  switch (dataType) {
    case "table":
      return (object, { index, data }) => {
        const entries = Object.entries(data.frame).map(([name, value]) => [name, value[index]]);
        return Object.fromEntries(entries);
      };
    case "object":
      return (object) => object ?? {};
    case "geojson":
      return (object) => object?.properties ?? {};
    default:
      throw TypeError(`${dataType} not supported`);
  }
}
