# PATH
fish_add_path ~/.cargo/bin
fish_add_path ~/.npm-global/bin
fish_add_path ~/.fly/bin
fish_add_path ~/.local/bin # required by `pipx` x.x

# ENV
set -gx DFT_COLOR always
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

# \o/
function yay!
    yay --noconfirm
end

# external setups
starship init fish | source
zoxide init fish | source
