# Miscellaneous

## Profile-sync-daemon

To generate the configuration file and check the current status:

```bash
psd preview
```

To edit the **sudoers** adding the necessary rights

```bash
sudo visudo
```

```txt
<username> ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper
```

To edit the **psd.conf** configuration file:

```bash
sudo nvim .config/psd/psd.conf
```
```txt
# Uncomment and set to "yes" to use overlayfs instead of a full copy to reduce
# the memory costs and to improve sync/unsync operations. Note that your kernel
# MUST have this module available in order to use this mode.
#
USE_OVERLAYFS="yes"
```
```txt
#
BROWSERS=(firefox)
```

To enable the **psd** service:

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

To get the list of the current active profiles:

```bash
nmcli connection show --active
```

To check the current DNS values

```bash
nmcli connection show 'NAME' | rg dns
```

To update the DNS:

```bash
nmcli connection modify 'NAME' ipv4.dns "8.8.8.8 1.1.1.1"
```

To reconnect:

```bash
nmcli connection down 'NAME'
```
```bash
nmcli connection up 'NAME'
```

## Tlp

To enable the service:

```bash
systemctl enable tlp.service
```

To mask the **rfkill**:

```bash
systemctl mask systemd-rfkill.service
```
```bash
systemctl mask systemd-rfkill.socket
```

## Virtual Machine

To check if virtualization is enabled:

```bash
grep -Ec '(vmx|svm)' /proc/cpuinfo
```

To install necessary packages:

```bash
sudo pacman -Syu virt-manager qemu-desktop dnsmasq iptables-nft
```

To enable **libvirtd** service:

```bash
sudo systemctl enable --now libvirtd.service
```

To add the user to the **libvirt** group:

```bash
sudo usermod -aG libvirt $env.USER
```

To restart the service:

```bash
systemctl restart libvirtd.service
```
