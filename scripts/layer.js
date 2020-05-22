const fs = require("fs");
const { dedent } = require("ts-dedent");
const { snakeCase } = require("snake-case");
const { paramCase } = require("param-case");
const { Parameter, isAccessor, isGeometry, isScalable } = require("./parameter");
const { Deck } = require("@deck.gl/core");
// @ts-ignore
const { exclude } = require("./config.json");

const DISCLAIMER = `# generated code: this code was generated from deck.gl v${Deck.VERSION}`;

class Layer {
  /** @type {import("@deck.gl/core").Layer} */
  type;
  /** @type {string} */
  name;
  /** @type {Parameter[]} */
  parameters;

  constructor(type) {
    // initialise _propTypes
    new type();

    /**
     * HACK
     * GeoJsonLayer -> geojson_layer
     * Tile3DLayer -> tile3d_layer
     */
    const name = type.layerName.replace("GeoJson", "Geojson").replace("3D", "3d");

    this.type = type;
    this.name = snakeCase(name);
    this.parameters = Object.values(type._propTypes)
      .filter((propType) => !exclude.includes(propType.name))
      .filter((propType) => !/^(_|on)/.test(propType.name))
      .map((propType) => new Parameter(propType));

    this.parameters.unshift(
      // @ts-ignore
      { name: "id", default: `"${type.layerName}"` }
    );
    // @ts-ignore
    this.parameters.push({ name: "tooltip", default: "FALSE" });
  }

  get roxygen() {
    return dedent(`
    #' @rdname ${this.name}
    #' @template ${this.name}
    #' @family layers
    #' @export
    `);
  }

  get signature() {
    const parameters = this.parameters.map((p) =>
      p.default ? `${p.name} = ${p.default}` : p.name
    );

    return dedent(`
    add_${this.name} <- function(rdeck,
      ...,
      ${parameters.join(",\n")})
    `);
  }

  get argnamesBlock() {
    return "";
  }

  get paramsBlock() {
    const params = this.parameters
      .map((p) => modifyParam(p, this.type.layerName !== "GeoJsonLayer"))
      .join(",\n");

    const geometryParam = this.parameters.find(isGeometry);
    const autoGeometry =
      geometryParam == null
        ? ""
        : dedent(`
        # auto-resolve geometry
        if (inherits(data, "sf")) {
          ${geometryParam.name} <- as.name(attr(data, "sf_column"))
          arg_names <- c(arg_names, "${geometryParam.name}") %>% unique()
        }
      `);

    return dedent(`
    arg_names <- rlang::call_args_names(sys.call())[-1]
    ${autoGeometry}
    props <- c(
      list(
        type = "${this.type.layerName}",
        ${params}
      ),
      list(...)
    )[c("type", arg_names)]
  `);
  }

  get body() {
    return dedent(`
      ${this.paramsBlock}
      ${this.name} <- do.call(layer, props)
      add_layer(rdeck, ${this.name})
    `);
  }

  get declaration() {
    return dedent(`
      ${this.roxygen}
      ${this.signature} {
        ${this.body}
      }
  `);
  }

  toString() {
    return this.declaration;
  }
}

/**
 *
 * @param {Parameter} param
 */
function modifyParam(param, isColumnar = false) {
  const columnar = isColumnar ? "TRUE" : "FALSE";
  const enquo = (x) => `rlang::enquo(${x})`;
  if (param.name === "tooltip") {
    return `${param.name} = make_tooltip(${enquo(param.name)}, data)`;
  }

  if (isScalable(param)) {
    return `${param.name} = make_scalable_accessor(${enquo(param.name)}, data, ${columnar})`;
  }

  if (isAccessor(param)) {
    return `${param.name} = make_accessor(${enquo(param.name)}, data, ${columnar})`;
  }

  return `${param.name} = ${param.name}`;
}

class AddLayer extends Layer {
  /** @type {string} */
  layerName;

  constructor(type) {
    super(type);

    this.layerName = this.name;
    this.name = `add_${this.name}`;

    //@ts-ignore
    this.parameters.unshift({ name: "rdeck" });
  }

  get roxygen() {
    return dedent(`
    #' @describeIn ${this.layerName}
    #' Add ${this.type.layerName} to an rdeck map
    #' @inheritParams add_layer
    #' @export
    `);
  }

  get paramsBlock() {
    const params = this.parameters
      .map((p) =>
        p.type === "accessor" || p.name === "tooltip"
          ? `${p.name} = substitute(${p.name})`
          : `${p.name} = ${p.name}`
      )
      .join(",\n");
    return dedent(`
    c(
      list(${params}),
      list(...)
    )[get_argument_names()[-1]]
  `);
  }

  get body() {
    return dedent(`
      params <- ${this.paramsBlock}
      layer <- do.call(${this.layerName}, params)
      add_layer(rdeck, layer)
    `);
  }
}

function generateLayer(module, type) {
  const layer = new Layer(type);

  const content = [DISCLAIMER, layer].join("\n\n");
  fs.writeFileSync(`./R/${layer.name}.R`, content);

  const filter = [
    "id",
    "data",
    "visible",
    "pickable",
    "opacity",
    "position_format",
    "color_format",
    "auto_highlight",
    "highlight_color",
  ];

  const doc = dedent(`
    #' ${layer.type.layerName}
    #'
    #' @name ${layer.name}
    ${layer.parameters
      .filter((p) => !filter.includes(p.name))
      .map((p) => `#' @param ${p.name} \`description-placeholder\``)
      .join("\n")}
    #' @inheritParams layer
    #' @seealso <https://github.com/uber/deck.gl/blob/v8.1.0/docs/layers/${paramCase(
      layer.name
    )}.md>
    NULL
  `);

  //fs.writeFileSync(`./R/${layer.name}-doc.R`, doc);
}

module.exports = {
  generateLayer,
};
