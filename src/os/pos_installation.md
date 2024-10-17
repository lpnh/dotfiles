# Pos-Installation

- [ ] Create the *themes* directory for *refind*

```bash
cd /efi/EFI/refind
```

- [ ] On refind installation path, clone the catppuccin repo inside a *themes*
directory

```bash
mkdir themes && cd themes
```

```bash
git clone https://github.com/catppuccin/refind.git catppuccin
```

```bash
nano catppuccin/mocha.conf
```

- [ ] Edit the *refind.conf*, adding a new *menuentry* for the *systemd-boot*
and also including the *mocha.conf* file

```bash
nano ../refind.conf
```

```txt
timeout 5

[...]

menuentry "Arch Linux" {
    icon /EFI/refind/themes/catppuccin/assets/mocha/icons/os_arch.png
    volume "ARCHIE_ESP"
    loader /EFI/systemd/systemd-bootx64.efi
}

include themes/catppuccin/mocha.conf
```

- [ ] Install some compilers

```sh
sudo pacman -S clang go lua rustup
```

```sh
rustup update stable
```

- [ ] Update the *loader.conf* file

```bash
sudo nano /efi/loader/loader.conf
```

```txt
timeout 1
console-mode auto
```

- [ ] Update *pacman* configuration file

```bash
sudo nano /etc/pacman.conf
```

- [ ] Install *pacman-contrib*

```bash
sudo pacman -S pacman-contrib
```

- [ ] Enable the *paccache.timer* to periodically clean the pacman cache

```bash
systemctl enable paccache.timer
```

- [ ] Create and cd into the *apps* directory

```bash
mkdir apps && cd apps
```

- [ ] Install *yay*

```bash
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

- [ ] Install extra pacman hooks

```bash
yay -S pacman-hook-kernel-install
```

- [ ] Reinstall the kernel package to trigger the unified kernel image
generation

```bash
sudo pacman -S linux
```

- [ ] Check the current available boot entries

```bash
bootctl list
```
