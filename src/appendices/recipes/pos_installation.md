# Pos-Installation

## Double Checking

*# sorry I'm neurotic*
- [ ] Refresh the system, including package database: `sudo pacman -Syyu`
- [ ] Make sure some basic system packages are installed:
```sh
sudo pacman -S --needed base-devel bash curl gcc git ncurses xz zstd
```

## Installing Some Compilers

- [ ] clang: `sudo pacman -S clang`
- [ ] go: `sudo pacman -S go`
- [ ] lua: `sudo pacman -S lua`
- [ ] rustup:
```sh
sudo pacman -S rustup
```
```sh
rustup update stable
```

## Improving the Initramfs

- [ ] Install the microcode accordingly:
```sh
# for AMD CPU
sudo pacman -S amd-ucode
```
```sh
# for Intel CPU
sudo pacman -S intel-ucode
```
- [ ] Install booster: `sudo pacman -S booster`
- [ ] Copy both new images to the `/efi` directory:
```sh
cp /boot/cpu_manufacturer-ucode.img /efi
```
```sh
cp /boot/booster-linux.img /efi
```
- [ ] Create new loader entry:
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
- [ ] Take the opportunity to include other kernel parameters:
```
options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx nvme_load=YES nowatchdog rw
```
- [ ] Update the `loader.conf` file:
```sh
sudo nano /efi/loader/loader.conf
```
```txt
default  booster.conf
timeout  4
console-mode auto
```
- [ ] Verify the current available boot loader entries: `sudo bootctl list`
