function yolo
    set -l commands \
        "rustup update" \
        "cargo install-update --all --locked" \
        "ya pkg upgrade" \
        "tldr --update"

    set -l green (set_color green)
    set -l red (set_color red)
    set -l reset (set_color normal)
    set -l failed_commands

    for cmd in $commands
        if not eval $cmd
            set -a failed_commands "$cmd"
        end
        echo
    end

    echo

    if test (count $failed_commands) -eq 0
        echo $green"✨ やった!"$reset
    else
        echo $red"Manual intervetion required for the following command(s):"$reset
        for failed in $failed_commands
            echo "  ✗ $failed"
        end
    end
end
