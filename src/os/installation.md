# Installation

## Mirror List

Update the `mirrorlist` using `reflector`:

```sh
reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist
```

## Install Essential Packages

```sh
pacstrap -K /mnt base linux linux-firmware base-devel nano networkmanager
```

## Fstab

```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

## Chroot

```sh
arch-chroot /mnt
```

## Time

Set the time zone:

```sh
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```

Note: You can verify it running `date`.

Generate the `/etc/adjtime` file:

```sh
hwclock --systohc
```

## Localization

Uncomment the `#en_US.UTF-8 UTF-8` line editing the `/etc/locale.gen` file:

```sh
nano /etc/locale.gen
```

Generate the locales:

```sh
locale-gen
```

Create the `locale.conf` file with the following content:

```sh
nano /etc/locale.conf
```

```txt
LANG=en_US.UTF-8
```

## Hostname

Create the `hostname` with your host name, e.g. `desktop`:

```sh
nano /etc/hostname
```

```txt
desktop
```

## Root password

Set the root password:

```sh
passwd
```

## Adding a User

To add a user with sudo privileges:

```sh
useradd -m -G wheel <username>
```

To add a password to the user:

```sh
passwd <username>
```

Edit the sudoers uncommenting the `# %wheel ALL=(ALL:ALL) ALL` line:

```sh
EDITOR=nano visudo
```

## Enable Network

To enable `NetworkManager` service:

```sh
systemctl enable NetworkManager
```

## Boot Loader

Install `systemd-boot`

```sh
bootctl install
```

Edit the `/efi/loader/loader.conf` file:

```sh
nano /efi/loader/loader.conf
```

```txt
default  arch.conf
timeout  4
console-mode auto
```

Create the `/efi/loader/entries/arch.conf` file:

```sh
nano /efi/loader/entries/arch.conf
```

```txt
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx rw
```

To make it easy to set the UUID you can use the `blkid` command and append the
output to the `arch.conf` file.

```sh
blkid -s UUID /dev/root_partition >> /efi/loader/entries/arch.conf
```

Copy everything that is inside the `/boot` path to `/efi`.

## Reboot

Exit the chroot environment:

```sh
exit
```

Unmount all the partitions and reboot:

```sh
umount -R /mnt
```

```sh
reboot
```

That's it. Good luck!

## By the Way

If you have succeeded, there's one last thing to be done.

First download `fastfetch`:

```sh
sudo pacman -S fastfetch
```

Now simply run and enjoy your achievement:

```sh
fastfetch
```
