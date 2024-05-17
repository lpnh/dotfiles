print "\n\u{f08d0} bonjour!\n"

sleep 1sec

print "\u{f00e2} removing old repo"

rm -rf ~/apps/yazi

print "\u{f01c5} cloning yazi repo"

git clone --quiet https://github.com/sxyazi/yazi.git ~/apps/yazi

print "\n\u{eae8} building... this may take a while"

cargo build --quiet --release --manifest-path ~/apps/yazi/Cargo.toml 

if (which yazi | is-not-empty) {
    print "\n\u{eb32} current version:"
    yazi --version
} else {
    print "yazi binary not found"
}

print "\n\u{f00e2} removing old bin"

sudo rm --force /usr/bin/yazi 

print "\u{f06d3} adding new bin"

sudo mv ~/apps/yazi/target/release/yazi /usr/bin/yazi

print "\n\u{f0a43} checking new version:"

yazi --version

print "\n\u{f0674} voilà"
