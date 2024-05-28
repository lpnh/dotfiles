#!/usr/bin/nu

let out = {
  text: "",
  tooltip: ""
}

loop {
  sleep 100ms

  let fw = niri msg -j focused-window | from json

  print (
    $out
    | try { update text $fw.title | update tooltip $"($fw.title) | ($fw.app_id)" }
    | to json -r
  )
}
