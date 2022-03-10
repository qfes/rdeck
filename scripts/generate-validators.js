/**
 * Generates the deck.gl layer prop validators
 * All validator functions are written to ./R/deckgl-validators.R
 */

const fs = require("fs/promises");
const path = require("path");
const ejs = require("ejs");
const deck = require("deck.gl");
const { snakeCase } = require("snake-case");
const { getProps } = require("./props");
const { styleFile } = require("./styler");

function unique(props) {
  const map = props.reduce((set, prop) => {
    set[prop.name] = {
      ...set[prop.name],
      ...prop,
    };
    return set;
  }, {});

  return Object.values(map).sort((a, b) => (a.name <= b.name ? -1 : 1));
}

function templateData(propType) {
  return {
    ...propType,
    name: snakeCase(propType.name),
  };
}

const notNull = (x) => x != null;
const notEmpty = (x) => Array.isArray(x) && x.length !== 0;

// property-wise concat
function concatObjects(...objects) {
  const keys = [...new Set(objects.flatMap(Object.keys))];
  return Object.fromEntries(keys.map((key) => [key, objects.map((x) => x[key])]));
}

// simple assertion condition helpers
const flagCondition = (name, flag) => `${flag}(${name})`;
const lengthCondition = (name, length) => `length(${name}) == ${length}`;
// format a typed assertion message
const objectMessage = (type) => `a {.cls ${type}}`;
const vectorMessage = (type, isScalar) =>
  `a ${isScalar ? "scalar" : ""} {.cls ${type}} ${!isScalar ? "vector" : ""}`
    .replace("  ", " ")
    .trim();

// assertion parts for accessors
function accessorCheck({ name, type }) {
  const conditions = [];
  const messages = [];

  if (type === "accessor") {
    conditions.push(flagCondition(name, "is_accessor"));
    messages.push(objectMessage("column accessor"));
  }

  return { conditions, messages };
}

// assertion parts for scales
function scaleCheck({ name, type, valueType, isScalable }) {
  const conditions = [];
  const messages = [];

  if (type === "accessor" && isScalable) {
    const scaleType = valueType === "color" ? "color" : "numeric";
    conditions.push(flagCondition(name, `is_${scaleType}_scale`));
    messages.push(objectMessage(`${scaleType} scale`));
  }

  return { conditions, messages };
}

// assertion parts for bools
function booleanCheck({ name, valueType, isScalar }) {
  const conditions = [];
  const messages = [];

  if (valueType === "boolean") {
    conditions.push(flagCondition(name, "is.logical"));
    if (isScalar) conditions.push(lengthCondition(name, 1));
    messages.push(vectorMessage("logical", isScalar));
  }

  return { conditions, messages };
}

// assertion parts for strings
function stringCheck({ name, valueType, isScalar, values }) {
  const conditions = [];
  const messages = [];

  if (valueType === "string") {
    conditions.push(flagCondition(name, "is.character"));
    if (isScalar) conditions.push(lengthCondition(name, 1));

    let valuesMessage = null;

    if (values != null) {
      let valuesStr = values.map((x) =>
        typeof x === "boolean" ? JSON.stringify(x).toUpperCase() : JSON.stringify(x)
      );
      valuesStr = "c(" + valuesStr.join(", ") + ")";
      conditions.push(`${name} %in% ${valuesStr}`);
      valuesMessage = `{.arg values} in ${valuesStr}`;
    }

    messages.push(
      [vectorMessage("character", isScalar), valuesMessage].filter(notNull).join(" where ")
    );
  }

  return { conditions, messages };
}

// assertion parts for colors
function colorCheck({ name, valueType, isScalar }) {
  const conditions = [];
  const messages = [];

  if (valueType === "color") {
    conditions.push(flagCondition(name, "is_rgba_color"));
    if (isScalar) conditions.push(lengthCondition(name, 1));
    messages.push(vectorMessage("rgba color", isScalar));
  }

  return { conditions, messages };
}

// assertion parts for numbers
function numberCheck({ name, valueType, min, max, isScalar }) {
  const conditions = [];
  const messages = [];

  if (valueType === "number") {
    conditions.push(flagCondition(name, "is.numeric"), flagCondition(name, "is.finite"));
    if (isScalar) conditions.push(lengthCondition(name, 1));

    // min & max conditions
    const minCondition = `min(${name}) >= ${min}`;
    const maxCondition = `max(${name}) <= ${max}`;
    let rangeMessage = null;

    if (min != null && max != null) {
      conditions.push(minCondition, maxCondition);
      rangeMessage = `${min} <= {.arg values} <= ${max}`;
    } else if (min != null) {
      conditions.push(minCondition);
      rangeMessage = `{.arg values} >= ${min}`;
    } else if (max != null) {
      conditions.push(maxCondition);
      rangeMessage = `{.arg values} <= ${max}`;
    }

    messages.push(
      [vectorMessage("numeric", isScalar), rangeMessage].filter(notNull).join(" where ")
    );
  }

  return { conditions, messages };
}

// assertion parts for number arrays
function arrayCheck({ name, valueType, value, length }, isList = false) {
  const conditions = [];
  const messages = [];

  if (valueType === "array" && typeof value[0] === "number") {
    // used when checking an accessor column type
    if (isList) {
      conditions.push(
        flagCondition(name, "is.list"),
        `all(vapply_l(${name}, function(x) is.numeric(x) && all(is.finite(x))))`
      );

      messages.push(objectMessage("list_of<numeric>"));
    } else {
      conditions.push(flagCondition(name, "is.numeric"), flagCondition(name, "is.finite"));

      // length condition
      if (Array.isArray(length)) {
        conditions.push(
          [`length(${name})`, "%in%", "c(" + length.map((x) => JSON.stringify(x)) + ")"].join(" ")
        );
      } else if (length != null) {
        conditions.push([`length(${name})`, "==", JSON.stringify(length)].join(" "));
      }

      messages.push(
        length == null
          ? vectorMessage("numeric", false)
          : vectorMessage(`length-${JSON.stringify(length)} numeric`, false)
      );
    }
  }

  return { conditions, messages };
}

// proptype assertion
function typeCheck(propType) {
  const { conditions, messages } = concatObjects(
    scaleCheck(propType),
    accessorCheck(propType),
    booleanCheck(propType),
    stringCheck(propType),
    colorCheck(propType),
    numberCheck(propType),
    arrayCheck(propType)
  );

  return {
    conditions: conditions.filter(notEmpty),
    messages: messages.filter(notEmpty).flat(),
  };
}

// accessor column assertion
function columnCheck(propType, columnExpr) {
  const columnType = {
    ...propType,
    name: columnExpr,
    isScalar: false,
  };

  const { conditions, messages } = concatObjects(
    booleanCheck(columnType),
    stringCheck(columnType),
    colorCheck(columnType),
    numberCheck(columnType),
    arrayCheck(columnType, true)
  );

  return {
    conditions: conditions.filter(notEmpty),
    messages: messages.filter(notEmpty).flat(),
  };
}

// make an assertion call
function formatAssertion(conditions, messages, ...dots) {
  if (conditions.length === 0) return null;

  const bullet = (idx) => JSON.stringify(idx === 0 ? "x" : "*");

  const expression = conditions
    .map((x) => (Array.isArray(x) ? x.join(" && ") : x))
    .join(" || ")
    .trim();

  let message = messages
    .map(JSON.stringify)
    .map((msg, idx) => `${bullet(idx)} = ${msg}`)
    .join(", ");

  message = "c(" + message + ")";

  const args = [expression, message, ...dots];
  return `tidyassert::assert(
    ${args.join(",\n")}
  )`;
}

const props = Object.values(deck)
  .filter((x) => x.prototype instanceof deck.Layer && x !== deck.CompositeLayer)
  // @ts-ignore
  .flatMap(getProps)
  .map(templateData);

const uniqueProps = unique(props);

const template = path.join(__dirname, "validate.ejs");
const output = path.join(__dirname, "../R/deckgl-validators.R");
// @ts-ignore
const deckVersion = deck.Deck.VERSION;
const generatedBy = `
  # Generated by rdeck: do not edit by hand
  # deck.gl version: ${deckVersion}
`.trim();

Promise.all(
  uniqueProps.map((propType) =>
    ejs.renderFile(
      template,
      { propType, utils: { typeCheck, columnCheck, formatAssertion } },
      { rmWhitespace: true }
    )
  )
)
  .then((validators) => {
    const content = [generatedBy, ...validators].join("\n\n");
    return fs.writeFile(output, content);
  })
  .then(() => styleFile(output));
