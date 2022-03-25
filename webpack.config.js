const { resolve } = require("path");
const { DefinePlugin, SourceMapDevToolPlugin } = require("webpack");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const { version } = require("./package.json");

const DependenciesPlugin = require("./scripts/dependencies-webpack-plugin");

module.exports = (env, { mode }) => {
  process.env.NODE_ENV = mode;

  return {
    mode,
    entry: { rdeck: "./widget/index.ts" },
    output: {
      library: {
        name: "rdeck",
        type: "umd",
      },
      path: resolve(__dirname, "inst/htmlwidgets"),
      filename: "[name].js",
      clean: { keep: "rdeck.yaml" },
    },
    resolve: {
      extensions: [".ts", ".tsx", ".js"],
      mainFields: ["browser", "module", "main"],
    },
    module: {
      rules: [
        {
          test: /\.tsx?$/,
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
        {
          test: /\.woff2?$/,
          type: "asset/resource",
          generator: {
            filename: "fonts/[name][ext]",
          },
        },
      ],
    },
    plugins: [
      new DefinePlugin({ __VERSION__: JSON.stringify(version) }),
      new MiniCssExtractPlugin({ filename: "[name].css" }),
      new DependenciesPlugin({ filename: "rdeck.yaml", version, exclude: "rdeck.js" }),
      new SourceMapDevToolPlugin({
        include: mode === "production" ? "rdeck" : null
      }),
    ],
    optimization: {
      minimize: mode === "production",
      minimizer: [new TerserPlugin(), new CssMinimizerPlugin()],
      splitChunks: {
        chunks: "all",
        maxInitialRequests: Infinity,
        minSize: 0,
        cacheGroups: {
          vendors: {
            test: /[\\/]node_modules[\\/]/,
            name(module) {
              const packageName = module.context.match(/[\\/]node_modules[\\/]([^\\/]+)/)[1];
              return `vendor/${packageName.replace("@", "")}`;
            },
          },
        },
      },
    },
  };
};
