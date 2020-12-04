import { Feature } from "geojson";
import { parseColor } from "./color";

export type AccessorFn<T> = (object: T, info: ObjectInfo<T>) => any;
export type ObjectInfo<T> = {
  index: number;
  data: T;
  target: any[];
};

type AccessorBase = {
  type: "accessor";
  col: string;
};

type AccessorTable = AccessorBase & {
  dataType: "table";
  getData: AccessorFn<DataFrame>;
};

type AccessorObject = AccessorBase & {
  dataType: "object";
  getData: AccessorFn<Record<string, any>>;
};

type AccessorGeoJson = AccessorBase & {
  dataType: "geojson";
  getData: AccessorFn<Feature>;
};

export type Accessor = AccessorTable | AccessorObject | AccessorGeoJson;

export function isAccessor(obj: any): obj is Accessor {
  return obj !== null && typeof obj === "object" && obj.type === "accessor";
}

export function accessor(obj: Accessor, name: string): Accessor {
  const getData = accessorFn(obj, name.endsWith("Color")) as any;
  return {
    ...obj,
    getData,
  };
}

function accessorFn({ col, dataType }: Accessor, isColor: boolean) {
  switch (dataType) {
    case "table":
      return tableFn(col, isColor);
    case "object":
      return objectFn(col, isColor);
    case "geojson":
      return geojsonFn(col, isColor);
    default:
      throw TypeError(`${dataType} not supported`);
  }
}

function geojsonFn(col: string, isColor: boolean): AccessorFn<Feature> {
  // object.properties will always exist
  return isColor
    ? (object, { target }) => parseColor(object.properties![col], target as Color)
    : (object) => object.properties![col];
}

function objectFn(col: string, isColor: boolean): AccessorFn<Record<string, any>> {
  return isColor
    ? (object, { target }) => parseColor(object[col], target as Color)
    : (object) => object[col];
}

function tableFn(col: string, isColor: boolean): AccessorFn<DataFrame> {
  return isColor
    ? (object, { index, data, target }) => parseColor(data.frame[col][index], target as Color)
    : (object, { index, data }) => data.frame[col][index];
}
