#!/usr/bin/env fish

set output_name $argv[1]

while true
    sleep 1s

    niri msg --json workspaces \
    | jq -r ".[] | select(.output == \"$output_name\") | if .is_active then \"󰪥\" else \"󰄰\" end" \
    | string join " "
end
