# Installation

- [ ] Update the **mirrorlist**:
```sh
reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist
```
- [ ] Install the essential packages to the new root:
```sh
pacstrap -K /mnt base linux linux-firmware base-devel nano networkmanager
```

## Configuring the System

- [ ] Generate an **fstab** file: `genfstab -U /mnt >> /mnt/etc/fstab`
- [ ] Change root into the new system: `arch-chroot /mnt`
- [ ] Set the time zone: `ln -sf /usr/share/zoneinfo/Region/City /etc/localtime`
- [ ] Verify the new local time: `date`
- [ ] Generate the */etc/adjtime*: `hwclock --systohc`
- [ ] Set up time synchronization: `timedatectl set-ntp true`
- [ ] Check the service status: `timedatectl status`
- [ ] Edit the **locale.gen** file:
```sh
nano /etc/locale.gen
```
```txt
# Uncomment this line
en_US.UTF-8 UTF-8
```
- [ ] Generate the locales: `locale-gen`
- [ ] Create the **locale.conf** file, setting the **LANG** variable accordingly:
```sh
nano /etc/locale.conf
```
```txt
LANG=en_US.UTF-8
```
- [ ] Create the **hostname** file:
```sh
nano /etc/hostname
```
```txt
desktop
```
- [ ] Set the root password: `passwd`

## Creating New User

- [ ] Create new user, adding it to the **wheel** group:
```sh
useradd -m -G wheel <username>
```
- [ ] Add a password to the user: `passwd <username>`
- [ ] Edit the sudoers configuration file:
```sh
EDITOR=nano visudo
```
```txt
## Uncomment to allow members of group wheel to execute any command
%wheel ALL=(ALL:ALL) ALL
```

## Set the Boot Loader

- [ ] Install **systemd-boot**: `bootctl install`
- [ ] Edit the **loader.conf** file:
```sh
nano /efi/loader/loader.conf
```
```txt
default  arch.conf
timeout  4
console-mode auto
```
- [ ] Create the **arch.conf** entry:
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
- [ ] Copy everything that is inside **/boot** to **/efi** directory:
```sh
cd /efi
```
```sh
cp /boot/* .
```

- [ ] Enable the **NetworkManager** service: `systemctl enable NetworkManager`

## Finishing

- [ ] Exit the chroot environment: `exit`
- [ ] Unmount all the partitions: `umount -R /mnt`
- Reboot: `reboot`  
*# good luck!*

## Verifying the Installation

- Download **fastfetch**: `sudo pacman -S fastfetch`
- Run it: `fastfetch`
- Enjoy your new achievement
