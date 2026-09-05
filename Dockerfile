# Build the Node/Express todo app that lives in ./src (frontend + /items API).
#
#   npm ci --omit=dev in a builder stage (with the toolchain sqlite3's
#   native addon needs), then copy just node_modules + src into a slim
#   runtime image. The app listens on :3000 and is routed by Traefik.

FROM node:20-slim AS build
WORKDIR /app
RUN apt-get update \
 && apt-get install -y --no-install-recommends python3 make g++ \
 && rm -rf /var/lib/apt/lists/*
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

FROM node:20-slim
WORKDIR /app
ENV NODE_ENV=production \
    SQLITE_DB_LOCATION=/data/todo.db
COPY --from=build /app/node_modules ./node_modules
COPY package.json ./
COPY src ./src
RUN mkdir -p /data && chown -R node:node /data /app
USER node
EXPOSE 3000
CMD ["node", "src/index.js"]
