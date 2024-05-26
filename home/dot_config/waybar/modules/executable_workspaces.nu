#!/usr/bin/nu

def main [output_name] {
  loop {
    sleep 200ms

    let text = niri msg -j workspaces
      | from json
      | each { |ws| if $ws.output == $output_name { if $ws.is_active { "󰪥" } else { "󰄰" } } }
      | str join " "

    print $text
  }
}
