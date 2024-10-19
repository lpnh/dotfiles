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

- [ ] Edit the *mocha.conf* file, commenting the last line

```bash
nano catppuccin/mocha.conf
```

```txt
#showtools hidden_tags
```

- [ ] Edit the *refind.conf*, making sure to add a new *menuentry* for the
*systemd-boot* and also including the *mocha.conf* file

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

- [ ] Install *pacman-contrib*

```bash
sudo pacman -S pacman-contrib
```

- [ ] Enable the *paccache.timer* to periodically clean the pacman cache

```bash
systemctl enable paccache.timer
```

- [ ] Update *pacman* configuration file

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

- [ ] Update the database

```bash
pacman -Sy
```

- [ ] Install *yay*

```bash
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

- [ ] Install extra pacman hooks

```bash
yay -S pacman-hook-kernel-install
```

- [ ] Reinstall the kernel package to trigger the unified kernel image hooks

```bash
sudo pacman -S linux
```

- [ ] Check the current available boot entries

```bash
sudo bootctl list
```

## Notes

- For some reason the *rEFInd* showtools variable is not working properly for
me anymore, this is why I have to comment that line on catppucin's mocha file
- An example for the *pacman.conf* file can be found on [EndeavourOS
repo](https://github.com/endeavouros-team/EndeavourOS-ISO/blob/main/airootfs/etc/pacman.conf).
If you plan to use packages like steam, make sure to enable (uncomment) the
[multilib] repository
