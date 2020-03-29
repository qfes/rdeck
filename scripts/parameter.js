const { snakeCase } = require("snake-case");
const NULL = "NULL";

class Parameter {
  name;
  type;
  default = NULL;

  constructor({ name, type, value: defaultValue }) {
    this.name = snakeCase(name);
    this.type = Parameter.getType({ name, type, defaultValue });
    this.default = Parameter.getDefault({ name, type, defaultValue });
  }

  get documentation() {
    const name = `#' @param ${this.name}`;
    const type = Array.isArray(this.type) ? this.type.join(" | ") : this.type;
    return `${name} ${type}`;
  }

  static getType({ name, type, defaultValue }) {
    switch (name) {
      case "data":
        return ["[`data.frame`]", "[`sf::sf`]"];
      case "positionFormat":
        return ["`XY`", "`XYZ`"];
      case "colorFormat":
        return ["`RGB`", "`RGBA`"];
      case "image":
        return ["[`image`]", "[`character`]"];
      case "fontFamily":
      case "fontWeight":
        return "[`character`]";
      case "wordBreak":
        return ["`break-all`", "`break-word`"];
      // case "vertices": array of points

      case "minZoom":
      case "maxZoom":
      case "maxCacheSize":
        return "[`numeric`]";

      case "widthUnits":
      case "sizeUnits":
      case "lineWidthUnits":
        return ["`pixels`", "`meters`"];

      case "aggregation":
      case "colorAggregation":
      case "elevationAggregation":
        return ["`SUM`", "`MEAN`", "`MIN`", "`MAX`"];

      case "colorDomain":
      case "elevationDomain":
        return "[`numeric`]";

      case "colorScaleType":
      case "elevationScaleType":
        return ["`quantize`", "`linear`", "`quantile`", "`ordinal`"];
      default:
        break;
    }

    switch (type) {
      case "unknown":
        return typeToR(typeof defaultValue);
      case "color":
        return "[`integer`]";
      case "array":
        if (Array.isArray(defaultValue)) {
          const item = defaultValue[0];
          return Array.isArray(item) ? "[`list`]" : typeToR(typeof item);
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
      default:
        break;
    }

    return typeToR(type);
  }

  static getDefault({ name, type, defaultValue }) {
    switch (name) {
      case "data":
        return "data.frame()";
      // case "characterSet":
      //   return Array.isArray(defaultValue)
      //     ? `"${defaultValue.join("").replace("\\", "\\\\").replace('"', '\\"')}"`
      //     : NULL;
      default:
        break;
    }

    if (name.endsWith("Color") && Array.isArray(defaultValue)) {
      return `"${rgba2hex(defaultValue)}"`;
    }

    if (name === "colorRange" && Array.isArray(defaultValue)) {
      return `c(
        ${defaultValue.map((x) => `"${rgba2hex(x)}"`).join(",\n")}
      )`;
    }

    if (type === "accessor" && typeof defaultValue === "function") {
      const [match] = /(?<=return\s+).*(?=;)/.exec(defaultValue.toString());
      return snakeCase(match.split(".").pop());
    }

    switch (type) {
      case "function":
        return NULL;
      default:
        return valueToR(defaultValue);
    }
  }
}

function valueToR(value) {
  if (value == null || (Array.isArray(value) && value.length === 0)) {
    return NULL;
  }

  if (Array.isArray(value)) {
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
      return NULL;
  }
}

function typeToR(type) {
  switch (type) {
    case "boolean":
      return "[`logical`]";
    case "number":
      return "[`numeric`]";
    case "string":
      return "`[character]`";
    case "function":
      return "[`htmlwidgets::JS`]";
    default:
      return "[`list`]";
  }
}

function rgba2hex(rgba) {
  const hex = rgba.map((x) => x.toString(16).padStart(2, 0));
  return `#${hex.join("")}`;
}

module.exports = {
  Parameter,
};
