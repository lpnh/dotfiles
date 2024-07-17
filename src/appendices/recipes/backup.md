# Live USB

- [ ] [Download the ISO file](https://archlinux.org/download/)
- [ ] Find the USB drive name: `ls -l /dev/disk/by-id/usb-*`
- [ ] Make sure it is **not** mounted: `lsblk`
- [ ] Write the ISO to the USB drive:
```sh
sudo pv path/to/archlinux-version-x86_64.iso -Yo /dev/disk/by-id/usb-My_flash_drive-0:0
```

## Inside the Live Environment

- [ ] Improve the default font size: `setfont ter-222b`
- [ ] Make sure the system is booted in UEFI mode:
```sh
# the output should be 64
cat /sys/firmware/efi/fw_platform_size
```
- [ ] Check the internet connection: `ping archlinux.org`
- [ ] Ensure the system clock is synchronized: `timedatectl`

## Partitions

### Partitioning the Disk

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

### Formatting the Partitions

- [ ] Create an *Ext4* fs for the **root**: `mkfs.ext4 /dev/root_partition`
- [ ] Initialize the *swap*: `mkswap /dev/swap_partition`
- [ ] Format the `efi` to FAT32: `mkfs.fat -F 32 /dev/efi_system_partition`
- [ ] Add a label to the efi partition: 
```sh
dosfslabel /dev/efi_system_partition ARCHIE
```
- [ ] Verify the result: `lsblk /dev/partioned_disk -o NAME,FSTYPE,LABEL`

### Mounting the File System

- [ ] The root partition to `/mnt`: `mount /dev/root_partition /mnt`
- [ ] The EFI partition to `/mnt/efi`: `mount --mkdir /dev/efi_system_partition /mnt/efi`
- [ ] Enable the `swap`: `swapon /dev/swap_partition`

## Installation

- [ ] Update the `mirrorlist`:
```sh
reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist
```
- [ ] Install Essential packages:
```sh
pacstrap -K /mnt base linux linux-firmware base-devel nano networkmanager
```

### Configuring the System

- [ ] Generate an fstab file: `genfstab -U /mnt >> /mnt/etc/fstab`
- [ ] Change root into the new system: `arch-chroot /mnt`
- [ ] Set the time zone: ` ln -sf /usr/share/zoneinfo/Region/City /etc/localtime`
- [ ] Generate the ` generate /etc/adjtime`: `hwclock --systohc`
- [ ] Uncomment the `#en_US.UTF-8 UTF-8` line: `nano /etc/locale.gen`
- [ ] Generate the locales: `locale-gen`
- [ ] Create the `locale.conf` file:
```sh
nano /etc/locale.conf
```
```txt
LANG=en_US.UTF-8
```
- [ ] Create the `hostname`:
```sh
nano /etc/hostname
```
```txt
desktop
```
- [ ] Set the root password: `passwd`

### Adding User With `sudo` Privileges

- [ ] Create new user, adding it to `wheel` group:
```sh
useradd -m -G wheel <username>
```
- [ ] Add a password to the user: `passwd <username>`
- [ ] Uncommenting the `# %wheel ALL=(ALL:ALL) ALL` line on sudoers config:
```sh
EDITOR=nano visudo
```
```txt
## Uncomment to allow members of group wheel to execute any command
%wheel ALL=(ALL:ALL) ALL
```

### Set the Boot Loader

- [ ] Install `systemd-boot`: `bootctl install`
- [ ] Edit the `loader.conf` file:
```sh
nano /efi/loader/loader.conf
```
```txt
default  arch.conf
timeout  4
console-mode auto
```
- [ ] Create the `arch.conf` entry:
```sh
nano /efi/loader/entries/arch.conf
```
```txt
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx rw
```
- [ ] Append the UUID number:
```sh
blkid -s UUID /dev/root_partition >> /efi/loader/entries/arch.conf
```
- [ ] Copy everything that is inside the `/boot` path to `/efi`:
```sh
cd /efi
```
```sh
cp /boot/* .
```

- [ ] Enable the `NetworkManager` service: `systemctl enable NetworkManager`

## Finishing

- [ ] Exit the chroot environment: `exit`
- [ ] Unmount all the partitions: `umount -R /mnt`
- Reboot: `reboot` *# good luck!*

### Verifying the Installation

- Download `fastfetch`: `sudo pacman -S fastfetch`
- Run it: `fastfetch`
- Enjoy your new achievement *# I use arch, btw*

## Pos-Installation

- [ ] Double Check *sorry I'm neurotic*
  - [ ] Refresh the system, including package database: `sudo pacman -Syyu`
  - [ ] Make sure some basic system packages are installed:
    ```sh
    sudo pacman -S --needed base-devel bash curl gcc git ncurses xz zstd
    ```

- [ ] Install Some Compilers
  - [ ] clang: `sudo pacman -S clang`
  - [ ] go: `sudo pacman -S go`
  - [ ] lua: `sudo pacman -S lua`
  - [ ] rustup:
    ```sh
    sudo pacman -S rustup
    ```
    ```sh
    rustup update stable
    ```

- [ ] Improve the Initramfs
  - [ ] Install the microcode accordingly:
    ```sh
    # for AMD CPU
    sudo pacman -S amd-ucode
    ```
    ```sh
    # for Intel CPU
    sudo pacman -S intel-ucode
    ```
  - [ ] Install booster: `sudo pacman -S booster`
  - [ ] Copy both new images to the `/efi` directory:
    ```sh
    cp /boot/cpu_manufacturer-ucode.img /efi
    ```
    ```sh
    cp /boot/booster-linux.img /efi
    ```
  - [ ] Create new loader entry:
    ```sh
    sudo nano /efi/loader/entries/booster.conf
    ```
    ```txt
    title   Arch Linux with Booster
    linux   /vmlinuz-linux
    initrd  /cpu_manufacturer-ucode.img
    initrd  /booster-linux.img
    options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx rw
    ```
  - [ ] Take the opportunity to include other kernel parameters:
    ```
    options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx nvme_load=YES nowatchdog rw
    ```
  - [ ] Update the `loader.conf` file:
    ```sh
    sudo nano /efi/loader/loader.conf
    ```
    ```txt
    default  booster.conf
    timeout  4
    console-mode auto
    ```
  - [ ] Verify the current available boot loader entries: `sudo bootctl list`
