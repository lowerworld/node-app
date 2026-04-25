# ──────────────────────────────────────────────────────────────────────────────
FROM node:24-trixie-slim AS base
# ──────────────────────────────────────────────────────────────────────────────

WORKDIR /app

# ──────────────────────────────────────────────────────────────────────────────
FROM base AS builder
# ──────────────────────────────────────────────────────────────────────────────

ENV PNPM_HOME="/pnpm"
ENV PATH="${PNPM_HOME}:${PATH}"
RUN corepack enable

# ──────────────────────────────────────────────────────────────────────────────
FROM builder AS src
# ──────────────────────────────────────────────────────────────────────────────

COPY . .

# ──────────────────────────────────────────────────────────────────────────────
FROM src AS node_modules
# ──────────────────────────────────────────────────────────────────────────────

RUN --mount=type=cache,sharing=locked,target=/pnpm/store \
  pnpm install --prod --frozen-lockfile

# ──────────────────────────────────────────────────────────────────────────────
FROM src AS app
# ──────────────────────────────────────────────────────────────────────────────

RUN --mount=type=cache,sharing=locked,target=/pnpm/store \
  pnpm install --frozen-lockfile

RUN pnpm run build

# ──────────────────────────────────────────────────────────────────────────────
FROM base
# ──────────────────────────────────────────────────────────────────────────────

ENV NODE_ENV="production"

COPY --chown=node:node --parents --from=node_modules /app/./node_modules/ ./
COPY --chown=node:node --parents --from=app /app/./dist/ ./

USER node

CMD ["node", "--enable-source-maps", "dist/index.mjs"]
