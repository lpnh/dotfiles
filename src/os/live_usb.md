# Live USB

## Creating a bootable USB containing the ISO

- [ ] Download the ISO file from the [Arch Linux website](https://archlinux.org/download/)

- [ ] Find the USB drive name

```bash
ls -l /dev/disk/by-id/usb-*
```

- [ ] Make sure it is **not** mounted (the MOUNTPOINTS column should be empty)

```bash
lsblk
```

- [ ] Write the ISO to the USB drive using `pv`

```bash
sudo pv path/to/archlinux-version-x86_64.iso -Yo /dev/disk/by-id/usb-My_flash_drive-0:0
```

## Notes

- The BitTorrent Download is the recommended option and the file will look
like this: `archlinux-version-x86_64.iso.torrent`

- The USB drive name should look something like
`/dev/disk/by-id/usb-SanDisk_Cruzer_Blade_4C530000100920118104-0:0`. Make sure
to **not** append any partition like *-part1*
