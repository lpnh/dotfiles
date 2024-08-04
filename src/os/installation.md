# Installation

## Mirror List

To update the `mirrorlist` using `reflector`:

```bash
reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist
```

## Install Essential Packages

To install the essential packages to the new root:

```bash
pacstrap -K /mnt base linux linux-firmware base-devel git nano networkmanager
```

## Fstab

To generate an `fstab` file:

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

## Chroot

To change root into the new system:

```bash
arch-chroot /mnt
```

## Time

To set the time zone:

```bash
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```

Note: You can verify it using the command `date`:

```bash
date
```

To generate the `/etc/adjtime` file:

```bash
hwclock --systohc
```

To set up time synchronization with `systemd-timesyncd`:

```bash
systemctl enable systemd-timesyncd.service
```

## Localization

Uncomment the `#en_US.UTF-8 UTF-8` line editing the `/etc/locale.gen` file:

```bash
nano /etc/locale.gen
```

To generate the locales:

```bash
locale-gen
```

Create the `locale.conf` file, setting the *LANG* variable accordingly:

```bash
nano /etc/locale.conf
```

```txt
LANG=en_US.UTF-8
```

## Hostname

To set a hostname create a `hostname` file, adding its name, e.g. *desktop*:

```bash
nano /etc/hostname
```

```txt
desktop
```

## Root password

To set the root password, run:

```bash
passwd
```

## Creating New User

To create new user, adding it to the `wheel` group:

```bash
useradd -m -G wheel username
```

To add a password to the user, run:

```bash
passwd username
```

Edit the sudoers configuration file, uncommenting the `# %wheel ALL=(ALL:ALL)
ALL` line:

```bash
EDITOR=nano visudo
```

```txt
## Uncomment to allow members of group wheel to execute any command
%wheel ALL=(ALL:ALL) ALL
```

## Enable Network

To enable `NetworkManager` service:

```bash
systemctl enable NetworkManager
```

## Boot Loader

Install `systemd-boot`

```bash
bootctl install
```

Edit the `/efi/loader/loader.conf` file:

```bash
nano /efi/loader/loader.conf
```

```txt
default  arch.conf
timeout  4
console-mode auto
```

Create the `/efi/loader/entries/arch.conf` file:

```bash
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

```bash
blkid -s UUID /dev/root_partition >> /efi/loader/entries/arch.conf
```

Copy everything that is inside the `/boot` path to `/efi`.

## Reboot

To exit the chroot environment:

```bash
exit
```

To unmount all the partitions and reboot:

```bash
umount -R /mnt
```

```bash
reboot
```

That's it. Good luck!

## By the Way

If you have succeeded, there's one last thing to be done.

First download `fastfetch`:

```bash
sudo pacman -S fastfetch
```

Now run it and enjoy your new achievement:

```bash
fastfetch
```

Note: jokes aside, this last step is a simple and efficient way to verify your
installation.
