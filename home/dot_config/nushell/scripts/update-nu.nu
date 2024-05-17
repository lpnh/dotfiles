print "\n\u{f08d0} bonjour!\n"

sleep 1sec

print "\u{f00e2} removing old repo"

rm -rf ~/apps/nushell

print "\u{f01c5} cloning nushell repo"

git clone --quiet https://github.com/nushell/nushell.git ~/apps/nushell

print "\n\u{eae8} building... this may take a while\n"

cargo build --quiet --release --manifest-path ~/apps/nushell/Cargo.toml

if (which nu | is-not-empty) {
    print "\n\u{eb32} current version:"
    nu --version
} else {
    print "nushell binary not found"
}

print "\n\u{f00e2} removing old bin"

sudo rm --force /usr/bin/nu 

print "\n\u{f06d3} adding new bin"

sudo mv ~/apps/nushell/target/release/nu /usr/bin/nu

print "\u{f0a43} checking new current version:"

nu --version

print "\n\u{f0674} voilà"
