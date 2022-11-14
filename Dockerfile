################### WASM TOOLCHAIN ###################
FROM rust AS wasm-build-base
WORKDIR /usr/local/app
RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | bash

FROM wasm-build-base AS wasm-dev
RUN cargo install cargo-watch
CMD ["cargo", "watch", "-i", ".gitignore", "-i", "pkg/*", "-s", "wasm-pack build"]

FROM wasm-build-base AS wasm-build
COPY Cargo.toml ./
COPY src ./src
RUN wasm-pack build


################### WEB FRONTEND ###################

FROM node:16-alpine AS web-frontend-base
WORKDIR /usr/local/app

FROM web-frontend-base AS web-dev
WORKDIR /usr/local/app/www
CMD ["npm", "run", "dev"]

FROM web-frontend-base AS web-prod
COPY --from=wasm-build /usr/local/app/pkg /usr/local/app/pkg
COPY www /usr/local/app/www
RUN cd www && npm install && npm run build

FROM nginx:alpine
COPY --from=web-prod /usr/local/app/www/dist /usr/share/nginx/html