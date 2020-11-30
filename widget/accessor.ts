import { Feature } from "geojson";

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
}

type AccessorGeoJson = AccessorBase & {
  dataType: "geojson";
  getData: AccessorFn<Feature>;
}

export type Accessor = AccessorTable | AccessorObject | AccessorGeoJson;

export function isAccessor(obj: any): obj is Accessor {
  return obj !== null && typeof obj === "object" && obj.type === "accessor";
}

export function accessor(obj: Accessor): Accessor {
  const getData = accessorFn(obj) as any;
  return {
    ...obj,
    getData,
  };
}

function accessorFn({ col, dataType }: Accessor) {
  switch (dataType) {
    case "table":
      return tableFn(col);
    case "object":
      return objectFn(col);
    case "geojson":
      return geojsonFn(col);
    default:
      throw TypeError(`${dataType} not supported`);
  }
}

function geojsonFn(col: string): AccessorFn<Feature> {
  // object.properties will always exist
  return (object) => object.properties![col];
}

function objectFn(col: string): AccessorFn<Record<string, any>> {
  return (object) => object[col];
}

function tableFn(col: string): AccessorFn<DataFrame> {
  return (object, { index, data }) => data.frame[col][index];
}
