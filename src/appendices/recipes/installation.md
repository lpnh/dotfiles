# Installation

- [ ] Update the `mirrorlist`:
```sh
reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist
```
- [ ] Install Essential packages:
```sh
pacstrap -K /mnt base linux linux-firmware base-devel nano networkmanager
```

## Configuring the System

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

## Adding User With `sudo` Privileges

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

## Set the Boot Loader

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

## Verifying the Installation

- Download `fastfetch`: `sudo pacman -S fastfetch`
- Run it: `fastfetch`
- Enjoy your new achievement *# I use arch, btw*
