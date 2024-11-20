# Miscellaneous

## Profile-sync-daemon

<div class="warning">
I haven't had much luck with this so far.

I've tried it twice, and Firefox became very unstable.
</div>

Edit the *sudoers* adding the necessary rights to the end of the file

```bash
EDITOR=nvim sudo visudo
```

```txt
lpnh ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper
```

Check *psd* current status

```bash
psd preview
```

Enable the *psd* service

```bash
systemctl --user enable psd.service
```

## NetworkManager

### Wi-Fi Connection

Get the list of available Wi-Fi networks

```bash
nmcli device wifi list
```

Connect to a Wi-Fi

```bash
nmcli device wifi connect <SSID_or_BSSID> password <password>
```

### Update the DNS

Get the list of the current active profiles

```bash
nmcli connection show --active
```

Check the current DNS values

```bash
nmcli connection show 'NAME' | rg dns
```

Update the DNS

```bash
nmcli connection modify 'NAME' ipv4.dns "8.8.8.8 1.1.1.1"
```

Reconnect

```bash
nmcli connection down 'NAME'
```

```bash
nmcli connection up 'NAME'
```

## Rust

### Toolchains

Install the `nightly` channel

```bash
rustup toolchain install nightly
```

Check the installed toolchains

```bash
rustup toolchain list
```

### Targets

Include support for the `Wasm` target

```bash
rustup target add wasm32-unknown-unknown
```

Check the installed targets

```bash
rustup target list --installed
```

## Virtual Machine

Check the hardware virtualization support

```bash
# the output should be > 0
grep -Ec '(vmx|svm)' /proc/cpuinfo
```

<div class="warning">
Make sure the virtualization is enabled in the BIOS

For AMD, look for the SVM option
For Intel, look for the VMX option
</div>

Install necessary packages

```bash
sudo pacman -Syu virt-manager qemu-desktop dnsmasq iptables-nft
```

Enable *libvirtd* service

```bash
sudo systemctl enable --now libvirtd.service
```

Add the user to the *libvirt* group

```bash
sudo usermod -aG libvirt $env.USER
```

Restart the service

```bash
systemctl restart libvirtd.service
```
