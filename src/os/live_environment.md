# Live Environment

## Console Configuration

### Font

First of all, improve the default font size using `setfont`:

```sh
setfont ter-222b
```

### Keyboard

To change the default keyboard layout:

```sh
# for example, to set a brazilian keyboard layout
loadkeys br-abnt2
```

## Some Verification

### UEFI Mode

To make sure the system is booted in UEFI mode, check the output of the
following command. It should return `64`, for a 64-bit system:

```sh
cat /sys/firmware/efi/fw_platform_size
```

### Internet Connection

To check the internet connection:

```sh
ping archlinux.org
```

### System Clock

To ensure the system clock is synchronized, run:

```sh
timedatectl
```
