# https://yazi-rs.github.io/docs/quick-start#shell-wrapper
def --env ya [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}

# The level of enthusiasm determines the scope of the update
def yay! [] {
    yay --noconfirm
    bob update nightly
}

def yay!! [] {
    yay --noconfirm
    rustup update
    cargo install-update --all
    sudo npm update --global
    tldr --update
    bob update nightly
}
