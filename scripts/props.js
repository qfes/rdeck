/* eslint-disable react/forbid-foreign-prop-types */
const deck = require("deck.gl");
const aggregationLayers = require("@deck.gl/aggregation-layers");
const rdeckPropTypes = require("./rdeck-prop-types.json");

/* exclude props from function signatures */
const excludeProps = [
  /* layer */
  "coordinateOrigin",
  "coordinateSystem",
  "dataComparator",
  "dataTransform",
  "extensions",
  "fetch",
  "getPolygonOffset",
  "highlightedObjectIndex",
  "modelMatrix",
  "parameters",
  "uniforms",
  "updateTriggers",
  "loaders",
  "transitions",
  /* composite layer */
  "renderSubLayers",
  /* geojson layer */
  "textCharacterSet",
  /* text layer */
  "characterSet",
  /* aggregation functions */
  "gridAggregator",
  "hexagonAggregator",
  /* mask */
  "operation",
];

function getProps(Layer) {
  // initialise _propTypes
  new Layer();
  let propTypes = { ...Layer._propTypes };

  // id, name, groupName appear first
  propTypes = {
    ...Object.fromEntries(
      rdeckPropTypes
        .filter((p) => ["id", "name", "groupName"].includes(p.name))
        .map((p) => [p.name, p])
    ),
    ...propTypes,
  };

  // merge in custom rdeck propTypes
  rdeckPropTypes.forEach((propType) => {
    if (propType.name === "name") propType.value = Layer.layerName;
    propTypes[propType.name] = {
      ...propTypes[propType.name],
      ...propType,
    };
  });

  // trips layer
  if (Layer === deck.TripsLayer) {
    delete propTypes.currentTime;
    propTypes.getTimestamps.value = function (object) {
      return object.timestamps;
    };
    propTypes = {
      ...propTypes,
      loopLength: { name: "loopLength", type: "number", value: 1800, min: 0 },
      animationSpeed: { name: "animationSpeed", type: "number", value: 30, min: 0 },
    };
  }

  // tile layer should inherit bitmap
  if (Layer === deck.TileLayer) {
    // @ts-ignore
    new deck.BitmapLayer({});
    // @ts-ignore
    const { image, bounds, ...inherited } = deck.BitmapLayer._propTypes;

    propTypes = {
      // tile props first
      ...propTypes,
      ...inherited,
      // use tile defaults
      ...propTypes,
    };
  }

  // no tooltip for arregation layers
  if (Object.values(aggregationLayers).includes(Layer)) {
    delete propTypes.tooltip;
  }

  // extruded = false
  if ("extruded" in propTypes) {
    propTypes.extruded.value = false;
  }

  // tilt range
  if ("getTilt" in propTypes) {
    propTypes.getTilt = {
      ...propTypes.getTilt,
      min: -90,
      max: 90,
    };
  }

  // remove polygon from geo-layers
  if (/^S2|H3/.test(Layer.layerName)) {
    // we don't need this
    delete propTypes.getPolygon;
  }

  // default text layer font
  if ("fontFamily" in propTypes) {
    propTypes.fontFamily.value = "Roboto, Helvetica, Arial, san-serif";
  }

  if ("textFontFamily" in propTypes) {
    propTypes.textFontFamily.value = "Roboto, Helvetica, Arial, san-serif";
  }

  return Object.values(propTypes)
    .filter((propType) => !excludeProps.includes(propType.name))
    .filter((propType) => !/^(_|on)/.test(propType.name))
    .map((propType) => ({
      ...propType,
      type: /get(Color|Elevation)Value/.test(propType.name) ? "unknown" : propType.type,
      value: getValue(propType),
      valueType: getValueType(propType),
      isScalable: getScalable(propType),
      isOptional: getOptional(propType),
      isScalar: getScalar(propType),
      values: getValues(propType),
      length: getLength(propType),
    }));
}

function getValue({ value }) {
  if (typeof value !== "function") return value;

  // is accessor a function returning a constant?
  try {
    return value();
  } catch {
    return value;
  }
}

function getValueType(propType) {
  const value = getValue(propType);
  const isSimpleType = ["boolean", "string", "color", "number"].includes(propType.type);

  if (propType.name === "data") return "data";
  // bool or char
  if (propType.name === "highPrecisions") return null;
  if (value == null) return isSimpleType ? propType.type : null;
  if (Array.isArray(value) && /(color|colorRange)$/i.test(propType.name)) return "color";
  return Array.isArray(value) ? "array" : typeof value;
}

function getScalable({ type, name }) {
  return type === "accessor" && /(radius|elevation|color|weight|width|height|size)$/i.test(name);
}

function getOptional({ optional, value, type }) {
  return (
    optional ||
    value === null ||
    type === "function" ||
    (Array.isArray(value) && value.length === 0)
  );
}

function getScalar(propType) {
  const valueType = getValueType(propType);

  if (valueType == null) return null;
  if (["boolean", "string", "number"].includes(valueType)) return true;
  if (valueType === "color") return !Array.isArray(propType.value[0]);

  return false;
}

function getValues(propType) {
  if (propType.values != null)
    return Array.isArray(propType.values) ? propType.values : [propType.values];

  if (/units$/i.test(propType.name)) return ["common", "meters", "pixels"];
  if (/textAnchor$/i.test(propType.name)) return ["start", "middle", "end"];
  if (/alignmentBaseline$/i.test(propType.name)) return ["top", "center", "bottom"];
  if (/wordBreak$/i.test(propType.name)) return ["break-word", "break-all"];
  if (/fontWeight$/i.test(propType.name))
    return ["normal", "bold", 100, 200, 300, 400, 500, 600, 700, 800, 900];

  if (/aggregation$/i.test(propType.name) && propType.name !== "gpuAggregation")
    return ["SUM", "MEAN", "MIN", "MAX"];
  if (/scaleType$/i.test(propType.name)) return ["quantize", "linear", "quantile", "ordinal"];

  if (/refinementStrategy$/i.test(propType.name)) return ["best-available", "no-overlap", "never"];
  if (/highPrecision$/i.test(propType.name)) return [true, false, "auto"];
}

function getLength(propType) {
  const value = getValue(propType);
  const valueType = getValueType(propType);

  if (valueType !== "array" || ["data", "contours"].includes(propType.name)) return null;

  if (/padding$/i.test(propType.name)) return [2, 4];
  if (/domain$/i.test(propType.name)) return 2;
  if (propType.name === "extent") return 4;

  // use length of default
  return Array.isArray(value) && value.length > 1 ? value.length : null;
}

module.exports = { getProps };
