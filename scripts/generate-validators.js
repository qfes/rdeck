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
    min: propType.min ?? null,
    max: propType.max ?? null,
  };
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

Promise.all(uniqueProps.map((prop) => ejs.renderFile(template, prop, { rmWhitespace: true })))
  .then((validators) => {
    const content = [generatedBy, ...validators].join("\n\n");
    return fs.writeFile(output, content);
  })
  .then(() => styleFile(output));
