const fs = require("fs");
const { dedent } = require("ts-dedent");
const { snakeCase } = require("snake-case");
const { Parameter } = require("./parameter");
// @ts-ignore
const { exclude } = require("./config.json");

class Layer {
  type;
  name;
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

    this.parameters.unshift({ name: "id", default: `"${type.layerName}"` });
  }

  get documentation() {
    return dedent(`
    #' @name ${this.name}
    #' @template ${this.name}
    #' @family layers
    #' @export
    `);
  }

  get signature() {
    const parameters = this.parameters.map((p) => {
      return p.default ? `${p.name} = ${p.default}` : p.name;
    });

    return dedent(`
    ${this.name} <- function(${parameters.join(",\n")},
      ...)
    `);
  }

  get body() {
    const geometryParam = this.parameters.find((param) =>
      ["get_path", "get_polygon", "get_position"].includes(param.name)
    );

    const autoGeometry = geometryParam
      ? dedent(`
        # auto-resolve geometry
        if (inherits(data, "sf")) {
          parameters$${geometryParam.name} <- as.name(attr(data, "sf_column"))
        }

      `)
      : "";

    return dedent(`
      arguments <- get_arguments()
      parameters <- c(
        list(type = "${this.type.layerName}"),
        get_arguments()
      )
      ${autoGeometry}
      do.call(layer, parameters)
    `);
  }

  get declaration() {
    return dedent(`
      ${this.documentation}
      ${this.signature} {
        ${this.body}
      }
  `);
  }
}

class AddLayer extends Layer {
  constructor(layer) {
    super(layer);

    this.layer = this.name;
    this.name = `add_${this.name}`;

    this.parameters.unshift({ name: "rdeck" });
  }

  get documentation() {
    return dedent(`
    #' @describeIn ${this.layer}
    #'  Add ${this.type.layerName} to an rdeck map
    #' @inheritParams add_layer
    #' @export
    `);
  }

  get body() {
    return dedent(`
      parameters <- get_arguments()[-1]
      layer <- do.call(${this.layer}, parameters)

      add_layer(rdeck, layer)
    `);
  }
}

function generateLayer(layerType) {
  const layer = new Layer(layerType);
  const addLayer = new AddLayer(layerType);

  const content = [layer, addLayer].map((x) => x.declaration).join("\n\n");
  fs.writeFileSync(`./R/${layer.name}.R`, content);
}

module.exports = {
  generateLayer,
};
