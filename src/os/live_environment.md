# Live Environment

- [ ] Improve the default font size

```bash
setfont ter-222b
```

- [ ] Change the default keyboard layout (US), if necessary

```bash
# for example, to set a brazilian keyboard layout
loadkeys br-abnt2
```

- [ ] Make sure the system is booted in UEFI mode

```sh
# the output should be 64 for 64-bit system
cat /sys/firmware/efi/fw_platform_size
```

- [ ] Connect to the internet
 
*For ethernet, just plug in the cable.*
*For wifi, run `iwctl` and then in the interactive prompt:*

```bash
# this command will not output anything
station wlan0 scan
```

```bash
station wlan0 get-networks
```

```bash
station wlan0 connect "SSID"
```

```bash
station wlan0 show
```

```bash
# Ctrl+d works too
exit
```

- [ ] Check the internet connection

```bash
ping archlinux.org
```

- [ ] Ensure the system clock is synchronized

```sh
timedatectl
```

## Notes

- You can check the available keyboard layouts running `localectl list-keymaps`
