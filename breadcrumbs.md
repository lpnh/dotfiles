# Breadcrumbs

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

## Ly

Enabling the service

```
systemctl enable ly.service
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

## Neovim

Installing neovim npm package

```
sudo npm install -g neovim
```
