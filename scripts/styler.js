const util = require("util");
const exec = util.promisify(require("child_process").exec);

function styleFile(path) {
  const unixPath = path.replace(/\\/g, "/");
  return exec(`Rscript -e "styler::style_file('${unixPath}')"`);
}

module.exports = { styleFile };
