#!/usr/bin/env fish

while true
    sleep 1s

    niri msg --json focused-window \
        | jq -c 'if type != "object" then { "text": "", "tooltip": "" } else { "text": .app_id, "tooltip": "\(.app_id): \(.title)" } end'
end
