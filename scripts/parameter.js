const { snakeCase } = require("snake-case");
const NULL = "NULL";

class Parameter {
  name;
  type;
  default = NULL;

  constructor({ name, type, value: defaultValue }) {
    this.name = snakeCase(name);
    this.type = type;
    this.default = getDefaultValue({ name, type, defaultValue });
  }
}

function getDefaultValue({ name, type, defaultValue }) {
  if (name === "data") {
    return "data.frame()";
  }

  if (name === "characterSet") {
    return "default_character_set()";
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

function rgba2hex(rgba) {
  const hex = rgba.map((x) => x.toString(16).padStart(2, 0));
  return `#${hex.join("")}`;
}

function isAccessor(propType) {
  return propType.type === "accessor";
}

function isScalable(propType) {
  return (
    isAccessor(propType) &&
    /(radius|elevation|color|weight|width|height|size)$/i.test(propType.name)
  );
}

function isGeometry(propType) {
  return isAccessor(propType) && /path|polygon|position/i.test(propType.name);
}

function isGeo(propType) {
  return isAccessor(propType) && /s2|hexagon/i.test(propType.name);
}

module.exports = {
  Parameter,
  isAccessor,
  isScalable,
  isGeometry,
  isGeo,
};
