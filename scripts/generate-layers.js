const fs = require("fs");
const { dedent } = require("ts-dedent");
const { Layer, AddLayer } = require("./layer");

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
  const layer = new Layer(deckglLayer);
  const addLayer = new AddLayer(deckglLayer);

  fs.writeFileSync(`./R/${layer.name}.R`, [layer, addLayer].map(x => x.declaration).join("\n\n"));
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
