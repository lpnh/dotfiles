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

Install `lua`:

```sh
sudo pacman -S lua
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

## rEFInd

Install `refind` package:

```sh
sudo pacman -S refind
```

Install it with the `refind-install` script:

```sh
refind-install
```

Note: for comfort I will run `su` to use the interactive shell as root.

To add the [catppuccin theme](https://github.com/catppuccin/refind), create a
`themes` directory inside refind installation path:

```sh
cd /efi/EFI/refind
mkdir themes
```

Clone the repo inside the `themes` folder:

```sh
git clone https://github.com/catppuccin/refind.git catppuccin
```

It requires a `include themes/catppuccin/mocha.conf` line to be appended to the
end of `refind.conf` file. But before that, let's add the `hidden_tags` back to
the interface, editing the catppuccin `mocha.conf` file:

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

Note: The option values start after the `showtools` key word.

Back to `refind` directory:

```sh
cd /efi/EFI/refind
```

We can now customize the `refind.conf`, adding a new `menuentry` for the
`systemd-boot` boot loader. I know it seems a bit contradictory using refind to
launch systemd-boot, but refind role here is to provide a simple and
customizable interface, capable to handle a dual boot scenario for different
available distros.

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

Note the catppuccin theme being included in the last line.

For more info, check rEFInd [official
documentation](https://www.rodsbooks.com/refind/configfile.html)

To exit the interactive shell simply run `exit`.

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
