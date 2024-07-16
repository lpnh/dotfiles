# Partitions

## Quality of Life

First of all, change the font using `setfont`:

```sh
setfont ter-222b
```

## Some verification

### UEFI Mode

The following command should return `64`:

```sh
cat /sys/firmware/efi/fw_platform_size
```

### Internet Connection

```sh
ping archlinux.org
```

### System Clock

```sh
timedatectl
```

## Partitioning the Disk

### Device Identification

To identify available disks, both `lsblk` and `fdisk -l` can be used.

### Partition Tables

To write the partition tables using `cfdisk`:

```sh
cfdisk /dev/the_disk_to_be_partitioned
```

Note: make sure to set the correct type for the `efi` partition.

Example Layout:

| Mount point | Purpose        | Suggested size | Partition type   |
|:------------|:---------------|:---------------|:-----------------|
| /efi        | efi            | 1 GiB          | EFI System       |
| [SWAP]      | swap           | 8 GiB          | Linux filesystem |
| /           | root           | Remainder      | Linux filesystem |

To verify the partitions:

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
This will be useful later to set the `refind` configuration.
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
