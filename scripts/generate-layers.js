const fs = require("fs");
const { dedent } = require("ts-dedent");
const { Parameter } = require("./parameter");
const { Layer, AddLayer } = require("./layer");

// keep the function signatures brief
const exclude = [
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

  "renderSubLayers"
];

/**
 * Get all layer classes from a module
 *
 * @param {module} module
 */
function getLayers(module) {
  return Object.keys(module)
    .filter(name => !name.startsWith("_"))
    .map(name => module[name])
    .filter(layer => layer.layerName);
}

/**
 * Generate R function for layer
 *
 * @param {any} deckglLayer
 */
function generateLayer(deckglLayer) {
  // initialise propTypes
  new deckglLayer({});

  const parameters = Object.values(deckglLayer._propTypes)
    .filter(propType => !exclude.includes(propType.name))
    .filter(propType => !/^(_|on)/.test(propType.name))
    .map(propType => new Parameter(propType));

  const definition = layer => dedent`
      ${layer.documentation}
      ${layer.signature} {
        ${layer.body}
      }
    `;

  const layer = new Layer(deckglLayer.layerName, parameters);
  const addLayer = new AddLayer(deckglLayer.layerName, parameters);

  fs.writeFileSync(`./R/${layer.name}.R`, definition(layer));
  fs.writeFileSync(`./R/${addLayer.name}.R`, definition(addLayer));
}

const layers = [
  ...getLayers(require("@deck.gl/layers")),
  ...getLayers(require("@deck.gl/aggregation-layers")),
  ...getLayers(require("@deck.gl/geo-layers")),
  ...getLayers(require("@deck.gl/mesh-layers"))
];

layers.forEach(generateLayer);

// write layer_types
fs.writeFileSync(
  "./R/layer_types.R",
  dedent(`
    #' Supported deck.gl layer types.
    #'
    #' @name layer_types
    #'
    #' @details
    ${layers.map(layer => `#'   * ${layer.layerName}`).join("\n")}
    layer_types <- c(
      ${layers
        .map(layer => layer.layerName)
        .map(x => `"${x}"`)
        .join(",\n")}
    )`)
);
