function wd
    sdcv -c -e -n -u 'WordNet® 3.0 (En-En)' $argv | rg -v '^(Found|-->|^$)' | bat --style plain
end
