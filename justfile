build:
    echo "build project"
    cargo near build

test:
    echo "test in serie"
    RUST_TEST_THREADS=1 cargo test -- --nocapture

test_2:
    echo "test no capture"
    cargo test -- --nocapture

clippy:
    echo "Running clippy"
    cargo clippy --all-targets --all-features -- -D warnings -D clippy::all -D clippy::nursery