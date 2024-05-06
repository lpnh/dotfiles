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
chezmoi init https://github.com/lpnh/dotfiles.git
```

```sh
chezmoi apply
```

## EndeavourOS

Updating Arch mirrors:

```
reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist
```

Updating EndeavourOS mirrors:

```
eos-rankmirrors --verbose
```

Refreshing the entire system:

```
yay -Syyu
```

## Nushell

Checking if Nu is in the valid shells list:

```
cat /etc/shells
```

Setting Nu as login shell:

```
chsh -s /usr/bin/nu lpnh
```

## Font

Refreshing the font cache

```
sudo fc-cache -fv
```

## GitHub

Generating a new SSH key:

```
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Echo the public key:

```
cat ~/.ssh/id_ed25519.pub
```

Testing the SSH connection:

```
ssh -T git@github.com
```

## Rust

Installing rust-analyzer

```
rustup component add rust-analyzer
```

Adding WebAssembly target

```
rustup target add wasm32-unknown-unknown
```

## Neovim

Installing neovim npm package

```
sudo npm install -g neovim
```

Increasing the maximum number of `inotify` watches and queued events.
Add the following to `/etc/sysctl.conf`

```
sysctl fs.inotify.max_user_watches=100000
sysctl fs.inotify.max_queued_events=100000
```

## Greetd-tuigreet

Enabling the `greetd` service

```
systemctl enable greetd
```

Editing `greetd` config to use `tuigreet`

```
sudo nvim /etc/greetd/config.toml
```

```
[terminal]
vt = 1

[default_session]
command = "tuigreet --remember --remember-session --asterisks"
user = "greeter"
```

## Timer

Enabling timer service

```
systemctl --user enable reminder.timer
```

## NetworkManager

### Wi-Fi

Getting a list of Wi-Fi networks

```
nmcli device wifi list
```

Connecting to a Wi-Fi

```
nmcli device wifi connect <SSID_or_BSSID> password <password>
```

### DNS

Getting a list of connections

```
nmcli connection show
```

Checking the DNS values

```
nmcli connection show 'NAME' | rg dns
```

Setting the DNS

```
nmcli connection modify 'NAME' ipv4.dns "8.8.8.8 1.1.1.1"
```

Reconnecting

```
nmcli connection down 'NAME'
```

```
nmcli connection up 'NAME'
```

## Virtual Machine

Checking if virtualization is enabled

```
grep -Ec '(vmx|svm)' /proc/cpuinfo
```

Installing necessary packages

```
sudo pacman -Syu virt-manager qemu-desktop dnsmasq iptables-nft
```

Enabling libvirtd service

```
sudo systemctl enable --now libvirtd.service
```

Adding the user to the libvirt group

```
sudo usermod -aG libvirt $env.USER
```

Restarting the libvirtd service

```
systemctl restart libvirtd.service
```
