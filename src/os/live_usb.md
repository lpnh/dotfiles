# Live USB

The steps to create a bootable USB containing the Arch Linux ISO.

## Download the ISO

Download the ISO file from <https://archlinux.org/download/>.

Note: the BitTorrent Download is the recommended option and the file will look
like this `archlinux-version-x86_64.iso.torrent`.

## USB Drive Name

Find out the name of your USB drive:

```sh
ls -l /dev/disk/by-id/usb-*
```

To make sure it is **not** mounted, run `lsblk` and search for the MOUNTPOINTS
column, you should see an empty space:

```sh
lsblk
```

## Write the ISO

Write the ISO to the USB drive using `pv`:

```sh
sudo pv path/to/archlinux-version-x86_64.iso -Yo /dev/disk/by-id/usb-My_flash_drive-0:0
```

Note: the USB drive name should look something like
`/dev/disk/by-id/usb-SanDisk_Cruzer_Blade_4C530000100920118104-0:0`.  
Make sure to **not** append any partition like *-part1*.

For more information about this topic, check the [Arch Linux
wiki](https://wiki.archlinux.org/title/USB_flash_installation_medium)
