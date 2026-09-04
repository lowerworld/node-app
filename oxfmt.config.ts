import type { OxfmtConfig } from "oxfmt";

export default {
  printWidth: 80,
  sortImports: {
    newlinesBetween: false,
    sortSideEffects: true,
  },
  overrides: [
    {
      files: ["pnpm-workspace.yaml"],
      options: { singleQuote: true },
    },
  ],
} satisfies OxfmtConfig;
