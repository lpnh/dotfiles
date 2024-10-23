# Miscellaneous

## Profile-sync-daemon

- [ ] Edit the *sudoers* adding the necessary rights

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

- [ ] Enable the *psd* service

```bash
systemctl --user enable psd.service
```

## NetworkManager

### Wi-Fi Connection

To get the list of available Wi-Fi networks

```bash
nmcli device wifi list
```

To connect to a Wi-Fi

```bash
nmcli device wifi connect <SSID_or_BSSID> password <password>
```

### Update the DNS

To get the list of the current active profiles

```bash
nmcli connection show --active
```

To check the current DNS values

```bash
nmcli connection show 'NAME' | rg dns
```

To update the DNS

```bash
nmcli connection modify 'NAME' ipv4.dns "8.8.8.8 1.1.1.1"
```

To reconnect

```bash
nmcli connection down 'NAME'
```
```bash
nmcli connection up 'NAME'
```

## Virtual Machine

To check if virtualization is enabled

```bash
grep -Ec '(vmx|svm)' /proc/cpuinfo
```

To install necessary packages

```bash
sudo pacman -Syu virt-manager qemu-desktop dnsmasq iptables-nft
```

To enable **libvirtd** service

```bash
sudo systemctl enable --now libvirtd.service
```

To add the user to the **libvirt** group

```bash
sudo usermod -aG libvirt $env.USER
```

To restart the service

```bash
systemctl restart libvirtd.service
```
