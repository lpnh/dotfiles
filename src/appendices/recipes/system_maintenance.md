# System Maintenance

- [ ] Update the **mirrorlist**:
```sh
sudo reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist
```
- [ ] Refresh the entire system:
```sh
yay -Syyu
```

*# work in progress*
