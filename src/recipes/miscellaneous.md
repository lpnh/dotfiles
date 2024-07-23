# Miscellaneous

## Profile-sync-daemon

- [ ] Generate the configuration file and check the current status:
```sh
psd preview
```
- [ ] Edit the **sudoers** adding the necessary rights
```sh
sudo visudo
```
```txt
<username> ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper
```
- [ ] Edit the **psd.conf** configuration file:
```sh
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
- [ ] Enable the **psd** service:
```sh
systemctl --user enable psd.service
```

## NetworkManager

### Wi-Fi Connection

- [ ] Get the list of available Wi-Fi networks
```sh
nmcli device wifi list
```
- [ ] Connect to a Wi-Fi
```sh
nmcli device wifi connect <SSID_or_BSSID> password <password>
```

### Update the DNS

- [ ] Get the list of the current active profiles:
```sh
nmcli connection show --active
```
- [ ] Check the current DNS values
```sh
nmcli connection show 'NAME' | rg dns
```
- [ ] Update the DNS:
```sh
nmcli connection modify 'NAME' ipv4.dns "8.8.8.8 1.1.1.1"
```
- [ ] Reconnect:
```sh
nmcli connection down 'NAME'
```
```sh
nmcli connection up 'NAME'
```

## Tlp

- [ ] Enable the service:
```sh
systemctl enable tlp.service
```
- [ ] Mask the **rfkill**:
```sh
systemctl mask systemd-rfkill.service
```
```sh
systemctl mask systemd-rfkill.socket
```

## Virtual Machine

- [ ] Check if virtualization is enabled:
```sh
grep -Ec '(vmx|svm)' /proc/cpuinfo
```
- [ ] Install necessary packages:
```sh
sudo pacman -Syu virt-manager qemu-desktop dnsmasq iptables-nft
```
- [ ] Enable **libvirtd** service:
```sh
sudo systemctl enable --now libvirtd.service
```
- [ ] Adding the user to the **libvirt** group:
```sh
sudo usermod -aG libvirt $env.USER
```
- [ ] Restarting the libvirtd service:
```sh
systemctl restart libvirtd.service
```
