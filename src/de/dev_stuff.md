# Dev Stuff

## Rust

### Toolchains

To install the `nightly` channel:

```bash
rustup toolchain install nightly
```

To check the installed toolchains:

```bash
rustup toolchain list
```

### Targets

To include support for the `Wasm` target:

```bash
rustup target add wasm32-unknown-unknown
```

To check the installed targets:

```bash
rustup target list --installed
```
