import { ObjectInfo } from "@deck.gl/core";
import { PickInfo } from "deck.gl";
import { Feature } from "geojson";
import { isTable } from "./table";

export const FEATURE_ID = ".feature_id";

export function getPickedObject(info: PickInfo<any>) {
  if (!info.picked) return null;

  const { object, index } = info;
  const data = info.layer.props.data;
  return getData(object, { index, data });
}

function isGeojson(object: Record<string, any> | null): object is Feature {
  return object?.type === "Feature" && "geometry" in object && "type" in object.geometry;
}

type Info = Omit<ObjectInfo<any, any>, "target">;

function getData(object: any, { data, index }: Info): Record<string, any> {
  if (isTable(data)) {
    const object: Record<string, any> = {};
    for (const col in data.columns) {
      object[col] = data.at(index, col);
    }
    return object;
  }

  return isGeojson(object) ? { [FEATURE_ID]: object.id, ...object.properties } : { ...object };
}
