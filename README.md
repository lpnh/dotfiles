# dotfiles

*simple and aesthetic*

## Usage

```sh
chezmoi init https://github.com/lpnh/dotfiles.git
```

```sh
chezmoi apply
```

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

## Besides me, who is the culprit for all these files?

### Environment

Wayland compositor: [Niri](https://github.com/YaLTeR/niri)

Notification daemon: [Dunst](https://github.com/dunst-project/dunst)

Status bar: [Waybar](https://github.com/Alexays/Waybar)

App launcher: [Fuzzel](https://codeberg.org/dnkl/fuzzel)

File manager: [Yazi](https://github.com/sxyazi/yazi)

Text editor: [Neovim](https://github.com/neovim/neovim)

Terminal: [Alacritty](https://github.com/alacritty/alacritty)

Shell: [Nushell](https://github.com/nushell/nushell)

Prompt: [Starship](https://github.com/starship/starship)

Theme: [Catppuccin](https://github.com/catppuccin/catppuccin)

Dotfile manager: [Chezmoi](https://github.com/twpayne/chezmoi)

### Utilities and Quality of Life

[Bat](https://github.com/sharkdp/bat): Cat clone with syntax highlighting and
git integration

[Fastfetch](https://github.com/fastfetch-cli/fastfetch): Like Neofetch, but
much faster because written in C

[Gitui](https://github.com/extrawurst/gitui): Blazing fast terminal-ui for git
written in Rust

[Glow](https://github.com/charmbracelet/glow): Command-line markdown renderer

[Ncspot](https://github.com/hrkfdn/ncspot): Cross-platform ncurses Spotify
client written in Rust, inspired by ncmpc and the likes

[Swaylock](https://github.com/swaywm/swaylock): Screen locker for Wayland

### Software I'm so grateful for that I feel compelled to acknowledge as well

[Bottom](https://github.com/ClementTsang/bottom): A graphical process/system
monitor

[Fzf](https://github.com/junegunn/fzf): Command-line fuzzy finder

[Ripgrep](https://github.com/BurntSushi/ripgrep): A search tool that combines
the usability of ag with the raw speed of grep

[Yay](https://github.com/Jguer/yay): Yet another yogurt. Pacman wrapper and AUR
helper written in go

[Zoxide](https://github.com/ajeetdsouza/zoxide): A smarter cd command for your
terminal
