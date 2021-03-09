const { resolve } = require("path");
const { DefinePlugin } = require("webpack");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const { version } = require("./package.json");

module.exports = (env, { mode }) => {
  process.env.NODE_ENV = mode;

  return {
    mode,
    entry: { rdeck: "./widget" },
    output: {
      path: resolve(__dirname, "inst/htmlwidgets"),
      filename: "[name].js",
      library: "rdeck",
      libraryTarget: "umd",
    },
    resolve: {
      extensions: [".ts", ".tsx", ".js", "jsx"],
      mainFields: ["esnext", "browser", "module", "main"],
    },
    module: {
      rules: [
        {
          test: /\.(ts|js)x?$/,
          exclude: /node_modules/,
          loader: "ts-loader",
        },
        {
          test: /\.css$/,
          use: [
            MiniCssExtractPlugin.loader,
            {
              loader: "css-loader",
              options: {
                importLoaders: 1,
                modules: {
                  exportGlobals: true,
                  exportLocalsConvention: "camelCase",
                },
              },
            },
            "postcss-loader",
          ],
        },
      ],
    },
    plugins: [
      new DefinePlugin({ __VERSION__: JSON.stringify(version) }),
      new MiniCssExtractPlugin({ filename: "[name].css" }),
    ],
    devtool: mode === "development" && "inline-source-map",
    optimization: {
      minimize: mode === "production",
      minimizer: [new TerserPlugin({ extractComments: false }), new CssMinimizerPlugin()],
      splitChunks: {
        chunks: "all",
        cacheGroups: {
          react: {
            name: "react",
            test: /[\\/]node_modules[\\/](react|react-dom|react-is|prop-types|scheduler)[\\/]/,
          },
          mapboxgl: {
            name: "mapbox-gl",
            test: /[\\/]node_modules[\\/](@mapbox|mapbox-gl)[\\/]/,
          },
          deckgl: {
            name: "deck.gl",
            test: /[\\/]node_modules[\\/]@?(deck|loaders|luma|math)\.gl[\\/]/,
          },
          h3js: {
            name: "h3-js",
            test: /[\\/]node_modules[\\/]h3-js[\\/]/,
          },
          defaultVendors: {
            name: "rdeck-vendors",
            test: /[\\/]node_modules[\\/]/,
            reuseExistingChunk: true,
            enforce: true,
            priority: -10,
          },
        },
      },
    },
  };
};
