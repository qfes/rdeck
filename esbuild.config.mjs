import esbuild from "esbuild";
import svgrPlugin from "esbuild-plugin-svgr";
import stylePlugin from "esbuild-style-plugin";
import postcssConfig from "./postcss.config.js";

import { readFile } from "node:fs/promises";
const packageJson = JSON.parse(await readFile("./package.json"));
const isDev = process.argv.some((x) => x === "--dev") ?? false;

/** @type {import("esbuild").BuildOptions} */
const buildConfig = {
  entryPoints: ["widget/index.ts"],
  bundle: true,
  outfile: "inst/htmlwidgets/rdeck.bundle.js",
  globalName: "rdeck",
  mainFields: ["browser", "module", "main"],
  legalComments: "external",
  sourcemap: "inline",
  minify: !isDev,
  logLevel: "info",
  define: {
    __VERSION__: JSON.stringify(packageJson.version),
  },
  plugins: [
    !isDev ? sourcemapPlugin() : noopPlugin(),
    svgrPlugin({ typescript: true }),
    stylePlugin({
      cssModulesOptions: {
        exportGlobals: true,
        localsConvention: "camelCase",
      },
      postcss: postcssConfig,
    }),
  ],
};

if (isDev) {
  const ctx = await esbuild.context(buildConfig);
  await ctx.watch();
} else {
  await esbuild.build(buildConfig);
}


// plugins
function noopPlugin() {
  /** @type {import("esbuild").Plugin} */
  return {
    name: "noop",
    setup() {}
  }
}

// https://github.com/evanw/esbuild/issues/1227#issuecomment-829778830
function sourcemapPlugin() {
  const dataurl =
    "sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIiJdLCJtYXBwaW5ncyI6IkEifQ==";

  const omitJs = (contents) => contents + `\n//# ${dataurl}`;
  const omitCss = (contents) => contents + `\n/*# ${dataurl} */`;

  /** @type {import("esbuild").Plugin} */
  return {
    name: "no-vendors-sourcemap",
    async setup(build) {

      build.onLoad({ filter: /node_modules.*\.(js|ts)$/ }, async (args) => {
        const contents = await readFile(args.path, "utf-8");
        return {
          contents: omitJs(contents),
          loader: "default",
        };
      });

      build.onLoad({ filter: /node_modules.*\.css$/ }, async (args) => {
        const contents = await readFile(args.path, "utf-8");
        return {
          contents: omitCss(contents),
          loader: "default",
        };
      });
    },
  };
}
