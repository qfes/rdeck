const fs = require("fs");
const { dedent } = require("ts-dedent");
const { snakeCase } = require("snake-case");

function generateAccessorNames(layers) {
  const accessors = layers
    .map(layer => {
      new layer();

      return Object.values(layer._propTypes).filter(propType => propType.type === "accessor");
    })
    .flat();

  const accessorNames = new Set(
    accessors.map(accessor => [accessor.name, snakeCase(accessor.name)]).flat()
  );

  return dedent(`
    # accessor names
    accessor_names <- c(
      ${[...accessorNames].map(name => `"${name}"`).join(",\n")}
    )
  `);
}

function generateLayerTypes(layers) {
  const layerTypes = layers.map(layer => layer.layerName);

  return dedent(`
    # layer types
    layer_types <- c(
      ${layerTypes.map(name => `"${name}"`).join(",\n")}
    )
  `);
}

function generateMetadata(layers) {
  const content = [generateLayerTypes(layers), generateAccessorNames(layers)].join("\n\n");

  fs.writeFileSync("./R/deckgl_metadata.R", content);
}

module.exports = {
  generateMetadata
};
