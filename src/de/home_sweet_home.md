# Home Sweet Home

## Bootstrap

To install `chezmoi`:

```sh
sudo pacman -S chezmoi
```

To initialize it:

```sh
chezmoi init https://github.com/<user>/dotfiles.git
```

To apply it:

```sh
chezmoi apply
```

Note: a lot of packages will be installed. Probably would be a good idea to
reboot the system after it.

For the exhaustive list of packages, you can check the
[packages.yaml](https://github.com/lpnh/dotfiles/blob/main/home/.chezmoidata/packages.yaml)
file from the repo.

Hint: A good reference for essential packages is to check the ones available in
the Arch Linux live system (ISO). You can find them
[here](https://geo.mirror.pkgbuild.com/iso/latest/arch/pkglist.x86_64.txt).
Another good source is to check the packages available in the EndeavourOS ISO.
You can find them in [their
repo](https://github.com/endeavouros-team/EndeavourOS-ISO/blob/main/packages.x86_64).

## Greeter

To enable the `greetd` service:

```sh
systemctl enable greetd
```

To edit the `greetd` configuration file to use `tuigreet`:

```sh
sudo nano /etc/greetd/config.toml
```
```toml
# The default session, also known as the greeter.
[default_session]

# `agreety` is the bundled agetty/login-lookalike. You can replace `/bin/sh`
# with whatever you want started, such as `sway`.
command = "tuigreet --remember --remember-session --asterisks"
```

## Graphical Interface

To launch `niri` from the `tty`:

```sh
niri-session
```

## Shell

To check if Nushell is in the valid shells list:

```sh
cat /etc/shells
```

To set Nushell as login shell:

```sh
chsh -s /usr/bin/nu <user>
```

Note: Reboot the system to check if everything is ok.

## Font

To refresh the font cache:

```sh
sudo fc-cache -fv
```

## SSH

To generate a new SSH key:

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```

To check the public key:

```sh
cat ~/.ssh/id_ed25519.pub
```

To test the SSH connection:

```sh
ssh -T git@github.com
```

## Neovim

To install and set Neovim nightly using `bob`:

```sh
bob install nightly
```

```sh
sudo bob use nightly
```

To increase the maximum number of `inotify` watches and queued events. Edit the
`/etc/sysctl.conf` file:

```sh
sudo nano /etc/sysctl.conf
```
```sh
fs.inotify.max_queued_events=524288
fs.inotify.max_user_watches=524288
```
