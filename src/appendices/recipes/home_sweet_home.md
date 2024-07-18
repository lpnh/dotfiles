# Home Sweet Home

## Bootstrap

- [ ] Install **chezmoi**: `sudo pacman -S chezmoi`
- [ ] Initialize it:
```sh
chezmoi init https://github.com/<user>/dotfiles.git
```
- [ ] Apply the changes: `chezmoi apply`
- [ ] Reboot the system: `reboot`

## Not Far From Home

- [ ] Refresh the font cache:
```sh
sudo fc-cache -fv
```
- [ ] Launch **niri** from the tty: `niri-session`
- [ ] Check if **Nushell** is in the valid shells list: `cat /etc/shells`
- [ ] Set **Nushell** as login shell:
```sh
chsh -s /usr/bin/nu <user>
```

## SSH

- [ ] Generate a new SSH key:
```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```
- [ ] Check the public key:
```sh
cat ~/.ssh/id_ed25519.pub
```
- [ ] Test the SSH connection:
```sh
ssh -T git@github.com
```

## Neovim

- [ ] Install and set Neovim nightly using **bob**:
```sh
bob install nightly
```
```sh
sudo bob use nightly
```
- [ ] Increase **inotify** maximum numbers:
```sh
sudo nano /etc/sysctl.conf
```
```sh
sysctl fs.inotify.max_queued_events=100000
sysctl fs.inotify.max_user_watches=524288
```

## Greeter

- [ ] Enable the **greetd** service: `systemctl enable greetd`
- [ ] Edit `greetd` configuration file:
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

Reboot the system: `reboot`

*# there's no place like home*
