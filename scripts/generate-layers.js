const fs = require("fs");
const { dedent } = require("ts-dedent");
const { Deck } = require("@deck.gl/core");
const { snakeCase } = require("snake-case");
const { paramCase } = require("param-case");

const { Parameter } = require("./parameter");

// FIXME: find a cleaner solution
// @ts-ignore
const docUrl = `https://github.com/uber/deck.gl/blob/v${Deck.VERSION}/docs/layers`;

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
 * @param {any} layer
 */
function generateLayer(layer) {
  // initialise propTypes
  new layer({});

  // HACK: GeoJsonLayer -> geojson_layer, Tile3DLayer -> tile3d_layer
  const name = layer.layerName.replace("GeoJson", "Geojson").replace("3D", "3d");
  const functionName = "add_" + snakeCase(name);
  const documentationName = paramCase(name.replace("3d", "_3d"));

  const propsTypes = Object.values(layer._propTypes)
    .filter(propType => !exclude.includes(propType.name))
    .filter(propType => !/^(_|on)/.test(propType.name));

  const parameters = propsTypes.map(propType => new Parameter(propType));

  const geometryAccessors = ["get_path", "get_polygon", "get_position"];

  const doc = dedent`
    #' Add ${layer.layerName} to an rdeck map.
    #'
    #' @name ${functionName}
    #' @param rdeck \`{rdeck}\` an rdeck widget instance
    ${parameters.map(p => "#' " + p.documentation).join("\n")}
    #' @param ... additional layer parameters to pass to deck.gl
    #' @returns \`{rdeck}\`
    #'
    #' @seealso \url{${docUrl}/${documentationName}.md}
    #'
    #' @export
  `;

  const code = dedent`
    ${functionName} <- function(rdeck,
      ${parameters.map(p => p.signature).join(",\n  ")},
      ...) {
      stopifnot(inherits(rdeck, "rdeck"))

      ${parameters
        .filter(p => p.propType.type === "accessor")
        .map(p =>
          geometryAccessors.includes(p.name)
            ? `if (inherits(data, "sf")) {
                ${p.name} <- accessor(data, as.name(attr(data, "sf_column")))
              }`
            : `${p.name} <- accessor(data, substitute(${p.name}))`
        )
        .join("\n  ")}

      params <- c(
        list(
          type = "${layer.layerName}",
          ${parameters.map(p => `${p.name} = ${p.name}`).join(",\n    ")}
        ),
        list(...)
      )

      do.call(layer, params) %>%
         add_layer(rdeck, .)
    }
  `;

  fs.writeFileSync(`./R/${functionName}.R`, doc + "\n" + code);
}

const layers = [
  ...getLayers(require("@deck.gl/layers")),
  ...getLayers(require("@deck.gl/aggregation-layers")),
  ...getLayers(require("@deck.gl/geo-layers")),
  ...getLayers(require("@deck.gl/mesh-layers"))
];

layers.forEach(generateLayer);

fs.writeFileSync(
  "./R/layer_types.R",
  `layer_types <- c(
    ${layers
      .map(layer => layer.layerName)
      .map(x => `"${x}"`)
      .join(",\n")}
  )`
);
