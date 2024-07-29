# Home Sweet Home

## Bootstrap

To install `chezmoi`:

```bash
sudo pacman -S chezmoi
```

To initialize it:

```bash
chezmoi init https://github.com/<user>/dotfiles.git
```

To apply it:

```bash
chezmoi apply
```

Note: a lot of packages will be installed. Probably would be a good idea to
reboot the system after it.

For the exhaustive list of packages, you can check the
[packages.toml](https://github.com/lpnh/dotfiles/blob/main/home/.chezmoidata/packages.toml)
file from the repo.

Hint: A good reference for essential packages is to check the ones available in
the Arch Linux live system (ISO). You can find them
[here](https://geo.mirror.pkgbuild.com/iso/latest/arch/pkglist.x86_64.txt).
Another good source is to check the packages available in the EndeavourOS ISO.
You can find them in [their
repo](https://github.com/endeavouros-team/EndeavourOS-ISO/blob/main/packages.x86_64).

## Graphical Interface

To launch `niri` from the `tty`:

```bash
niri-session
```

## Shell

To check if Nushell is in the valid shells list:

```bash
cat /etc/shells
```

To set Nushell as login shell:

```bash
chsh -s /usr/bin/nu <user>
```

Note: Reboot the system to check if everything is ok

## Font

To refresh the font cache:

```bash
sudo fc-cache -fv
```

## SSH

To generate a new SSH key:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

To check the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

To test the SSH connection:

```bash
ssh -T git@github.com
```

## Neovim

To install and set Neovim nightly using `bob`:

```bash
bob install nightly
```

```bash
sudo bob use nightly
```

To increase the maximum number of `inotify` watches and queued events. Edit the
`/etc/sysctl.conf` file:

```bash
sudo nano /etc/sysctl.conf
```
```bash
fs.inotify.max_queued_events=524288
fs.inotify.max_user_watches=524288
```

## Pandoc

Download `Pandoc` latest release from the
[repo](https://github.com/jgm/pandoc/releases)

To install it:

```bash
sudo tar xvzf /path/to/pandoc-version-linux-amd64.tar.gz --strip-components 1 -C /usr/local
```

## Display Manager

To enable the `ly` service:

```bash
systemctl enable ly
```

Reboot the system: 

```bash
reboot
```

*# there's no place like home*
