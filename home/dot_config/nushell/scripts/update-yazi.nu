echo "\n\u{f08d0} bonjour!\n"

sleep 1sec

echo "\u{f00e2} removing old yazi repo"

rm -rf ~/apps/yazi

echo "\u{f01c5} cloning yazi repo"

git clone --quiet https://github.com/sxyazi/yazi.git ~/apps/yazi

echo "\n\u{eae8} building release... this may take a while"

cargo build --quiet --release --manifest-path ~/apps/yazi/Cargo.toml 

if (which yazi | is-not-empty) {
    echo "\n\u{eb32} current version:"
    yazi --version
} else {
    echo "yazi binary not found"
}

echo "\n\u{f00e2} removing old bin"

sudo rm --force /usr/bin/yazi 

echo "\u{f06d3} adding new bin"

sudo mv ~/apps/yazi/target/release/yazi /usr/bin/yazi

echo "\n\u{f0a43} checking new version:"

yazi --version

echo "\n\u{f0674} voilà"
