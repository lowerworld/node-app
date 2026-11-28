# syntax=docker/dockerfile:1-labs

# ──────────────────────────────────────────────────────────────────────────────
FROM ghcr.io/pnpm/pnpm:12 AS builder
# ──────────────────────────────────────────────────────────────────────────────

RUN pnpm runtime set node 26 -g

WORKDIR /app

# ──────────────────────────────────────────────────────────────────────────────
FROM builder AS src
# ──────────────────────────────────────────────────────────────────────────────

COPY . .

# ──────────────────────────────────────────────────────────────────────────────
FROM src AS node_modules
# ──────────────────────────────────────────────────────────────────────────────

RUN --mount=type=cache,id=pnpm,target=/var/cache/pnpm \
  pnpm install --store-dir=/var/cache/pnpm --prod --frozen-lockfile

# ──────────────────────────────────────────────────────────────────────────────
FROM src AS app
# ──────────────────────────────────────────────────────────────────────────────

RUN --mount=type=cache,id=pnpm,target=/var/cache/pnpm \
  pnpm install --store-dir=/var/cache/pnpm --frozen-lockfile

RUN pnpm run build

# ──────────────────────────────────────────────────────────────────────────────
FROM gcr.io/distroless/nodejs26-debian13:nonroot
# ──────────────────────────────────────────────────────────────────────────────

ENV NODE_ENV="production"
ENV TZ="Asia/Tokyo"

WORKDIR /app

COPY --chown=nonroot:nonroot --parents --from=node_modules /app/./node_modules/ ./
COPY --chown=nonroot:nonroot --parents --from=app /app/./dist/ ./

CMD ["--enable-source-maps", "dist/index.mjs"]
