# Installation

- [ ] Update the **mirrorlist**

```bash
reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist
```

- [ ] Install the essential packages to the new root

```bash
pacstrap -K /mnt base linux linux-firmware
```

*And also:*

```txt
base-devel
git
amd-code / intel-ucode
booster
busybox
systemd-ukify
mesa
vulkan-radeon / nvidia
networkmanager
nano
refind
```

- [ ] Generate an *fstab* file

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

- [ ] Check the new local time

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

- [ ] Edit the *locale.gen* file, uncommenting all the needed UTF-8 locales

```bash
nano /etc/locale.gen
```

```txt
en_US.UTF-8 UTF-8
#en_US ISO-8859-1
```

- [ ] Generate the locales

```bash
locale-gen
```

- [ ] Create the *locale.conf* file, setting the *LANG* variable accordingly

```bash
nano /etc/locale.conf
```

```txt
LANG=en_US.UTF-8
```

- [ ] Create the */etc/vconsole.conf* file, if a different keyboard layout is
required

```bash
nano /etc/vconsole.conf
```

```txt
KEYMAP=br-abnt2
```

- [ ] Create the *hostname* file

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

- [ ] Create a new user, adding it to the *wheel* group

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

- [ ] Install *systemd-boot*

```bash
bootctl install
```

- [ ] Install *rEFInd*

```bash
refind-install
```

- [ ] Set booster configuration file

```bash
nano /etc/booster.yaml
```

```yaml
extra_files: busybox,fsck,fsck.ext4
modules_force_load: amdgpu,hid_generic,usbhid
```

*for **nvidia** gpu, replace **amdgpu** accordingly:*

```yaml
modules_force_load: nvidia,nvidia_modeset,nvidia_uvm,nvidia_drm,hid_generic,usbhid
```

- [ ] Set the *install.conf* file

```bash
nano /etc/kernel/install.conf
```

```txt
layout=uki
uki_generator=ukify
```

- [ ] Set the *ukify* configuration

```bash
nano /etc/kernel/uki.conf
```

```txt
[UKI]
Initrd=/boot/booster-linux.img
Microcode=/boot/<amd/intel>-ucode.img
Splash=/usr/share/systemd/bootctl/splash-arch.bmp
```

- [ ] Include the device and other kernel parameters to the *cmdline*

```bash
nano /etc/kernel/cmdline
```

```txt
root=LABEL=ARCHIE_ROOT nvme_load=YES nowatchdog rw quiet
```

- [ ] Verify the current *kernel-install* configuration

```bash
kernel-install inspect
```

- [ ] Check the current available boot entries

```bash
bootctl list
```

- [ ] Enable the *NetworkManager* service

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

*good luck !*

<details open>
  <summary>
    <i>for wi-fi based connections only</i>
  </summary>

- [ ] Use *nmcli* to list and to connect to available Wi-Fi networks

```sh
nmcli device wifi list
```

```sh
nmcli device wifi connect <SSID> password <password>
```

</details>

- [ ] Download *fastfetch*

```bash
sudo pacman -S fastfetch
```

- [ ] Run it

```bash
fastfetch
```

*enjoy your new achievement !*

## Notes

- A good reference for essential packages is to check the ones available in the
Arch Linux live system (ISO). You can find them
[here](https://geo.mirror.pkgbuild.com/iso/latest/arch/pkglist.x86_64.txt)
Another good source is to check the packages available in the EndeavourOS ISO.
You can find them in [their
repo](https://github.com/endeavouros-team/EndeavourOS-ISO/blob/main/packages.x86_64)
- Jokes aside, the last step is a simple and efficient way to verify your
installation
