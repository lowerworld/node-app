import type { OxlintConfig } from "oxlint";

export default {
  options: { typeAware: true, typeCheck: true },
  plugins: ["eslint", "typescript", "unicorn", "oxc", "node"],
  rules: {
    "eslint/eqeqeq": "warn",
    "eslint/object-shorthand": "warn",
    "typescript/consistent-type-imports": "warn",
    "typescript/no-unnecessary-condition": "warn",
    "unicorn/prefer-node-protocol": "warn",
  },
} satisfies OxlintConfig;
