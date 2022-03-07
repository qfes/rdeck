/* eslint-disable react/forbid-foreign-prop-types */
const deck = require("deck.gl");

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
];

function getProps(Layer) {
  // initialise _propTypes
  new Layer();
  Layer.propTypes = { ...Layer._propTypes };

  // extruded = false
  if ("extruded" in Layer.propTypes) {
    Layer.propTypes.extruded.value = false;
  }

  // visible optional
  if ("visible" in Layer.propTypes) {
    Layer.propTypes.visible.optional = true;
  }

  // remove polygon from geo-layers
  if (/^S2|H3/.test(Layer.layerName)) {
    // we don't need this
    delete Layer.propTypes.getPolygon;
  }

  // default text layer font
  if (Layer === deck.TextLayer) {
    Layer.propTypes.fontFamily.value = "Roboto, Helvetica, Arial, san-serif";
  }

  // trips layer
  if (Layer === deck.TripsLayer) {
    delete Layer.propTypes.currentTime;
    Layer.propTypes.getTimestamps.value = function (object) {
      return object.timestamps;
    };
    Layer.propTypes = {
      ...Layer.propTypes,
      loopLength: { name: "loopLength", type: "number", value: 1800, min: 0 },
      animationSpeed: { name: "animationSpeed", type: "number", value: 30, min: 0 },
    };
  }

  // mvt layer should inherit geojson
  if (Layer === deck.MVTLayer) {
    new deck.GeoJsonLayer({});
    // @ts-ignore
    const inherited = deck.GeoJsonLayer.propTypes;

    // include geojson props
    Layer.propTypes = {
      ...Layer.propTypes,
      ...inherited,
    };
  }

  // tile layer should inherit bitmap
  if (Layer === deck.TileLayer) {
    // @ts-ignore
    new deck.BitmapLayer({});
    // @ts-ignore
    const { image, bounds, ...inherited } = deck.BitmapLayer.propTypes;

    Layer.propTypes = {
      ...Layer.propTypes,
      ...inherited,
    };
  }

  return Object.values(Layer.propTypes)
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

  if (value == null) return null;
  if (propType.name === "data") return "data";
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
  if (valueType === "color") return !Array.isArray(valueType[0]);

  return false;
}

module.exports = { getProps };
