import type { PickInfo, AccessorFn } from "@deck.gl/core";
import type { Feature } from "geojson";
import { parseColor } from "./color";

type AccessorBase = {
  type: "accessor";
  col: string;
};

type AccessorTable = AccessorBase & {
  dataType: "table";
  getData: AccessorFn<DataFrame, any>;
};

type AccessorObject = AccessorBase & {
  dataType: "object";
  getData: AccessorFn<Record<string, any>, any>;
};

type AccessorGeoJson = AccessorBase & {
  dataType: "geojson";
  getData: AccessorFn<Feature, any>;
};

export type Accessor = AccessorTable | AccessorObject | AccessorGeoJson;

export function isAccessor(obj: any): obj is Accessor {
  return obj !== null && typeof obj === "object" && obj.type === "accessor";
}

export function accessor(obj: Accessor, name: string): Accessor {
  const getData = accessorFn(obj, name) as AccessorFn<any, any>;
  return {
    ...obj,
    getData,
  };
}

function accessorFn({ col, dataType }: Accessor, name: string): AccessorFn<any, any> {
  if (name === "highlightColor") {
    switch (dataType) {
      case "table":
        return tableHighlight(col);
      case "object":
        return objectHighlight(col);
      case "geojson":
        return geojsonHighlight(col);
      default:
        throw TypeError(`${dataType} not supported`);
    }
  }

  if (name.endsWith("Color")) {
    switch (dataType) {
      case "table":
        return tableColor(col);
      case "object":
        return objectColor(col);
      case "geojson":
        return geojsonColor(col);
      default:
        throw TypeError(`${dataType} not supported`);
    }
  }

  switch (dataType) {
    case "table":
      return tableData(col);
    case "object":
      return objectData(col);
    case "geojson":
      return geojsonData(col);
    default:
      throw TypeError(`${dataType} not supported`);
  }
}

function tableData(col: string): AccessorFn<DataFrame, any> {
  return (_, { index, data }) => data.frame[col][index];
}

function tableColor(col: string): AccessorFn<DataFrame, Color> {
  return (_, { index, data, target }) => parseColor(data.frame[col][index], target);
}

function tableHighlight(col: string): AccessorFn<PickInfo<null>, Color> {
  return ({ index, layer }) =>
    // @ts-ignore
    parseColor(layer.props.data!.frame[col][index]);
}

function objectData(col: string): AccessorFn<Record<string, any>, any> {
  return (object) => object[col];
}

function objectColor(col: string): AccessorFn<Record<string, any>, Color> {
  return (object, { target }) => parseColor(object[col], target);
}

function objectHighlight(col: string): AccessorFn<PickInfo<Record<string, any>>, Color> {
  return ({ object }) => parseColor(object[col]);
}

function geojsonData(col: string): AccessorFn<Feature, any> {
  return (object) => object.properties![col];
}

function geojsonColor(col: string): AccessorFn<Feature, Color> {
  return (object, { target }) => parseColor(object.properties![col], target);
}

function geojsonHighlight(col: string): AccessorFn<PickInfo<Feature>, Color> {
  return ({ object }) => parseColor(object.properties![col]);
}
