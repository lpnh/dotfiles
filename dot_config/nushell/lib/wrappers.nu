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
