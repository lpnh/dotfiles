# Pos-Installation

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

- [ ] If you plan to use packages like steam, make sure to enable (uncomment)
the *multilib* repository

```txt
[multilib]
Include = /etc/pacman.d/mirrorlist
```

- [ ] Include the [heftig's
repo](https://bbs.archlinux.org/viewtopic.php?id=117157) to have access to the
*firefox-nightly* package

```txt
[heftig]
SigLevel = Optional
Server = https://pkgbuild.com/~heftig/repo/$arch
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

- An example for the *pacman.conf* file can be found on [EndeavourOS
repo](https://github.com/endeavouros-team/EndeavourOS-ISO/blob/main/airootfs/etc/pacman.conf).
