# Pos-Installation

## Double Checking

*# sorry I'm neurotic*
- [ ] Check the **timesyncd** service: `timedatectl status`
- [ ] Refresh the system, including the package database: `sudo pacman -Syyu`
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

## Mkinitcpio Preset

- [ ] Keep the default **linux.preset** file as backup:
```bash
sudo cp /etc/mkinitcpio.d/linux.preset /etc/mkinitcpio.d/linux.preset.bak
```
- [ ] Update it to use the **/efi/** path instead of **/boot**.
```bash
sudo nano /etc/mkinitcpio.d/linux.preset
```
```txt
# mkinitcpio preset file for the 'linux' package

#ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/efi/vmlinuz-linux"

PRESETS=('default' 'fallback')

#default_config="/etc/mkinitcpio.conf"
default_image="/efi/initramfs-linux.img"
#default_uki="/efi/EFI/Linux/arch-linux.efi"
#default_options="--splash /usr/share/systemd/bootctl/splash-arch.bmp"

#fallback_config="/etc/mkinitcpio.conf"
fallback_image="/efi/initramfs-linux-fallback.img"
#fallback_uki="/efi/EFI/Linux/arch-linux-fallback.efi"
fallback_options="-S autodetect"
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
- [ ] Install **booster**: `sudo pacman -S booster`
- [ ] Copy both new images to the  **/efi** directory:
```sh
sudo cp /boot/cpu_manufacturer-ucode.img /efi
```
```sh
sudo cp /boot/booster-linux.img /efi
```
- [ ] Create a new loader entry based on the previous **arch.conf**:
```sh
sudo cd /efi/loader/entries
```
```sh
sudo cp arch.conf booster.conf
```
```sh
sudo nano booster.conf
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
- [ ] Update the **loader.conf** file:
```sh
sudo nano /efi/loader/loader.conf
```
```txt
default  booster.conf
timeout  4
console-mode auto
```

- [ ] Backup booster **regenerate_images** default script:
```bash
sudo cp /usr/lib/booster/regenerate_images /usr/lib/booster/regenerate_images.bak
```
- [ ] Update the script to use the **/efi** path instead of
**/boot**:
```bash
sudo nano /usr/lib/booster/regenerate_images
```
```txt
  booster build --force --kernel-version ${kernel##/usr/lib/modules/} /efi/booster-${pkgbase}.img &
  install -Dm644 "${kernel}/vmlinuz" "/efi/vmlinuz-${pkgbase}"
```

- [ ] Verify the current available boot loader entries: `sudo bootctl list`

## rEFInd

- [ ] Install **refind** package: `sudo pacman -S refind`
- [ ] Install it with the **refind-install** script: `refind-install`
- [ ] Start an interactive shell as root: `su`
- [ ] Create the **themes** directory inside refind installation path:
```sh
cd /efi/EFI/refind
mkdir themes
```
- [ ] Clone the catppuccin repo inside the **themes** directory:
```sh
git clone https://github.com/catppuccin/refind.git catppuccin
```
- [ ] Edit the catppuccin **mocha.conf** file, adding the **hidden_tags** back to the interface:
```sh
cd catppuccin
nano mocha.conf
```
```txt
# Which non-bootloader tools to show on the tools line, and in what
# order to display them:
#  shell           - the EFI shell (requires external program; see rEFInd
#                    documentation for details)
#  gptsync         - the (dangerous) gptsync.efi utility (requires external
#                    program; see rEFInd documentation for details)
#  apple_recovery  - boots the Apple Recovery HD partition, if present
#  mok_tool        - makes available the Machine Owner Key (MOK) maintenance
#                    tool, MokManager.efi, used on Secure Boot systems
#  about           - an "about this program" option
#  exit            - a tag to exit from rEFInd
#  shutdown        - shuts down the computer (a bug causes this to reboot
#                    EFI systems)
#  reboot          - a tag to reboot the computer
#  firmware        - a tag to reboot the computer into the firmware's
#                    user interface (ignored on older computers)
# Default is shell,apple_recovery,mok_tool,about,shutdown,reboot,firmware
#
showtools hidden_tags shutdown
```

- [ ] Go back to the **refind** directory:
```sh
cd /efi/EFI/refind
```
- [ ] Edit the **refind.conf**, adding a new **menuentry** for the
**systemd-boot** and also including the *mocha.conf* file:
```sh
nano refind.conf
```
```no_rust
menuentry "Arch Linux" {
    icon /EFI/refind/themes/catppuccin/assets/mocha/icons/os_arch.png
    volume "ARCHIE"
    loader /EFI/systemd/systemd-bootx64.efi
}

include themes/catppuccin/mocha.conf
```
- [ ] Exit the interactive shell: `exit`

## Package Manager

### Pacman

- [ ] Update **pacman** configuration file:
```sh
sudo nano /etc/pacman.conf
```
```txt
# Misc options
#UseSyslog
Color
ILoveCandy
#NoProgressBar
#CheckSpace
VerbosePkgLists
ParallelDownloads = 5
```

### Yay

- [ ] Create and cd into the **apps** directory:
```bash
mkdir apps && cd apps
```
- [ ] Install **yay**:
```bash
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```
```bash
# I'm not sure about this one
yay -Y --gendb
```

Reboot the system: `reboot`
