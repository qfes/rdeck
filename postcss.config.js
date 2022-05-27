module.exports = {
  plugins: [
    require("./scripts/postcss-fontface-filter"),
    require("postcss-import"),
    require("postcss-url"),
    require("postcss-mixins"),
    require("postcss-pseudo-is"),
    require("postcss-preset-env")({
      features: {
        "nesting-rules": true,
      },
    }),
  ],
};
