# Pos-Installation

## System Check

Refresh the entire system:

```sh
sudo pacman -Syyu
```

Make sure to have some basic system packages installed:

```sh
sudo pacman -S bash curl gcc git ncurses xz zstd
```

## Compilers

Install `clang`:

```sh
sudo pacman -S clang
```

Install `go`:

```sh
sudo pacman -S go
```

Install `rustup`:

```sh
sudo pacman -S rustup
```

```sh
rustup update stable
```

## New Initrd

Install `amd-ucode` or `intel-ucode` according with your CPU.

```sh
sudo pacman -S amd-ucode
```

```sh
sudo pacman -S intel-ucode
```

Install `booster`:

```sh
sudo pacman -S booster
```

Move both microcode and booster images to the `/efi` path.

Add new loader entry:

```sh
nano /efi/loader/entries/booster.conf
```

Including both new initrd images accordingly:

```txt
title   Arch Linux with Booster
linux   /vmlinuz-linux
initrd  /cpu_manufacturer-ucode.img
initrd  /booster-linux.img
options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx rw
```

Update the `/efi/loader/loader.conf` file:

```sh
nano /efi/loader/loader.conf
```

To use the `booster.conf` as default:

```txt
default  booster.conf
timeout  4
console-mode auto
```

To verify the boot loader entries:

```sh
sudo bootctl list
```
