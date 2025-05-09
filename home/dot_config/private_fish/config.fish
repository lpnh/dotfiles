# PATH
fish_add_path ~/.cargo/bin
fish_add_path ~/.fly/bin

# ENV
set -gx EDITOR nvim
set -gx RIPGREP_CONFIG_PATH ~/.config/ripgrep/config
set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml

# fzf mocha theme
set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#313244,spinner:#f5e0dc,hl:#cba6f7 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#cba6f7 \
--color=selected-bg:#45475a \
--multi"

# yazi z command opts
set -gx YAZI_ZOXIDE_OPTS "--no-border --no-scrollbar --info=hidden \
--preview='eza --color=always --group-directories-first --icons {2}'"

# zi fzf opts
set -gx _ZO_FZF_OPTS "\
--exact --no-sort --exit-0 --bind=ctrl-z:ignore,btab:up,tab:down \
--cycle --keep-right --height=45% --layout=reverse --tabstop=1 \
--preview-window=down $FZF_DEFAULT_OPTS $YAZI_ZOXIDE_OPTS"

# cursor style
set -gx fish_vi_force_cursor 1
set -gx fish_cursor_default block
set -gx fish_cursor_insert line blink
set -gx fish_cursor_visual block
set -gx fish_cursor_replace_one underscore

# vi bindings
set -g fish_key_bindings fish_vi_key_bindings

bind -M insert \cy accept-autosuggestion
bind -M insert \ef forward-word

# aliases & abbrs

# reflector
alias alice 'sudo reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist'

# bat
alias b 'bat --plain'
alias bl 'bat --plain --line-range'
alias bn 'bat --number'
alias bnl 'bat --number --line-range'

# bob
alias bu 'bob update nightly'

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
alias chz 'cd ~/andromeda/chezmoi'

# cargo
alias cargo-upgrade 'cargo +nightly -Zunstable-options update --breaking'

# journal
alias err 'journalctl -b -p err'

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

# jujutsu, or as I've recently taken to calling it, jujuba
alias ja 'jj abandon'
alias jd 'jj diff'
alias jde 'jj describe'
alias jdm 'jj describe -m'
alias je 'jj edit'
alias ji 'jj git init'
alias jl 'jj log'
alias jn 'jj new'
alias jst 'jj st'
alias jsq 'jj squash'
alias jsqi 'jj squash -i'

# ls
alias la 'ls -a'
alias ll 'ls -l'

# lazygit
alias lg lazygit

# neovim
alias nv nvim

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
alias yaa 'ya pack --add'
alias yad 'ya pack --delete'
alias yal 'ya pack --list'
alias yau 'ya pack --upgrade'

# yay
abbr yi 'yay -Qi'
abbr yl 'yay -Ql'
abbr yr 'yay -Rnsc'
abbr ys 'yay -Ss'

# zoxide
alias zz 'zi'

# date and time
alias dt 'notify-send -t 1800 coucou \n(date "+%A %d")'
alias hr 'notify-send -t 1800 coucou \n(date +%R)'

# the enthusiasm level determines the scope
function yay!
    yay --noconfirm
    bob update nightly
end

function yay!!
    rustup update
    cargo install-update --all
    tldr --update
end

# external setups
starship init fish | source
zoxide init fish | source
