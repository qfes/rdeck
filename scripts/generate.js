const { generateLayer } = require("./layer");
const { generateMetadata } = require("./metadata.js");

/**
 * Get all layer classes from a module
 *
 * @param {module} module
 */
function getLayers(module) {
  return Object.keys(module)
    .filter((name) => !name.startsWith("_"))
    .map((name) => module[name])
    .filter((layer) => layer.layerName);
}

const layers = {
  "core-layers": getLayers(require("@deck.gl/layers")),
  "aggregation-layers": getLayers(require("@deck.gl/aggregation-layers")),
  "geo-layers": getLayers(require("@deck.gl/geo-layers")),
  "mesh-layers": getLayers(require("@deck.gl/mesh-layers")),
};

Object.entries(layers).forEach(([module, layers]) =>
  layers.forEach((layer) => generateLayer(module, layer))
);
generateMetadata(layers);
