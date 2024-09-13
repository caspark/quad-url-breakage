
# Repeatedly build the web build and serve it on localhost:8000 (localhost so that it's a secure context for gamepads to work)
web: web-dependencies
    watchexec --restart "just web-build && (cd dist/breakage-web && python -m http.server --bind localhost)"

# Build everything the web build needs _except_ the actual wasm itself
web-dependencies: rebuild-js
    mkdir -p dist/breakage-web/
    cp -ar build/web/* dist/breakage-web/

# Rebuild the JS dependency based on checked out macroquad dependencies
rebuild-js:
    # [ -f build/web/mq_js_bundle.js ] && rm build/web/mq_js_bundle.js

    # cat "$HOME/srb/miniquad/js/gl.js" >> build/web/mq_js_bundle.js
    # cat "$HOME/srb/quad-snd/js/audio.js" >> build/web/mq_js_bundle.js
    # cat "$HOME/srb/sapp-jsutils/js/sapp_jsutils.js" >> build/web/mq_js_bundle.js
    # cat "$HOME/srb/quad-net/js/quad-net.js" >> build/web/mq_js_bundle.js
    # cat "$HOME/srb/quad-url/js/quad-url.js" >> build/web/mq_js_bundle.js
    # cat "$HOME/srb/gamepads/js/macroquad-gamepads-0.1.js" >> build/web/mq_js_bundle.js

# Build the web distributable
web-build:
    cargo build --release --target wasm32-unknown-unknown --no-default-features
    cp target/wasm32-unknown-unknown/release/breakage.wasm dist/breakage-web/breakage.wasm

run:
    RUST_BACKTRACE=1 cargo run

fast:
    RUST_BACKTRACE=1 cargo run --release

test:
    RUST_BACKTRACE=1 cargo test
