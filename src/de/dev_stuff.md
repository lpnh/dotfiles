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

## Fly.io

### Update the DNS

<div class="warning">
This is a necessary step for my environment.
Not sure if this will be the case for anyone else.
</div>

To get the list of the current active profiles:

```bash
nmcli connection show --active
```

To check the current DNS values

```bash
nmcli connection show 'NAME' | rg dns
```

To update the DNS:

```bash
nmcli connection modify 'NAME' ipv4.dns "8.8.8.8 1.1.1.1"
```

To reconnect:

```bash
nmcli connection down 'NAME'
```
```bash
nmcli connection up 'NAME'
```

### flyctl

To installing `flyctl`:

```bash
curl -L https://fly.io/install.sh | sh
```

To sign in using `flyctl`:

```bash
fly auth login
```
