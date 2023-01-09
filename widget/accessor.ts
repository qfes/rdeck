import type { PickInfo, AccessorFn } from "@deck.gl/core";
import type { Color } from "./types";
import { parseColor } from "./color";

export type Accessor = {
  type: "accessor";
  col: string;
  getData: AccessorFn<any, any>;
};

export function isAccessor(obj: any): obj is Accessor {
  return obj !== null && typeof obj === "object" && obj.type === "accessor";
}

export function accessor(obj: Accessor, prop: string): Accessor {
  return {
    ...obj,
    getData: getData(obj, prop),
  };
}

function getData({ col }: Accessor, prop: string): AccessorFn<any, any> {
  if (!prop.endsWith("Color")) return getValue(col);
  return prop !== "highlightColor" ? getColor(col) : getHighlightColor(col);
}

export function getValue<In = any, Out = any>(col: string): AccessorFn<In, Out> {
  return (object, { data, index }) =>
    // @ts-ignore
    object == null ? data.at(index, col) : object.properties?.[col] ?? object[col];
}

export function getPickValue<In = any, Out = any>(col: string): (info: PickInfo<In>) => Out {
  return ({ object, index, layer }) =>
    // @ts-ignore
    object == null ? layer.props.data?.at(index, col) : object.properties?.[col] ?? object[col];
}

function getColor(col: string): AccessorFn<any, Color> {
  const fn = getValue(col);
  return (object, { data, index, target }) =>
    parseColor(fn(object, { data, index, target }), target);
}

function getHighlightColor(col: string): (info: PickInfo<any>) => Color {
  const fn = getPickValue(col);
  return (info) => parseColor(fn(info));
}
