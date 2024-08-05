# cursor style
set -gx fish_vi_force_cursor 1
set -gx fish_cursor_default block
set -gx fish_cursor_insert line blink
set -gx fish_cursor_visual block
set -gx fish_cursor_replace_one underscore

# vi bindings
set -g fish_key_bindings fish_vi_key_bindings

# aliases

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
alias chz 'chezmoi cd'

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
alias gr 'git remote --verbose'
alias grm 'git rm'
alias grmc 'git rm --cached'
alias gst 'git status'

# ls
alias la 'ls -a'
alias ll 'ls -l'

# neovim
alias nv nvim

# sudo
alias please sudo

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

# the enthusiasm level determines the scope
function yay!
    yay --noconfirm
    bob update nightly
end

function yay!!
    yay --noconfirm
    rustup update
    cargo install-update --all
    tldr --update
    bob update nightly
end

# external setups
starship init fish | source
zoxide init fish | source
