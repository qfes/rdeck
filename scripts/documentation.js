const { Deck, Layer, CompositeLayer } = require("@deck.gl/core");

const marked = require("marked");
const { default: fetch } = require("node-fetch");
const { snakeCase } = require("snake-case");
const { paramCase: kebabCase } = require("param-case");

// @ts-ignore
const DOCS_URL = `uber/deck.gl/blob/v${Deck.VERSION}/docs`;

async function getDocumentation(layer) {
  const url =
    "https://raw.githubusercontent.com/uber/deck.gl/v8.0.17/docs/layers/text-layer.md";
  fetch(url)
    .then(response => response.text())
    .then(marked.lexer);
}

