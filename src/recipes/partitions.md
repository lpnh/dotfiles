# Partitions

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
- [ ] Initialize the **swap**: `mkswap /dev/swap_partition`
- [ ] Format the **efi** to *FAT32*: `mkfs.fat -F 32 /dev/efi_system_partition`
- [ ] Add a label to the **efi** partition:
```sh
dosfslabel /dev/efi_system_partition ARCHIE
```
- [ ] Verify the result: `lsblk /dev/partioned_disk -o NAME,FSTYPE,LABEL`

## Mounting the File System

- [ ] Mount the **root** partition to **/mnt**: `mount /dev/root_partition /mnt`
- [ ] Mount the **efi** partition to **/mnt/efi**: `mount --mkdir
/dev/efi_system_partition /mnt/efi`
- [ ] Enable the **swap**: `swapon /dev/swap_partition`
