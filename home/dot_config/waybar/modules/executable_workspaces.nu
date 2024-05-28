#!/usr/bin/nu

def main [output_name] {
  loop {
    sleep 1sec

    print (
      niri msg -j workspaces
        | from json
        | where output == $output_name
        | each {|ws| if $ws.is_active { '󰪥' } else { '󰄰' } }
        | str join " "
    )
  }
}
