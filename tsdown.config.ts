import { defineConfig } from "tsdown";

export default defineConfig({
  target: "node24",
  minify: true,
  sourcemap: true,
});
