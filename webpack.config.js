const { resolve } = require("path");
const webpack = require("webpack");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = (env, { mode }) => {
  process.env.NODE_ENV = mode;
  const isDevelopment = mode === "development";

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
      extensions: [".ts", ".tsx", ".js", "jsx", ".json"],
      mainFields: ["esnext", "browser", "module", "main"],
    },
    module: {
      rules: [
        {
          test: /\.(ts|js)x?$/,
          exclude: /node_modules/,
          loader: "babel-loader",
        },
        {
          test: /\.css$/,
          use: [
            MiniCssExtractPlugin.loader,
            {
              loader: "css-loader",
              options: {
                importLoaders: 1,
                modules: true,
                localsConvention: "camelCase",
              },
            },
            "postcss-loader",
          ],
        },
      ],
    },
    // externals,
    plugins: [
      new MiniCssExtractPlugin({
        filename: "[name].css",
      }),
    ],
    devtool: isDevelopment && "inline-source-map",
    optimization: {
      splitChunks: {
        chunks: "initial",
        cacheGroups: {
          defaultVendors: {
            name: "vendor",
            test: /node_modules/,
            enforce: true,
          },
        },
      },
    },
  };
};
