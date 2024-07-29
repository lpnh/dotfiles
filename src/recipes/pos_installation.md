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

## Graphic Drivers

### OpenGL

- [ ] Install **mesa**:
```bash
sudo pacman -S mesa
```

### AMD

- [ ] For Vulkan support:
```bash
sudo pacman -S vulkan-radeon
```

### Nvidia

- [ ] Install the **nvidia** package:
```bash
sudo pacman -S nvidia
```

## UKI

### Busybox

- [ ] Install **busybox**:
```bash
sudo pacman -S busybox
```

### Microcode

- [ ] Install **amd-ucode** or **intel-ucode** according with your CPU.
```sh
sudo pacman -S amd-ucode
```
```sh
sudo pacman -S intel-ucode
```

### Booster

- [ ] Install **booster**:
```sh
sudo pacman -S booster
```
- [ ] Set the configuration file accordingly:
```sh
sudo nano /etc/booster.yaml
```
```yaml
extra_files: busybox,fsck,fsck.ext4
modules_force_load: amdgpu,hid_generic,usbhid
```
- [ ] For **NVIDIA** you can replace **amdgpu** with the following:
```yaml
modules_force_load: nvidia,nvidia_modeset,nvidia_uvm,nvidia_drm
```

### Ukify

- [ ] Install **systemd-ukify**:
```bash
sudo pacman -S systemd-ukify
```
- [ ] Set the configuration accordingly:
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

### Kernel-install

- [ ] Set the **install.conf** file:
```bash
sudo nano /etc/kernel/install.conf
```
```txt
layout=uki
uki_generator=ukify
```
- [ ] Set the **ukify** configuration:
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
- [ ] Verify the current **kernel-install** configuration:
```sh
kernel-install inspect
```

### Kernel Command Line

- [ ] Check the parameters your system was booted up with:
```sh
cat /proc/cmdline
```
- [ ] Include new kernel parameters to the **UKI**:
```sh
sudo nano /etc/kernel/cmdline
```


## rEFInd

- [ ] Install **refind** package: `sudo pacman -S refind`
- [ ] Install it with the **refind-install** script: `refind-install`
- [ ] Start an interactive shell as root: `su`
- [ ] Create the **themes** directory inside refind installation path:
```bash
cd /efi/EFI/refind
mkdir themes
```
- [ ] Clone the catppuccin repo inside the **themes** directory:
```bash
cd themes
git clone https://github.com/catppuccin/refind.git catppuccin
```
- [ ] Go back to the **refind** directory:
```bash
cd /efi/EFI/refind
```
- [ ] Edit the **refind.conf**, adding a new **menuentry** for the
**systemd-boot** and also including the *mocha.conf* file:
```bash
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
```bash
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

### Additional Pacman Hooks

Install extra pacman hooks for the `kernel-install`:

```bash
yay -S pacman-hook-kernel-install
```

## Generating the UKI

- [ ] Reinstall the kernel package to generate the unified kernel image:
```bash
sudo pacman -S linux
```
- [ ] Check the current available boot entries:
```bash
sudo bootctl list
```
If everything seems correct, reboot the system: `reboot`
