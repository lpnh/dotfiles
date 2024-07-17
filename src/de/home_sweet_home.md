# Home Sweet Home

## Bootstrap

Install `chezmoi`:

```sh
sudo pacman -S chezmoi
```

Initialize it:

```sh
chezmoi init https://github.com/<user>/dotfiles.git
```

Apply it:

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

Edit `greetd` configuration file to use `tuigreet`:

```sh
sudo nano /etc/greetd/config.toml
```

```toml
[terminal]
vt = 1

[default_session]
command = "tuigreet --remember --remember-session --asterisks"
user = "greeter"
```

## Graphical Interface

Launching `niri` from the `tty`:

```sh
niri-session
```

## Shell

Check if Nushell is in the valid shells list:

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

Check the public key:

```sh
cat ~/.ssh/id_ed25519.pub
```

Test the SSH connection:

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

To increase the maximum number of `inotify` watches and queued events.
Add the following to `/etc/sysctl.conf`

```sh
sysctl fs.inotify.max_user_watches=100000
sysctl fs.inotify.max_queued_events=100000
```
