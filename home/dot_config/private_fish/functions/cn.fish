function cn
    set repo $argv
    cargo new $repo --vcs=none
    builtin cd $repo
    echo "/target" >> .gitignore
    echo "# $repo" >> README.md
    jj git init
    jj bookmark create main
    jj describe -m "init"
end
