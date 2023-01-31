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
                  mode(resourcePath) {
                    return /[\\/]node_modules[\\/]/.test(resourcePath) ? "global" : "local";
                  },
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
        {
          test: /\.svg$/,
          issuer: /\.(js|ts)x?$/,
          use: [{ loader: "@svgr/webpack", options: { icon: true } }],
        },
      ],
    },
    plugins: [
      new DefinePlugin({ __VERSION__: JSON.stringify(version) }),
      new MiniCssExtractPlugin({ filename: "[name].css" }),
      new DependenciesPlugin({ filename: "rdeck.yaml", version, exclude: "rdeck.js" }),
      new SourceMapDevToolPlugin({
        include: mode === "production" ? "rdeck" : undefined,
      }),
    ],
    devtool: false,
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
              const resource = module.nameForCondition();
              let match;
              for (match of resource.matchAll(/[\\/]node_modules[\\/]([^\\/]+)/g));
              const packageName = match[1];
              return `vendor/${packageName.replace("@", "")}`;
            },
          },
        },
      },
    },
  };
};
