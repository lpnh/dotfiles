#!/bin/bash

display_gtk_settings() {
    echo -e "\ncurrent GTK theme"
    echo "-----------------"
    echo "gtk-theme = $(gsettings get org.gnome.desktop.interface gtk-theme)"
    echo "icon-theme = $(gsettings get org.gnome.desktop.interface icon-theme)"
    echo "font-name = $(gsettings get org.gnome.desktop.interface font-name)"
    echo "cursor-theme = $(gsettings get org.gnome.desktop.interface cursor-theme)"
    echo "cursor-size = $(gsettings get org.gnome.desktop.interface cursor-size)"
    echo "color-scheme = $(gsettings get org.gnome.desktop.interface color-scheme)"
}

update_gtk_settings() {
    echo -e "\nupdating GTK theme..."

    gsettings set org.gnome.desktop.interface gtk-theme 'Materia-dark'
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
    gsettings set org.gnome.desktop.interface font-name 'Inter Medium 10.5'
    gsettings set org.gnome.desktop.interface cursor-theme 'Breeze'
    gsettings set org.gnome.desktop.interface cursor-size 24
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

    echo "done !"
}

display_gtk_settings

update_gtk_settings

display_gtk_settings
