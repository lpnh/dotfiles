# PATH
fish_add_path ~/.cargo/bin
fish_add_path ~/.fly/bin

# ENV
set -gx EDITOR nvim
set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml

# fzf mocha theme
set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

# cursor style
set -gx fish_vi_force_cursor 1
set -gx fish_cursor_default block
set -gx fish_cursor_insert line blink
set -gx fish_cursor_visual block
set -gx fish_cursor_replace_one underscore

# vi bindings
set -g fish_key_bindings fish_vi_key_bindings

bind -M insert \cy accept-autosuggestion

# aliases

# aurv
alias aurv 'fd --threads=1 --type file PKGBUILD /home/aurv/ --exec makepkg --config /home/aurv/custom-makepkg.conf --dir {//} -si --noconfirm --needed'

# bat
alias b bat
alias bl 'bat --line-range'
alias bn 'bat --number'
alias bnl 'bat --number --line-range'
alias bp 'bat --plain'
alias bpl 'bat --plain --line-range'

# chezmoi
alias ch chezmoi
alias chad 'chezmoi add'
alias chap 'chezmoi apply'
alias chdi 'chezmoi diff'
alias chda 'chezmoi data'
alias ched 'chezmoi edit'
alias chma 'chezmoi managed'
alias chre 'chezmoi re-add --verbose'
alias chst 'chezmoi status'
alias chup 'chezmoi update --verbose'
alias chz 'cd ~/.local/share/chezmoi'

# cargo
alias cwc 'cargo watch -qcx clippy'
alias cwr 'cargo watch -qcx run'
alias cargo-upgrade 'cargo +nightly -Zunstable-options update --breaking'

# git
alias ga 'git add --all'
alias gad 'git add'
alias gb 'git branch'
alias gbl 'git branch --list'
alias gc 'git commit --verbose'
alias gc! 'git commit --verbose --amend'
alias gcn 'git commit --verbose --no-edit'
alias gcn! 'git commit --verbose --no-edit --amend'
alias gcm 'git commit --message'
alias gco 'git checkout'
alias gcb 'git checkout -b'
alias gd 'git diff'
alias gdca 'git diff --cached'
alias gds 'git diff --staged'
alias gl 'git log'
alias glo 'git log --oneline --decorate'
alias gp 'git push'
alias gpf! 'git push --force'
alias grm 'git rm'
alias grmc 'git rm --cached'
alias grv 'git remote --verbose'
alias gst 'git status'

# ls
alias la 'ls -a'
alias ll 'ls -l'

# neovim
alias nv nvim

# sudo
alias please sudo

# reflector
alias reflexo 'sudo reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist'

# eza
alias x 'eza --color=always --group-directories-first --icons --oneline'
alias xx 'eza --color=always --group-directories-first --icons'
alias xa 'eza --color=always --group-directories-first --icons --all --oneline'
alias xxa 'eza --color=always --group-directories-first --icons --all'
alias xl 'eza --color=always --group-directories-first --long'
alias xla 'eza --color=always --group-directories-first --long --all'
alias xt 'eza --color=always --group-directories-first --icons --tree'
alias xta 'eza --color=always --group-directories-first --icons --tree --all'

# ya
alias yi 'ya pack --install'
alias yl 'ya pack --list'
alias yu 'ya pack --upgrade'

# yay
abbr yayl 'yay -Ql'
abbr yayq 'yay -Qi'
abbr yayr 'yay -Rns'
abbr yays 'yay -Ss'

# the enthusiasm level determines the scope
function yay!
    yay --noconfirm
    aurv
    bob update nightly
end

function yay!!
    yay --noconfirm
    rustup update
    cargo install-update --all
    tldr --update
    aurv
    bob update nightly
end

# external setups
starship init fish | source
zoxide init fish | source
