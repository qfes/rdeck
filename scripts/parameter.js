const { snakeCase } = require("./utils");

class Parameter {
  name;
  type;
  default = "NULL";
  propType;

  constructor(propType) {
    const { name, type, value: defaultValue } = propType;

    this.propType = propType;
    this.name = snakeCase(name);
    this.type = Parameter.getType({ name, type, defaultValue });
    this.default = Parameter.getDefault({ name, type, defaultValue });
  }

  static geometryAccesors = ["getPath", "getPolygon", "getPosition"];
  get documentation() {
    const str = `@param ${this.name}`;
    if (!this.type) {
      return str;
    }

    const type = Array.isArray(this.type) ? this.type.join(" | ") : this.type;
    return `${str} \`{${type}}\``;
  }

  get signature() {
    return `${this.name} = ${this.default}`;
  }

  get forward() {
    if (this.propType.type != "accessor") {
      return `${this.name} = ${this.name}`;
    }

    if (!Parameter.geometryAccesors.includes(this.propType.name)) {
      return `${this.name} = accessor(data, substitute(${this.name}))`;
    }

    return `${this.name} = if(inherits(data, "sf") {
        name <- attr(data, "sf_column") %>%
          as.name()
        accessor(data, name)
      } else {
        accessor(data, substitute(${this.name}))
      }`;
  }

  static getType({ name, type, defaultValue }) {
    switch (name) {
      case "data":
        return ["data.frame", "sf"];
      case "positionFormat":
        return [`"XY"`, `"XYZ"`];
      case "colorFormat":
        return [`"RGB"`, `"RGBA"`];
      case "image":
        return [`"image"`, `"character"`];

      case "fontFamily":
      case "fontWeight":
        return "character";
      case "wordBreak":
        return [`"break-all"`, `"break-word"`];
      // case "vertices": array of points

      case "minZoom":
      case "maxZoom":
      case "maxCacheSize":
        return "numeric";

      case "widthUnits":
      case "sizeUnits":
      case "lineWidthUnits":
        return [`"pixels"`, `"meters"`];

      case "aggregation":
      case "colorAggregation":
      case "elevationAggregation":
        return [`"SUM"`, `"MEAN"`, `"MIN"`, `"MAX"`];

      case "colorDomain":
      case "elevationDomain":
        return "numeric";

      case "colorScaleType":
      case "elevationScaleType":
        return [`"quantize"`, `"linear"`, `"quantile"`, `"ordinal"`];
    }

    switch (type) {
      case "unknown":
        return typeToR(typeof defaultValue);
      case "color":
        return "integer";
      case "array":
        if (Array.isArray(defaultValue)) {
          const item = defaultValue[0];
          return Array.isArray(item) ? "list" : typeToR(typeof item);
        }
        break;
      case "accessor": {
        let types = ["accessor"];

        if (["number", "string", "boolean", "function"].includes(typeof defaultValue)) {
          types = [...types, typeToR(typeof defaultValue)];
        }
        return types;
      }
      case "function":
        break;
    }

    return typeToR(type);
  }

  static getDefault({ name, type, defaultValue }) {
    if (name === "characterSet") return "NULL";

    switch (type) {
      case "characterSet":
      case "accessor":
      case "function":
        return "NULL";
      default:
        return valueToR(defaultValue);
    }
  }
}

function valueToR(value) {
  if (value == null || (Array.isArray(value) && value.length === 0)) {
    return "NULL";
  }

  if (Array.isArray(value)) {
    if (Array.isArray(value[0])) {
      return `list(
        ${value.map(valueToR).join(",\n")}
      )`;
    }
    return `c(${value.map(valueToR).join(", ")})`;
  }

  switch (typeof value) {
    case "boolean":
      return String(value).toUpperCase();
    case "number":
      return String(value);
    case "string":
      return JSON.stringify(value);
    case "function":
    default:
      return "NULL";
  }
}

function typeToR(type) {
  switch (type) {
    case "boolean":
      return "logical";
    case "number":
      return "numeric";
    case "string":
      return "character";
    case "function":
      return "JS";
    default:
      return "list";
  }
}

module.exports = {
  Parameter
};
