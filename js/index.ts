declare const __VERSION__: string;

module.exports = {
  VERSION: __VERSION__,
  binding: require("./widget").default
};
