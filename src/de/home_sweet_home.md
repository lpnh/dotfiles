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

Reboot the system to check if everything is ok.
