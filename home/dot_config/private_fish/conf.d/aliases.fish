# function to edit the aliases file without alias warnings
function aliased --description 'edit conf.d/aliases.fish'
    # when executing `aliased`, the file will be opened without alias warnings
    set -lx fish_lsp_diagnostic_disable_error_codes 2001 2002
    $EDITOR ~/.config/fish/conf.d/aliases.fish

    fish --no-execute ~/.config/fish/conf.d/aliases.fish
    and source ~/.config/fish/conf.d/aliases.fish

    if test $status -eq 0
        set_color green --bold && echo -n 'SUCCESS: ' && set_color normal
        echo "~/.config/fish/conf.d/aliases.fish sourced"
    else
        set_color red --bold && echo -n 'ERROR: ' && set_color normal
        echo "~/.config/fish/conf.d/aliases.fish not sourced"
    end
end

# exit
alias :q 'exit'

# reflector
alias alice 'sudo reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist'

# bat
alias b 'bat --plain'
alias ba 'bat --plain --show-all'
alias bl 'bat --plain --line-range'
alias bn 'bat --number'
alias bnl 'bat --number --line-range'

# bob
alias bun 'bob update nightly'

# cargo
alias cdo 'cargo doc --open'
alias cq 'cargo test --no-fail-fast --quiet'
alias cargo-upgrade 'cargo +nightly -Zunstable-options update --breaking'

# chezmoi
alias ch chezmoi
alias chad 'chezmoi add'
alias chap 'chezmoi apply'
alias chdi 'chezmoi diff --reverse'
alias chda 'chezmoi data'
alias ched 'chezmoi edit'
alias chma 'chezmoi managed'
alias chre 'chezmoi re-add --verbose'
alias chst 'chezmoi status'
alias chup 'chezmoi update --verbose'
alias chz 'cd ~/tori/chezmoi'

# criterion
alias opc 'open target/criterion/report/index.html'

# date
alias cv 'date +%y.%-m.%-d'

# difftastic
alias d difft

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
alias gdn 'git diff --no-ext-diff'
alias gdca 'git diff --cached'
alias gds 'git diff --staged'
alias gdsn 'git diff --staged --no-ext-diff'
alias gl 'git log -p --ext-diff'
alias glo 'git log --oneline --decorate'
alias gp 'git push'
alias gpf! 'git push --force'
alias grm 'git rm'
alias grmc 'git rm --cached'
alias grv 'git remote --verbose'
alias gs 'git show --ext-diff'
alias gst 'git status'

# insta
alias ic 'cargo insta test --check'
alias ir 'cargo insta test --review'

# just
alias j just

# jujutsu, or as I've recently taken to calling it, jujuba
alias ja 'jj abandon'
alias jb 'jj bookmark'
alias jbl 'jj bookmark list'
alias jbm 'jj bookmark move'
alias jd 'jj diff'
alias jde 'jj describe'
alias jdm 'jj describe -m'
alias je 'jj edit'
alias jev 'jj evolog'
alias jgr 'jj git remote list'
alias jgra 'jj git remote add'
alias ji 'jj git init'
alias jl 'jj log'
alias jn 'jj new'
alias jp 'jj git push'
alias jst 'jj status'
alias jsq 'jj squash'
alias jsqi 'jj squash -i'
alias ju 'jj undo'

# ls
alias la 'ls -a'
alias ll 'ls -l'

# lazygit
alias lg lazygit

# neovim
alias nv nvim

# qalc
alias qc qalc

# rust
alias rustf 'rustfmt +nightly src/**/*.rs --edition 2024'

# tree-sitter
alias tg 'tree-sitter generate'
alias tp 'tree-sitter parse'
alias tt 'tree-sitter test'

# eza
alias x 'eza --color=always --group-directories-first --icons --oneline'
alias xx 'eza --color=always --group-directories-first --icons'
alias xa 'eza --color=always --group-directories-first --icons --all --oneline'
alias xxa 'eza --color=always --group-directories-first --icons --all'
alias xl 'eza --color=always --group-directories-first --long --total-size'
alias xla 'eza --color=always --group-directories-first --long --all'
alias xt 'eza --color=always --group-directories-first --icons --tree'
alias xta 'eza --color=always --group-directories-first --icons --tree --all'

# ya
alias yza 'ya pkg add'
alias yzd 'ya pkg delete'
alias yzl 'ya pkg list'
alias yzu 'ya pkg upgrade'

# yazi nightly
alias yn yazi-nightly

# zoxide
alias zz zi
