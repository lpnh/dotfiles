#!/usr/bin/nu

let out = {
  text: "",
  tooltip: ""
}

def main [] {
  loop {
    sleep 100ms

    let window = niri msg -j focused-window | from json

    if ($window == null) {
      print ($out | to json -r)
    } else {
      let title = $window | get title
      let app_id = $window | get app_id
      let tooltip = $"($title) | ($app_id)"

      print ($out | update text $title | update tooltip $tooltip | to json -r)
    }
  }
}
