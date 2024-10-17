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
 
*For ethernet, just plug in the cable*

<details open>
  <summary>
    <i>For wifi, use <b>iwctl</b> interactive prompt</i>
  </summary>

```bash
iwctl
```

```bash
# this command will not output anything
station wlan0 scan
```

```bash
# check the available networks
station wlan0 get-networks
```

```bash
# connect
station wlan0 connect "SSID"
```

```bash
# check the connection
station wlan0 show
```

```bash
# Ctrl+d works too
exit
```

</details>

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
