# bat
alias b = bat
alias bn = bat --number
alias bnl = bat --number --line-range
alias bp = bat --plain
alias bpl = bat --plain --line-range
alias bl = bat --line-range

# cargo
alias cwr = cargo watch -qcx run

# chezmoi
alias ch = chezmoi
alias chad = chezmoi add
alias chap = chezmoi apply --verbose
alias chdi = chezmoi diff
alias chda = chezmoi data
alias ched = chezmoi edit
alias chst = chezmoi status
alias chup = chezmoi update --verbose
alias chz = chezmoi cd

# eza
alias x = eza --icons --oneline
alias xx = eza --icons
alias xa = eza --icons --all --oneline
alias xxa = eza --icons --all
alias xl = eza --long
alias xla = eza --long --all
alias xt = eza --icons --tree
alias xta = eza --icons --tree --all

# git
alias ga = git add --all
alias gad = git add
alias gc = git commit --verbose
alias gc! = git commit --verbose --amend
alias gcn = git commit --verbose --no-edit
alias gcn! = git commit --verbose --no-edit --amend
alias gcm = git commit --message
alias gco = git checkout
alias gcb = git checkout -b
alias gd = git diff
alias gdca = git diff --cached
alias gds = git diff --staged
alias gl = git log
alias glo = git log --oneline --decorate
alias gp = git push
alias gpf! = git push --force
alias gr = git remote
alias grm = git rm
alias grmc = git rm --cached
alias gst = git status

# ls
alias la = ls -a
alias ll = ls -l

# neovim
alias nv = nvim
