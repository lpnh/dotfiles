# Home Sweet Home

- [ ] Install *chezmoi*

```bash
sudo pacman -S chezmoi
```

- [ ] Initialize it

```sh
chezmoi init https://github.com/<user>/dotfiles.git
```

- [ ] Apply the changes

```bash
chezmoi apply
```

*just watch the magic happen*

- [ ] Reboot the system

```bash
reboot
```

- [ ] Launch *niri* from the tty

```bash
niri-session
```

- [ ] Check if *fish* is in the valid shells list

```bash
cat /etc/shells
```

- [ ] Set *fish* as login shell

```sh
chsh -s /usr/bin/fish <user>
```

- [ ] Check it

```sh
getent passwd $USER | cut -d: -f7
```

- [ ] Refresh the font cache to make sure the fonts are available system-wide

```sh
sudo fc-cache -fv
```

- [ ] Install *xwayland-satellite*

```bash
git clone https://github.com/Supreeeme/xwayland-satellite.git
```

```bash
cd xwayland-satellite && cargo build --release -F systemd
```

```bash
cd target/release && sudo cp xwayland-satellite /usr/bin/
```

- [ ] Download *Bitwarden* [firefox
extension](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/)

- [ ] Login into Firefox

- [ ] Apply *Catppuccin Mocha Mauve* color theme to Firefox [by clicking
here](https://color.firefox.com/?theme=XQAAAAJEBAAAAAAAAABBqYhm849SCicxcUcPX38oKRicm6da8pFtMcajvXaAE3RJ0F_F447xQs-L1kFlGgDKq4IIvWciiy4upusW7OvXIRinrLrwLvjXB37kvhN5ElayHo02fx3o8RrDShIhRpNiQMOdww5V2sCMLAfehhpkvCNGPFQ9qpGpx7BgGSYPGUMFXC1Ua9FaxHdWOc93hEJrTCm7pTY2gENlkIGOUk-0q5koU7B1u0Ej-oMph40xEOeck_YUJD52Bwer09STdlto8FTe2opihD2FyRdpJyZydtlY3dK_RO373JUB4GPAs2saJone2-92ozhdZDXTzFe1BzECDYiTLKw8wgkHlYGBfEaHwiRhB6Xx67wrqMSr8VhLm8d-NCA1DySJVtxxWJN-qabWQpDds2gw6dhs97Ngt5Z_6ZhJ5vv31xfjj2v6iK816VOdJaIaQu4xsqHAytxXRLJQ8LtmF0BsXZI5kUVsRJUHALGJAvl388n-yyQfaq8ZWzVK-rrBoAJJqwlvJaa-7K1eFh6NaMojpf5pl-eqKMtg1KMmYlS4DjK6Z__leZhs)

- [ ] Generate a new SSH key

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```

- [ ] Check the public key

```sh
cat ~/.ssh/id_ed25519.pub
```

- [ ] Use *github* to test the SSH connection

```sh
ssh -T git@github.com
```

- [ ] Rebuild *bat* cache to include catppuccin's syntax highlighting

```bash
bat cache --build
```

- [ ] Check if it's now available

```bash
bat --list-themes | rg "Catppuccin"
```

- [ ] Fetch *Yazi* plugins

```bash
ya pack -i
```

```bash
ya pack -u
```

- [ ] Install and set *Neovim nightly*

```sh
bob install nightly
```

```sh
sudo bob use nightly
```

- [ ] Increase *inotify* maximum values

```sh
sudo nano /etc/sysctl.conf
```

```txt
fs.inotify.max_queued_events=524288
fs.inotify.max_user_watches=524288
```

- [ ] Launch *Neovim* to fetch its configuration

```bash
nv
```

- [ ] Include the api-key for the *WakaTime* plugin

```bash
# launch the website and copy the api key
open https://wakatime.com/api-key
```

```bash
# run the following cmd inside neovim and paste the key
WakaTimeApiKey
```

- [ ] Enable the *ly* service

```bash
systemctl enable ly
```

Reboot the system

```bash
reboot
```

*there's no place like home*
