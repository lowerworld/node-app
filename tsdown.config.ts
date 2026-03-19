import { defineConfig } from "tsdown";

export default defineConfig({
  target: "node22",
  minify: true,
  sourcemap: true,
});
