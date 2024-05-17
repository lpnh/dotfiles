print "\n\u{f08d0} bonjour!\n"

sleep 1sec

print "\u{f00e2} removing old repo"

rm -rf ~/apps/niri

print "\u{f01c5} cloning niri repo"

git clone --quiet git@github.com:YaLTeR/niri.git ~/apps/niri

print "\n\u{eae8} building... this may take a while"

cargo build --quiet --release --manifest-path ~/apps/niri/Cargo.toml 

if (which niri | is-not-empty) {
    print "\n\u{eb32} current version:"
    niri --version
} else {
    print "niri binary not found"
}

print "\n\u{f00e2} removing old bin"

sudo rm /usr/bin/niri

print "\u{f06d3} adding new bin"

sudo mv ~/apps/niri/target/release/niri /usr/bin/niri

print "\n\u{f0a43} checking new version:"

niri --version

print "\n\u{f06d3} moving all the remaining files"

# add niri-session
sudo mv -f ~/apps/niri/resources/niri-session /usr/bin/

# add niri-desktop
sudo mv -f ~/apps/niri/resources/niri.desktop /usr/share/wayland-sessions/

# add niri-portals
sudo mv -f ~/apps/niri/resources/niri-portals.conf /usr/share/xdg-desktop-portal/

# add niri-service
sudo mv -f ~/apps/niri/resources/niri.service /usr/lib/systemd/user/

# add niri-shutdown
sudo mv -f ~/apps/niri/resources/niri-shutdown.target /usr/lib/systemd/user/

print "\n\u{f0674} voilà"
