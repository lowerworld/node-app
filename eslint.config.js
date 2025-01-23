import eslint from "@eslint/js";
import prettier from "eslint-config-prettier";
import globals from "globals";
import tseslint from "typescript-eslint";

export default tseslint.config(
  {
    extends: [eslint.configs.recommended],
    rules: {
      eqeqeq: "warn",
      "no-warning-comments": "warn",
      "object-shorthand": "warn",
    },
  },
  {
    files: ["**/*.{ts,tsx}"],
    extends: [
      tseslint.configs.strictTypeChecked,
      tseslint.configs.stylisticTypeChecked,
    ],
    rules: {
      "@typescript-eslint/consistent-type-definitions": "off",
    },
    languageOptions: {
      globals: globals.node,
      parserOptions: {
        project: ["tsconfig.json"],
        tsconfigRootDir: import.meta.dirname,
      },
    },
  },
  { extends: [prettier] },
);
