const { generateLayer } = require("./layer");
const { generateMetadata } = require("./metadata.js");
const { generateDependencies } = require("./dependencies");

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

const layers = [
  ...getLayers(require("@deck.gl/layers")),
  ...getLayers(require("@deck.gl/aggregation-layers")),
  ...getLayers(require("@deck.gl/geo-layers")),
  ...getLayers(require("@deck.gl/mesh-layers"))
];

layers.forEach(generateLayer);

generateMetadata(layers);
generateDependencies();
