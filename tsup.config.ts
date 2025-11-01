import { defineConfig } from "tsup";

export default defineConfig({
  entry: ["src/index.ts"],
  target: "node22",
  minify: true,
  format: "esm",
  sourcemap: true,
  clean: true,
});
