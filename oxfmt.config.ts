import type { OxfmtConfig } from "oxfmt";

export default {
  printWidth: 80,
  sortImports: {
    newlinesBetween: false,
    sortSideEffects: true,
  },
} satisfies OxfmtConfig;
