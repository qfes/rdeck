import { _AggregationLayer } from "@deck.gl/aggregation-layers";
import { ObjectInfo } from "@deck.gl/core";
import { PickInfo } from "deck.gl";
import { Feature } from "geojson";
import { isDataFrame } from "./data-frame";

export const FEATURE_ID = ".feature_id";

export function getPickedObject(info: PickInfo<any>, dataType: DataType | null = null) {
  if (!info.picked) return null;

  if (dataType == null) {
    dataType = getDataType(info);
  }
  const getData = accessorFn(dataType);

  const { object, index } = info;
  const data = info.layer.props.data;
  return getData(object, { index, data });
}

function getDataType({ object, layer }: PickInfo<any>): DataType {
  // FIXME: add datatype to the layer
  const data = layer.props.data;
  if (isDataFrame(data) && !(layer instanceof _AggregationLayer)) return "table";
  return isGeojson(object) ? "geojson" : "object";
}

function isGeojson(object: Record<string, any> | null): object is Feature {
  return object?.type === "Feature" && "geometry" in object && "type" in object.geometry;
}

type Info = Omit<ObjectInfo<DataFrame, any>, "target">;
type DataFn = (object: Record<string, any>, info: Info) => Record<string, any>;

export function accessorFn(dataType: DataType): DataFn {
  switch (dataType) {
    case "table":
      return (_, { index, data }) => {
        const geoms = Object.keys(data.geometry);
        const object: Record<string, any> = {};
        for (const [key, col] of Object.entries(data.frame)) {
          if (!geoms.includes(key)) object[key] = col[index];
        }
        return object;
      };
    case "object":
      return (object) => ({ ...object });
    case "geojson":
      return (object) => ({
        [FEATURE_ID]: object?.id,
        ...object?.properties,
      });
    default:
      throw TypeError(`${dataType} not supported`);
  }
}
