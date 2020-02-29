function snakeCase(str) {
  return str.replace(/(?<=[a-z])(?=[A-Z])/g, x => "_" + x).toLowerCase();
}

function kebabCase(str) {
  return str.replace(/(?<=[a-z])(?=[A-Z])/g, x => "-" + x).toLowerCase();
}

module.exports = {
  snakeCase,
  kebabCase
};
