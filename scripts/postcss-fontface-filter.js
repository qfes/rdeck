const valueParser = require("postcss-value-parser");

module.exports = ({ format = "woff2" } = {}) => {
  const plugin = "postcss-fontface-filter";

  // filter src values by format
  function filterSrc(decl) {
    const values = decl.value.split(",").filter((value) => {
      const parsed = valueParser(value);
      return parsed.nodes.some(
        (node) =>
          node.type === "function" &&
          ((node.value === "format" && node.nodes[0]?.value === format) ||
            (node.value === "url" && node.nodes[0]?.value.endsWith("." + format)))
      );
    });

    if (values.length === 0) {
      throw decl.error("Format no match", { plugin });
    }

    decl.value = values.join(",");
  }

  return {
    postcssPlugin: plugin,
    AtRule: {
      "font-face": (atRule) => {
        atRule.walkDecls("src", filterSrc);
      },
    },
  };
};

module.exports.postcss = true;
