# Partitions

## Inside the Live Environment

- [ ] Improve the default font size: `setfont ter-222b`
- [ ] Make sure the system is booted in UEFI mode:
```sh
# the output should be 64
cat /sys/firmware/efi/fw_platform_size
```
- [ ] Check the internet connection: `ping archlinux.org`
- [ ] Ensure the system clock is synchronized: `timedatectl`

## Partitioning the Disk

- [ ] Identify available disks: `lsblk -o NAME,SIZE`
- [ ] Create the partitions:
```sh
cfdisk /dev/the_disk_to_be_partitioned
```
| Purpose        | Suggested size | Partition type   | Mount point |
|:---------------|:---------------|:-----------------|:------------|
| efi            | 1 GiB          | EFI System       | /efi        |
| swap           | 8 GiB          | Linux filesystem | [SWAP]      |
| root           | Remainder      | Linux filesystem | /           |
- [ ] Verify the partitions: `fdisk -l /dev/partitioned_disk`

## Formatting the Partitions

- [ ] Create an *Ext4* fs for the **root**: `mkfs.ext4 /dev/root_partition`
- [ ] Initialize the *swap*: `mkswap /dev/swap_partition`
- [ ] Format the `efi` to FAT32: `mkfs.fat -F 32 /dev/efi_system_partition`
- [ ] Add a label to the efi partition: 
```sh
dosfslabel /dev/efi_system_partition ARCHIE
```
- [ ] Verify the result: `lsblk /dev/partioned_disk -o NAME,FSTYPE,LABEL`

## Mounting the File System

- [ ] The root partition to `/mnt`: `mount /dev/root_partition /mnt`
- [ ] The EFI partition to `/mnt/efi`: `mount --mkdir /dev/efi_system_partition /mnt/efi`
- [ ] Enable the `swap`: `swapon /dev/swap_partition`
