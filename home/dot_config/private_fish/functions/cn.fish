function cn
    set repo $argv
    cargo new $repo --vcs=none
    builtin cd $repo
    echo "/target" >> .gitignore
    jj git init
end
