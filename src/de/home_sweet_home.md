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
reboot the system after it?

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
