# Pos-Installation

## System Check

Refresh the entire system:

```sh
sudo pacman -Syyu
```

Make sure to have some basic system packages installed:

```sh
sudo pacman -S --needed base-devel bash curl gcc git ncurses xz zstd
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

Copy both microcode and booster images to the `/efi` path.

Create new loader entry including both new initrd images accordingly:

```sh
sudo nano /efi/loader/entries/booster.conf
```

```txt
title   Arch Linux with Booster
linux   /vmlinuz-linux
initrd  /cpu_manufacturer-ucode.img
initrd  /booster-linux.img
options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx rw
```

You can take the opportunity to include other kernel parameters to the option
line. For example `nvme_load=YES`, `nowatchdog`, `quiet`, `splash`, etc.

To check the parameters your system was booted up with:

```sh
cat /proc/cmdline
```

Update the `/efi/loader/loader.conf` file:

```sh
sudo nano /efi/loader/loader.conf
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

## Pacman

Update `pacman` configuration file:

```sh
sudo nano /etc/pacman.conf
```

An example can be found on [EndeavourOS
repo](https://github.com/endeavouros-team/EndeavourOS-ISO/blob/main/airootfs/etc/pacman.conf)

## Yay

Create and cd into an `apps` directory:

```sh
mkdir apps && cd apps
```

Install `yay`:

```sh
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

First use:

```sh
yay -Y --gendb
```
