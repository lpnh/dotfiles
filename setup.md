# Setup

## Bootstrap

Installing `rustup`

```sh
yay -S rustup
```

```sh
rustup update stable
```

Installing `alacritty`, `niri` and `chezmoi`

```sh
yay -S alacritty niri chezmoi
```

Launching `niri`

```sh
niri-session
```

## Chezmoi

```sh
chezmoi init https://github.com/<user>/dotfiles.git
```

```sh
chezmoi apply
```

## Nushell

Checking if Nu is in the valid shells list:

```sh
cat /etc/shells
```

Setting Nu as login shell:

```sh
chsh -s /usr/bin/nu <user>
```

## Font

Refreshing the font cache

```sh
sudo fc-cache -fv
```

## GitHub

Generating a new SSH key:

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Echo the public key:

```sh
cat ~/.ssh/id_ed25519.pub
```

Testing the SSH connection:

```sh
ssh -T git@github.com
```

## Rust

Installing rust-analyzer

```sh
rustup component add rust-analyzer
```

Adding WebAssembly target

```sh
rustup target add wasm32-unknown-unknown
```

## Neovim

Installing Neovim nightly

```sh
bob install nightly
```

Increasing the maximum number of `inotify` watches and queued events.
Add the following to `/etc/sysctl.conf`

```sh
sysctl fs.inotify.max_user_watches=100000
sysctl fs.inotify.max_queued_events=100000
```

## Greetd-tuigreet

Enabling the `greetd` service

```sh
systemctl enable greetd
```

Editing `greetd` config to use `tuigreet`

```sh
sudo nvim /etc/greetd/config.toml
```

```toml
[terminal]
vt = 1

[default_session]
command = "tuigreet --remember --remember-session --asterisks"
user = "greeter"
```

## Psd

Checking the config and current status

```sh
psd preview
```

### Overlayfs

Adding necessary sudo rights on `/etc/sudoers`

```sh
sudo visudo
```

```
<user> ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper
```

### Service

Enabling psd service

```
systemctl --user enable psd.service
```

Starting the service

```
systemctl --user start psd.service
```

## Timer

Enabling timer service

```sh
systemctl --user enable break-reminder.timer
```

## Pandoc

Download and installing the latest release:

https://github.com/jgm/pandoc/releases

```
sudo tar xvzf $TGZ --strip-components 1 -C /usr/local
```

## NetworkManager

### Wi-Fi

Getting a list of Wi-Fi networks

```sh
nmcli device wifi list
```

Connecting to a Wi-Fi

```sh
nmcli device wifi connect <SSID_or_BSSID> password <password>
```

### DNS

Getting a list of connections

```sh
nmcli connection show
```

Checking the DNS values

```sh
nmcli connection show 'NAME' | rg dns
```

Setting the DNS

```sh
nmcli connection modify 'NAME' ipv4.dns "8.8.8.8 1.1.1.1"
```

Reconnecting

```sh
nmcli connection down 'NAME'
```

```sh
nmcli connection up 'NAME'
```

## Tlp

Enabling the service:

```sh
systemctl enable tlp.service
```

Masking rfkill:

```sh
systemctl mask systemd-rfkill.service
```

```sh
systemctl mask systemd-rfkill.socket
```

## EndeavourOS

Updating Arch mirrors:

```sh
sudo reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist
```

Updating EndeavourOS mirrors:

```sh
eos-rankmirrors --verbose
```

Refreshing the entire system:

```sh
yay -Syyu
```

## Virtual Machine

Checking if virtualization is enabled

```sh
grep -Ec '(vmx|svm)' /proc/cpuinfo
```

Installing necessary packages

```sh
sudo pacman -Syu virt-manager qemu-desktop dnsmasq iptables-nft
```

Enabling libvirtd service

```sh
sudo systemctl enable --now libvirtd.service
```

Adding the user to the libvirt group

```sh
sudo usermod -aG libvirt $env.USER
```

Restarting the libvirtd service

```sh
systemctl restart libvirtd.service
```
