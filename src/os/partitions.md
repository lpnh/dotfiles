# Partitions

- [ ] Identify available disks

```bash
# rom, loop or airootfs may be ignore
lsblk -o NAME,SIZE
```

<div class="warning">
Always make sure to identify and select the correct device.
Otherwise, the following steps may result in unintended data loss.
</div>

*The next step is for NVMe drives only.*

- [ ] Check the formatted logical block address (LBA) size

```bash
nvme id-ns -H /dev/nvme0n1 | grep "Relative Performance"
```

On the output example below the sector size in use (512 bytes) is **not** the
optimal one:

```txt
LBA Format  0 : Metadata Size: 0   bytes - Data Size: 512 bytes - Relative Performance: 0x2 Good (in use)
LBA Format  1 : Metadata Size: 0   bytes - Data Size: 4096 bytes - Relative Performance: 0x1 Better
```

You can confirm it by running `lsblk -td` and looking at the `LOG-SEC` column value.

To change the logical block address size, you can use the `nvme format` command
specifying the preferred value with the `--lbaf` parameter:

```bash
nvme format --lbaf=1 /dev/nvme0n1
```

- [ ] Create the partitions

```bash
cfdisk /dev/the_disk_to_be_partitioned
```

| Purpose        | Suggested size | Partition type   | Mount point |
|:---------------|:---------------|:-----------------|:------------|
| efi            | 1 GiB          | EFI System       | /efi        |
| swap           | 8 GiB          | Linux filesystem | [SWAP]      |
| root           | Remainder      | Linux filesystem | /           |

- [ ] Verify the partitions

```bash
fdisk -l /dev/partitioned_disk
```

- [ ] Create an *Ext4* fs for the **root**

```bash
mkfs.ext4 /dev/root_partition
```

- [ ] Initialize the **swap**

```bash
mkswap /dev/swap_partition
```

- [ ] Format the **efi** to *FAT32*

```bash
mkfs.fat -F 32 /dev/efi_system_partition
```

- [ ] Add a label to the **efi** partition

```sh
# This will be useful later on to set the rEFInd config
dosfslabel /dev/efi_system_partition ARCHIE
```

- [ ] Verify the result

```bash
lsblk --fs /dev/partioned_disk
```

- [ ] Mount the **root** partition to **/mnt**

```bash
mount /dev/root_partition /mnt
```

- [ ] Mount the **efi** partition to **/mnt/efi**

```bash
mount --mkdir /dev/efi_system_partition /mnt/efi
```

- [ ] Enable the **swap**

```bash
swapon /dev/swap_partition
```

- [ ] Check the mountpoints

```bash
lsblk /dev/partioned_disk
```

## Notes

- To identify available disks, the `fdisk -l` command will give you all the
necessary information, but `lsblk` can also be used. My favorite flags are
`lsblk -o NAME,SIZE` for a concise output and `lsblk --fs` when I need to check
file system information

- Make sure to set the correct type for the *efi* partition
