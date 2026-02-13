FROM node:22-trixie-slim AS base

WORKDIR /app

################################################################################
FROM base AS builder

ENV PNPM_HOME="/pnpm"
ENV PATH="${PNPM_HOME}:${PATH}"
RUN corepack enable

################################################################################
FROM builder AS src

COPY . .

################################################################################
FROM src AS node_modules

RUN --mount=type=cache,sharing=locked,target=/pnpm/store \
    pnpm install --prod --frozen-lockfile

################################################################################
FROM src AS app

RUN --mount=type=cache,sharing=locked,target=/pnpm/store \
    pnpm install --frozen-lockfile

RUN pnpm run build

################################################################################
FROM base

COPY --from=node_modules --chown=node:node /app/node_modules node_modules
COPY --from=app --chown=node:node /app/dist dist

ENV NODE_ENV="production"
USER node
CMD ["node", "--enable-source-maps", "dist/index.mjs"]
