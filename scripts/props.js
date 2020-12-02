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
  "wrapLongitude",
  /* composite layer */
  "renderSubLayers",
  /* text layer */
  "characterSet",
];

function getProps(Layer) {
  // initialise _propTypes
  new Layer();

  // remove polygon from geo-layers
  if (/^S2|H3/.test(Layer.layerName)) {
    // we don't need this

    delete Layer._propTypes.getPolygon;
  }

  // default text layer font
  if (Layer === deck.TextLayer) {
    Layer._propTypes.fontFamily.value = "Roboto, san-serif";
    Layer._propTypes.fontSettings.value = { sdf: true };
  }

  // mvt layer should inherit geojson
  if (Layer === deck.MVTLayer) {
    new deck.GeoJsonLayer({});

    // include geojson props
    Layer._propTypes = {
      // @ts-ignore
      ...deck.GeoJsonLayer._propTypes,
      ...Layer._propTypes
    };
  }

  return Object.values(Layer._propTypes)
    .filter((propType) => !excludeProps.includes(propType.name))
    .filter((propType) => !/^(_|on)/.test(propType.name))
    .map(propType => ({
      ...propType,
      value: getValue(propType),
      valueType: getValueType(propType)
    }));
}

function getValue(propType) {
  if (typeof propType.value !== "function") {
    return propType.value;
  }

  try {
    return propType.value();
  } catch {
    return propType.value;
  }
}

function getValueType(propType) {
  const value = getValue(propType);
  if (value == null) {
    return null;
  }

  return Array.isArray(value) ? "array" : typeof value;
}

module.exports = { getProps };
