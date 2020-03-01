const { Deck } = require("@deck.gl/core");
const { dedent } = require("ts-dedent");
const { paramCase: kebabCase } = require("param-case");
const { snakeCase } = require("snake-case");

// FIXME: find a cleaner solution
// @ts-ignore
const LAYERS_URL = `https://github.com/uber/deck.gl/blob/v${Deck.VERSION}/docs/layers`;

class Layer {
  type;
  name;
  parameters;
  url;

  constructor(type, parameters) {
    /**
     * HACK
     * GeoJsonLayer -> geojson_layer
     * Tile3DLayer -> tile3d_layer
     */
    const name = type.replace("GeoJson", "Geojson").replace("3D", "3d");
    const page = kebabCase(name.replace("3d", "_3d"));

    this.type = type;
    this.name = snakeCase(name);
    this.url = `${LAYERS_URL}/${page}.md`;
    this.parameters = parameters;
  }

  get documentation() {
    return dedent(`
    #' [${this.type}](${this.url}) deck.gl layer.
    #'
    #' @name ${this.name}
    #'
    #' @param id [\`character\`]
    #'  The id of the layer. Layer ids must be unique per layer \`type\` for deck.gl
    #'  to properly distinguish between them.
    #'
    ${this.parameters.map(param => param.documentation).join("\n#'\n")}
    #'
    #' @param ... additional layer parameters to pass to deck.gl.
    #'  \`snake_case\` parameters will be converted to \`camelCase\`.
    #'
    #' @returns \`${this.type}\` & [\`layer\`]
    #'  A [${this.type}](${this.url}) layer.
    #'  Add to an [rdeck] map via [\`add_layer\`] or [\`rdeck\`].
    #'
    #' @seealso \\url{${this.url}}
    #'
    #' @export
    `);
  }

  get signature() {
    return dedent(`
    ${this.name} <- function(id = NULL,
      ${this.parameters.map(p => `${p.name} = ${p.default}`).join(",\n  ")},
      ...)
    `);
  }

  get body() {
    const isColumnar = this.type !== "GeoJsonLayer";

    const accessors = this.parameters
      .filter(p => p.isAccessor)
      .map(param => {
        if (["get_path", "get_polygon", "get_position"].includes(param.name)) {
          return dedent(`
            # auto-resolve geometry column
            if (inherits(data, "sf")) {
              ${param.name} <- as.name(attr(data, "sf_column")) %>%
                accessor(data = data, columnar = ${isColumnar ? "TRUE" : "FALSE"})
            }
          `);
        }

        return dedent(`
          ${param.name} <- substitute(${param.name}) %>%
            accessor(data = data, columnar = ${isColumnar ? "TRUE" : "FALSE"})
        `);
      });

    return dedent(`
      ${accessors.join("\n\n")}

      params <- c(
        list(
          type = "${this.type}",
          id = id,
          ${this.parameters.map(param => `${param.name} = ${param.name}`).join(",\n  ")}
        ),
        list(...)
      )

      do.call(layer, params)
    `);
  }
}

class AddLayer extends Layer {
  constructor(type, params) {
    super(type, params);

    this.layer = this.name;
    this.name = `add_${this.name}`;
  }

  get documentation() {
    return dedent(`
    #' Add a [${this.type}](${this.url}) deck.gl layer to an [rdeck] map.
    #'
    #' @name ${this.name}
    #'
    #' @param rdeck [\`rdeck\`]
    #'  An [rdeck] map.
    #'
    #' @inheritParams ${this.layer}
    #' @inheritDotParams ${this.layer}
    #'
    #' @returns [\`rdeck\`]
    #'  The [rdeck] map.
    #'
    #' @seealso \\url{${this.url}}
    #'
    #' @export
    `);
  }

  get signature() {
    return dedent(`
      ${this.name} <- function(rdeck,
        id = NULL,
        ${this.parameters.map(p => `${p.name} = ${p.default}`).join(",\n  ")},
        ...)
    `);
  }

  get body() {
    return dedent(`
      params <- as.list(match.call())[-(1:2)]
      layer <- do.call(${this.layer}, params)

      add_layer(rdeck, layer)
    `);
  }
}

module.exports = {
  Layer,
  AddLayer
};
