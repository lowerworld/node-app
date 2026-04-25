import type { OxlintConfig } from "oxlint";

export default {
  options: { typeAware: true, typeCheck: true },
  plugins: ["eslint", "typescript", "unicorn", "oxc", "import", "node"],
  rules: {
    "eslint/eqeqeq": "warn",
    "eslint/object-shorthand": "warn",
    "eslint/sort-imports": ["warn", { ignoreDeclarationSort: true }],
    "typescript/consistent-type-imports": "warn",
    "typescript/no-unnecessary-condition": "warn",
    "unicorn/prefer-node-protocol": "warn",
    "import/consistent-type-specifier-style": "warn",
  },
} satisfies OxlintConfig;
