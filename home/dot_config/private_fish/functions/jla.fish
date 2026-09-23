function jla -a depth -d "jj: log ancestors"
    if test (count $argv) -gt 1
        echo "usage: jla [depth]" >&2
        return 1
    end

    if test -z $depth
        set depth 10
    else if not test $depth -ge 1 2>/dev/null
        echo "usage: jla [depth]" >&2
        return 1
    end

    jj log -r "ancestors(@, $depth)"
end
