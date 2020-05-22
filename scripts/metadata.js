const fs = require("fs");
const { dedent } = require("ts-dedent");
const { snakeCase } = require("snake-case");
const { isAccessor, isGeo, isGeometry, isScalable } = require("./parameter");

function generateAccessorNames(layers) {
  const accessors = Object.values(layers)
    // @ts-ignore
    .flat()
    .map((layer) => {
      new layer();

      return Object.values(layer._propTypes).filter(isAccessor);
    })
    .flat();

  const geometryAccessors = accessors.filter(isGeometry);
  const geoAccessors = accessors.filter(isGeo);
  const scalableAccessors = accessors.filter(isScalable);

  const otherAccessors = accessors
    .filter((x) => !geometryAccessors.includes(x))
    .filter((x) => !geoAccessors.includes(x))
    .filter((x) => !scalableAccessors.includes(x));

  return dedent(`
    geometry_accessors <- c(
      ${getAccessorNames(geometryAccessors).map(quote).join(",\n")}
    )

    geo_accessors <- c(
      ${getAccessorNames(geoAccessors).map(quote).join(",\n")}
    )

    scalable_accessors <- c(
      ${getAccessorNames(scalableAccessors).map(quote).join(",\n")}
    )

    accessors <- c(
      geometry_accessors,
      geo_accessors,
      scalable_accessors,
      ${getAccessorNames(otherAccessors).map(quote).join(",\n")}
    )
  `);
}

function getAccessorNames(accessors) {
  const names = new Set(
    accessors
      .map((accessor) => accessor.name)
      .sort()
      .flatMap((name) => [snakeCase(name), name])
  );

  return [...names];
}

function generateLayerTypes(layers) {
  const layerTypes = Object.entries(layers).map(([group, layers]) =>
    dedent(`
      ${snakeCase(group)} <- c(
        ${layers.map((layer) => quote(layer.layerName)).join(",\n")}
      )
    `)
  );

  return dedent(`
    ${layerTypes.join("\n\n")}

    layers <- c(
      ${Object.keys(layers)
        // @ts-ignore
        .map(snakeCase)
        .join(",\n")}
    )
  `);
}

function generateMetadata(layers) {
  const content = [generateLayerTypes(layers), generateAccessorNames(layers)].join("\n\n");

  fs.writeFileSync("./R/deckgl_metadata.R", content);
}

function quote(value) {
  return `"${value}"`;
}

module.exports = {
  generateMetadata,
};
