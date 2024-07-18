# Pos-Installation

## Double Checking

*# sorry I'm neurotic*
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
cp /boot/cpu_manufacturer-ucode.img /efi
```
```sh
cp /boot/booster-linux.img /efi
```
- [ ] Create a new loader entry:
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
- [ ] Update the **loader.conf** file:
```sh
sudo nano /efi/loader/loader.conf
```
```txt
default  booster.conf
timeout  4
console-mode auto
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

end of `refind.conf` file. But before that, let's 

- Edit the catppuccin **mocha.conf** file, adding the **hidden_tags** back to the interface:
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

- [ ] Go back to `refind` directory:
```sh
cd /efi/EFI/refind
```
- [ ] Edit the **refind.conf**, adding a new **menuentry** for the
**systemd-boot** and also the including the *mocha.conf* file:
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
```sh
mkdir apps && cd apps
```
- [ ] Install **yay**:
```sh
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```
```sh
# I'm not sure about this one
yay -Y --gendb
```
