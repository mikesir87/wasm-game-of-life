<div align="center">

  <h1>Game of Life</h1>
  <strong><a href="https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life">Conway's Game of Life</a> implementation using Rust, Javascript and WebAssembly!</strong>

</div>

## About

Try it out at <https://wasm-game-of-life.shalzz.now.sh>!

## Run with Docker

If you have Docker installed, you can run the application by using Docker Compose.

```
docker compose up -d
```

After it starts, the application will be available at [http://localhost:8090](http://localhost:8090). Note that it may take a moment for the first launch as the initial Rust compile may take some time. You can view the logs at `docker compose logs -f` to see the status.


## Run with Rust toolchain

Build the webassembly module with `wasm-pack build`

```
wasm-pack build
```

start the webserver with `npm run start`

```
cd www
npm run start
```

Open the webpage at http://localhost:808

## Build with Docker

You can build a container image using the provided Dockerfile.

```
docker build -t game-of-life .
```

The final image is based on nginx, so runs on port 80. The following command will start a new container using the built image:

```
docker run --rm -tip 8080:80 game-of-life
```


## Build with Rust toolchain

### 🛠️ Build with `wasm-pack build`

```
wasm-pack build
```

### 🔬 Test in Headless Browsers with `wasm-pack test`

```
wasm-pack test --headless --firefox
```

### 🎁 Deploy

1. Build the wasm module
```
wasm-pack build
```

2. Bundle with our js and html
```
cd www
npm run build
```

3. Deploy to @zeit/now
```
cd www/dist
now
```
