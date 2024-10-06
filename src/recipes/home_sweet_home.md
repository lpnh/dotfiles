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

- [ ] Launch **niri** from the tty: `niri-session`
- [ ] Check if **fish** is in the valid shells list: `cat /etc/shells`
- [ ] Set **fish** as login shell:
```sh
chsh -s /usr/bin/fish <user>
```
- [ ] Check it:
```sh
getent passwd $USER | cut -d: -f7
```
- [ ] Refresh the font cache:
```sh
sudo fc-cache -fv
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

- [ ] Install and set **Neovim nightly** using **bob**:
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
```txt
fs.inotify.max_queued_events=524288
fs.inotify.max_user_watches=524288
```

## Display Manager

- [ ] Enable the **ly** service: `systemctl enable ly`

Reboot the system: `reboot`

*# there's no place like home*
