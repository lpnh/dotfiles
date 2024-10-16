# Installation

- [ ] Update the **mirrorlist**

```bash
reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist
```

- [ ] Install the essential packages to the new root

```bash
pacstrap -K /mnt base linux linux-firmware base-devel git nano networkmanager
```

- [ ] Generate an **fstab** file

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

- [ ] Change root into the new system

```bash
arch-chroot /mnt
```

- [ ] Set the time zone

```bash
# Example for UTC-3
ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime
```

- [ ] Verify the new local time

```bash
date
```

- [ ] Generate the */etc/adjtime*

```bash
hwclock --systohc
```

- [ ] Set up time synchronization

```bash
systemctl enable systemd-timesyncd.service
```

- [ ] Edit the **/etc/locale.gen** file, uncommenting the `en_US.UTF-8 UTF-8
` and other needed UTF-8 locales

```bash
nano /etc/locale.gen
```

- [ ] Generate the locales

```bash
locale-gen
```

- [ ] Create the **locale.conf** file, setting the **LANG** variable accordingly

```bash
nano /etc/locale.conf
```

```txt
LANG=en_US.UTF-8
```

- [ ] Create the **/etc/vconsole.conf** file, if a different keyboard layout is
required

```bash
nano /etc/vconsole.conf
```

```txt
KEYMAP=br-abnt2
```

- [ ] Create the **hostname** file

```bash
nano /etc/hostname
```

```txt
desktop
```

- [ ] Set the root password

```bash
passwd
```

- [ ] Create a new user, adding it to the **wheel** group

```bash
useradd -m -G wheel <username>
```

- [ ] Add a password to the user

```bash
passwd <username>
```

- [ ] Edit the sudoers configuration file

```bash
EDITOR=nano visudo
```

```txt
## Uncomment to allow members of group wheel to execute any command
%wheel ALL=(ALL:ALL) ALL
```

## Set the Boot Loader

- [ ] Install **systemd-boot**

```bash
bootctl install
```

- [ ] Edit the **loader.conf** file

```bash
nano /efi/loader/loader.conf
```

```txt
default  arch.conf
timeout  3
console-mode auto
```

- [ ] Create the **arch.conf** entry

```bash
nano /efi/loader/entries/arch.conf
```

```txt
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx rw
```

*Hint: run the following command to append the UUID number to the `arch.conf`
file*

```bash
blkid -s UUID /dev/root_partition >> /efi/loader/entries/arch.conf
```

- [ ] Copy everything that is inside **/boot** to **/efi** directory

```bash
cd /efi
```

```bash
cp /boot/* .
```

- [ ] Enable the **NetworkManager** service

```bash
systemctl enable NetworkManager
```

- [ ] Exit the chroot environment

```bash
exit
```

- [ ] Unmount all the partitions

```bash
umount -R /mnt
```

- [ ] Reboot

```bash
reboot
```

*// good luck!*

## Verifying the Installation

*The next step is for wi-fi connections only.*

- [ ] Use `nmcli` to list and to connect to available Wi-Fi networks

```sh
nmcli device wifi list
```

```sh
nmcli device wifi connect <SSID> password <password>
```

- [ ] Download **fastfetch**

```bash
sudo pacman -S fastfetch
```

- [ ] Run it

```bash
fastfetch
```

*// enjoy your new achievement!*

## Notes

- Jokes aside, the last step is a simple and efficient way to verify your
installation.
