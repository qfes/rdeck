const { resolve } = require("path");
const webpack = require("webpack");

const config = {
  mode: "production",
  entry: "./js",
  output: {
    path: resolve(__dirname, "inst/htmlwidgets"),
    filename: "rdeck.js",
    library: "rdeck",
    libraryTarget: "umd"
  },
  resolve: {
    extensions: [".ts", ".tsx", ".js", ".json"]
  },
  module: {
    rules: [
      {
        test: /\.(ts|js)x?$/,
        loader: "babel-loader"
      }
    ]
  },
  externals: {
    "deck.gl": "deck",
    "@deck.gl/core": "deck",
    "@deck.gl/layers": "deck",
    "@deck.gl/aggregation-layers": "deck",
    "@deck.gl/extensions": "deck",
    "@deck.gl/geo-layers": "deck",
    "@deck.gl/google-maps": "deck",
    "@deck.gl/mesh-layers": "deck",
    "@deck.gl/mapbox": "deck",
    "mapbox-gl": "mapboxgl",
    "h3-js": "h3",
    "s2-geometry": "s2"
  },
  plugins: [],
  devtool: "source-map"
};

module.exports = (env = {}) => {
  if (env.dev) {
    Object.assign(config, {
      mode: "development",
      devtool: "inline-source-map"
    });
  }

  return config;
};
