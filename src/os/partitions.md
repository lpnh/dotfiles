# Partitions

## Partitioning the Disk

### Device Identification

To identify available disks, both `lsblk --fs` and `fdisk -l` can be used.

<div class="warning">

Always ensure you identify and select the correct device.
The following steps may result in unintended data loss.

</div>

### Optimal Logical Sector Size (exclusive for NVMe devices)

To check the formatted logical block address (LBA) size of your NVMe drive:

```sh
nvme id-ns -H /dev/nvme0n1 | grep "Relative Performance"
```
```txt
LBA Format  0 : Metadata Size: 0   bytes - Data Size: 512 bytes - Relative Performance: 0x2 Good (in use)
LBA Format  1 : Metadata Size: 0   bytes - Data Size: 4096 bytes - Relative Performance: 0x1 Better
```

You can confirm it by running `lsblk -td` and looking at the `LOG-SEC` column value.

Note: On the example above the sector size in use (512 bytes) is **not** the
optimal one.

To change the logical block address size, you can use the `nvme format` command
specifying the preferred value with the `--lbaf` parameter:

```sh
nvme format --lbaf=1 /dev/nvme0n1
```

### Partition Tables

To write the partition tables using `cfdisk`:

```sh
cfdisk /dev/the_disk_to_be_partitioned
```

> [!NOTE]
> make sure to set the correct type for the `efi` partition.

Example Layout:

| Mount point | Purpose        | Suggested size | Partition type   |
|:------------|:---------------|:---------------|:-----------------|
| /efi        | efi            | 1 GiB          | EFI System       |
| [SWAP]      | swap           | 8 GiB          | Linux filesystem |
| /           | root           | Remainder      | Linux filesystem |

To verify the partitions using `fdisk`:

```sh
fdisk -l /dev/partitioned_disk
```

## Formatting Partitions

To create an *Ext4* file system for the root:

```sh
mkfs.ext4 /dev/root_partition
```

To initialize the swap partition:

```sh
mkswap /dev/swap_partition
```

To format the EFI partition:

```sh
mkfs.fat -F 32 /dev/efi_system_partition
```

## Filesystem Label

Now is a good time to add a label to the efi partition.
This will be useful later to set the `rEFInd` configuration.
Using `dosfslabel`:

```sh
dosfslabel /dev/efi_system_partition ARCHIE
```

You can verify it using `lsblk`:

```sh
lsblk -o NAME,LABEL
```

## Mounting the File Systems

Mount the root volume to `/mnt`:

```sh
mount /dev/root_partition /mnt
```

Mount the EFI partition:

```sh
mount --mkdir /dev/efi_system_partition /mnt/efi
```

Enable the `swap` volume:

```sh
swapon /dev/swap_partition
```
