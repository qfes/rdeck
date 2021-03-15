module.exports = {
  root: true,
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: "./tsconfig.json",
  },
  ignorePatterns: [".eslintrc.js"],
  extends: [
    "react-app",
    "plugin:jsx-a11y/recommended",
    "plugin:compat/recommended",
    "plugin:prettier/recommended",
  ],
  plugins: ["@typescript-eslint"],
  settings: {
    polyfills: ["Object.fromEntries"],
  },
  rules: {
    "prettier/prettier": "warn"
  }
};
