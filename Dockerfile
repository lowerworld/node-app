FROM node:22-slim AS builder
ENV PNPM_HOME="/pnpm"
ENV PATH="${PNPM_HOME}:${PATH}"
RUN corepack enable
COPY . /app
WORKDIR /app

FROM builder AS node_modules
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

FROM builder AS app
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run build

FROM node:22-slim
RUN corepack enable

COPY --from=node_modules /app/node_modules/ /app/node_modules/
COPY --from=app /app/dist/ /app/dist/
COPY --from=app /app/package.json /app/package.json
WORKDIR /app

USER node
RUN pnpm doctor

CMD ["pnpm", "run", "start"]
