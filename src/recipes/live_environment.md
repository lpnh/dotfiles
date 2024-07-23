# Live Environment

## Console Configuration

- [ ] Improve the default font size: `setfont ter-222b`
- [ ] Change the default keyboard layout, if necessary:
```sh
# for example, to set a brazilian keyboard layout
loadkeys br-abnt2
```
- [ ] Make sure the system is booted in UEFI mode:
```sh
# the output should be 64 for 64-bit system
cat /sys/firmware/efi/fw_platform_size
```
- [ ] Check the internet connection: `ping archlinux.org`
- [ ] Ensure the system clock is synchronized: `timedatectl`
