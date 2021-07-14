const { writeFile } = require("fs/promises");
const yaml = require("js-yaml");
const path = require("path");

class DependenciesPlugin {
  constructor({ filename, version, exclude }) {
    this.filename = filename;
    // strip illegal chars
    this.version = version.match(/\d+(?:\.\d+){0,2}/)[0];
    this.exclude = exclude;
  }
  apply(compiler) {
    compiler.hooks.afterEmit.tapPromise("dependencies-plugin", async (compilation) => {
      // path to built assets
      const { path: outputPath } = compilation.outputOptions;
      const assets = [...Object.keys(compilation.assets)].filter((x) => x !== this.exclude);
      // everything after inst
      const src = outputPath.split(/inst[\\/]/)[1];

      const deps = yaml.dump({
        dependencies: [
          {
            name: this.filename.split(".")[0],
            version: this.version,
            src,
            stylesheet: assets.filter((x) => x.endsWith("css")),
            script: assets.filter((x) => x.endsWith("js")),
          },
        ],
      });

      return writeFile(path.join(outputPath, this.filename), deps);
    });
  }
}

module.exports = DependenciesPlugin;
