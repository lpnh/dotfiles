function jump -a bookmark -d "jj: update, move, and push"
    if test (count $argv) -ne 1
        echo "missing bookmark name:" >&2
        jj bookmark list >&2
        return 1
    end
    jj bookmark move $bookmark; or return 1
    jj new; or return 1
    jj git push
end
