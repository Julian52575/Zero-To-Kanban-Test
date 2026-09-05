# Dev-mode image for the Vite/React frontend that lives in ./frontend.
# Runs the Vite dev server with HMR; not a production build.

FROM node:24-slim
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
EXPOSE 5173
CMD ["npx", "vite", "--host", "0.0.0.0"]
