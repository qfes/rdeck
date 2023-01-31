module.exports = {
  plugins: [
    require("postcss-import"),
    require("postcss-mixins"),
    require("postcss-preset-env")({
      features: {
        "nesting-rules": true,
      },
    }),
  ],
};
