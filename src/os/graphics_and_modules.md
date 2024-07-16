# Drivers and Modules

## Graphics

Install `mesa`:

```sh
sudo pacman -S mesa
```

### AMD

For Vulkan support:

```sh
sudo pacman -S vulkan-radeon
```

## Kernel Mode Setting

To early load modules using Booster:

```sh
sudo nano /etc/booster.yaml
```

```yaml
modules_force_load: <module_name>
```
