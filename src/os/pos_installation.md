# Pos-Installation

## Double Checking

To check the `timesyncd` service, run:

```bash
timedatectl status
```

To refresh the entire system:

```bash
sudo pacman -Syyu
```

Make sure to have some basic system packages installed:

```bash
sudo pacman -S --needed base-devel bash curl gcc git ncurses xz zstd
```
## Installing Some Compilers

Install `clang`:

```bash
sudo pacman -S clang
```

Install `go`:

```bash
sudo pacman -S go
```

Install `lua`:

```bash
sudo pacman -S lua
```

Install `rustup`:

```bash
sudo pacman -S rustup
```
```bash
rustup update stable
```

## Graphic Drivers

### OpenGL

Install `mesa`:

```bash
sudo pacman -S mesa
```

### AMD

For Vulkan support:

```bash
sudo pacman -S vulkan-radeon
```

### Nvidia

Install the `nvidia` package:

```bash
sudo pacman -S nvidia
```

## UKI

### Busybox

Install `busybox` to enable an emergency shell in case of a panic during the
boot process:

```bash
sudo pacman -S busybox
```

### Microcode

Install `amd-ucode` or `intel-ucode` according with your CPU.

```sh
sudo pacman -S amd-ucode
```

```sh
sudo pacman -S intel-ucode
```

### Booster

Install `booster`:

```sh
sudo pacman -S booster
```

Set the configuration file accordingly:

```sh
sudo nano /etc/booster.yaml
```
```yaml
extra_files: busybox,fsck,fsck.ext4
modules_force_load: amdgpu,hid_generic,usbhid
```

Note: the `modules_force_load: amdgpu,hid_generic,usbhid` line is not obligatory.

For `NVIDIA` you can replace `amdgpu` with the following:

```yaml
modules_force_load: nvidia,nvidia_modeset,nvidia_uvm,nvidia_drm
```

### Ukify

Install `systemd-ukify`:

```bash
sudo pacman -S systemd-ukify
```

Set the configuration accordingly:

```bash
sudo nano /etc/ukify.conf
```
```txt
[UKI]
Linux=/boot/vmlinuz-linux
Initrd=/boot/amd-ucode.img /boot/booster-linux.img
Cmdline=@/etc/kernel/cmdline
OSRelease=@/etc/os-release
Splash=/usr/share/systemd/bootctl/splash-arch.bmp
```

Note: probably this configuration isn't required because it will be replaced by
the `kernel-install` one.

### Kernel-install

Set the `install.conf` file:

```bash
sudo nano /etc/kernel/install.conf
```
```txt
layout=uki
uki_generator=ukify
```

Set the `ukify` configuration in the `uki.conf` file:

```bash
sudo nano /etc/kernel/uki.conf
```
```txt
[UKI]
Linux=/boot/vmlinuz-linux
Initrd=/boot/amd-ucode.img /boot/booster-linux.img
Cmdline=@/etc/kernel/cmdline
OSRelease=@/etc/os-release
Splash=/usr/share/systemd/bootctl/splash-arch.bmp
```

To verify the current `kernel-install` paths and parameters configuration, run:

```sh
kernel-install inspect
```

### Kernel Command Line

To check the parameters your system was booted up with, run:

```sh
cat /proc/cmdline
```

To include new kernel parameters to the `UKI`, for example `nvme_load=YES`, `nowatchdog`, `quiet`, `splash`, etc. use the `/etc/kernel/cmdline` file:

```sh
sudo nano /etc/kernel/cmdline
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

Note: for comfort I will use the `su` command that launches an interactive shell
as root.

To add the [catppuccin theme](https://github.com/catppuccin/refind), create a
`themes` directory inside refind installation path:

```sh
cd /efi/EFI/refind
mkdir themes
```

Clone the repo inside the `themes` folder:

```sh
cd themes
git clone https://github.com/catppuccin/refind.git catppuccin
```

It requires a `include themes/catppuccin/mocha.conf` line to be appended to the
end of `refind.conf` file.

To go back to the `refind` directory:

```sh
cd /efi/EFI/refind
```

We can now customize the `refind.conf` by adding a new `menuentry` for the
`systemd-boot` boot loader. Although it might seem a bit contradictory to use
rEFInd to launch systemd-boot, rEFInd's role here is to provide a simple and
customizable interface that can handle a dual-boot scenario for different
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

## Package Manager

### Pacman

Update `pacman` configuration file:

```sh
sudo nano /etc/pacman.conf
```

An example can be found on [EndeavourOS
repo](https://github.com/endeavouros-team/EndeavourOS-ISO/blob/main/airootfs/etc/pacman.conf). If you plan to use packages like `steam`, make sure to enable (uncomment) the `[multilib]` repository.

### Yay

First, create and `cd` into an `apps` directory:

```bash
mkdir apps && cd apps
```

To install `yay`:

```bash
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

### Additional Pacman Hooks

Install extra pacman hooks for the `kernel-install`:

```bash
yay -S pacman-hook-kernel-install
```

### Pacman Utilities

Install the `pacman-contrib` package:

```bash
sudo pacman -S pacman-contrib
```

Enable the `paccache.timer` to periodically clean the `pacman` cache:

```bash
systemctl enable paccache.timer
```

## Generating the UKI

Reinstall the kernel package to trigger the `kernel-install` in order to
generate the unified kernel image:

```bash
sudo pacman -S linux
```

To list the current available boot entries which have been configured, run:

```bash
sudo bootctl list
```

If everything seems correct, reboot the system:

```bash
reboot
```
