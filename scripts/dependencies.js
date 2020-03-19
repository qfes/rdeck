const fs = require("fs");
const { dedent } = require("ts-dedent");

function getPackage(name) {
  const packageInfo = require(`../node_modules/${name}/package.json`);

  return {
    name: packageInfo.name,
    version: packageInfo.version,
    main: packageInfo.unpkg || packageInfo.main,
    style: packageInfo.style
  };
}

function generateDependencies() {
  const packages = [
    getPackage("mapbox-gl"),
    getPackage("h3-js"),
    getPackage("s2-geometry"),
    { ...getPackage("deck.gl"), main: "dist.min.js" },
    getPackage("d3-array"),
    getPackage("d3-interpolate"),
    getPackage("d3-color"),
    getPackage("d3-scale")
  ];

  const dependencies = packages.map(({ name, version, main, style }) =>
    dedent(`
      htmltools::htmlDependency(
        name = "${name}",
        version = "${version}",
        src = c(href = "https://unpkg.com/${name}@${version}"),
        script = "${main}",
        stylesheet = ${style ? `"${style}"` : "NULL"}
      )
    `)
  );

  const content = dedent(`
    dependencies <- list(
      ${dependencies.join(",\n")}
    )
  `);

  fs.writeFileSync("./R/dependencies.R", content);
}

module.exports = {
  generateDependencies
};

generateDependencies();
