# Live USB

- [ ] [Download the ISO file](https://archlinux.org/download/)
- [ ] Find the USB drive name: `ls -l /dev/disk/by-id/usb-*`
- [ ] Make sure it is **not** mounted: `lsblk`
- [ ] Write the ISO to the USB drive:
```sh
sudo pv path/to/archlinux-version-x86_64.iso -Yo /dev/disk/by-id/usb-My_flash_drive-0:0
```
