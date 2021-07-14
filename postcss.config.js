module.exports = {
  plugins: [
    require("./scripts/postcss-fontface-filter"),
    require("postcss-import"),
    require("postcss-url"),
    require("postcss-mixins"),
    require("postcss-preset-env"),
  ],
};
