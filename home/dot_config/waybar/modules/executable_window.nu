#!/usr/bin/nu

let out = {
  text: "",
  tooltip: ""
}

def main [] {
  loop {
    sleep 200ms;

    let window = niri msg -j focused-window | from json;

    if ($window == null) {
      print ($out | to json -r);
    } else {
      let app_id = $window | get app_id;
      let title = $window | get title;
      let tooltip = $"($app_id) | ($title)";

      print ( $out | update text ( $"($app_id)" ) | update tooltip ( $"($tooltip)") | to json -r );
    }
  }
}
