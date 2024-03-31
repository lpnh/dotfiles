#!/bin/sh

# packages.txt hash: {{ include ~/.config/packages.txt | sha256sum }}
yay -S --needed --noconfirm $(cat ~/.config/packages.txt)
