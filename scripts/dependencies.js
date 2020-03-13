const fs = require("fs");
const { dedent } = require("ts-dedent");

// @ts-ignore
const packageInfo = require("../package.json");

function generateDependency(name, version, script, stylesheet = null) {
  return dedent(`
    htmltools::htmlDependency(
      name = "${name}",
      version = "${version}",
      src = c(href = "https://unpkg.com/${name}@${version}"),
      script = "${script}",
      stylesheet = ${stylesheet != null ? `"${stylesheet}"` : "NULL"}
    )
  `);
}

function getVersion(version) {
  return /\d+\.\d+\.\d+/.exec(version)[0];
}

function generateDependencies() {
  const deckgl = packageInfo.dependencies["@deck.gl/core"];
  const mapboxgl = packageInfo.dependencies["mapbox-gl"];
  const h3js = packageInfo.dependencies["h3-js"];
  const s2Geometry = packageInfo.dependencies["s2-geometry"];

  const dependencies = [
    generateDependency(
      "mapbox-gl",
      getVersion(mapboxgl),
      "dist/mapbox-gl.js",
      "dist/mapbox-gl.css"
    ),
    generateDependency("h3-js", getVersion(h3js), "dist/h3-js.umd.js"),
    generateDependency("s2-geometry", getVersion(s2Geometry), "src/s2geometry.js"),
    generateDependency("deck.gl", getVersion(deckgl), "dist.min.js")
  ];

  const content = dedent(`
    dependencies <- list(
      ${dependencies.join(",\n")}
    )
  `);

  fs.writeFileSync("./R/deckgl_dependencies.R", content);
}

module.exports = {
  generateDependencies
};
