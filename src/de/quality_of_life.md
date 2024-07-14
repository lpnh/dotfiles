# Quality of Life

## Font

To refresh the font cache:

```sh
sudo fc-cache -fv
```

## SSH

To generate a new SSH key:

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Check the public key:

```sh
cat ~/.ssh/id_ed25519.pub
```

Test the SSH connection:

```sh
ssh -T git@github.com
```

## Neovim

To install and set Neovim nightly using `bob`:

```sh
bob install nightly
```

```sh
sudo bob use nightly
```

To increase the maximum number of `inotify` watches and queued events.
Add the following to `/etc/sysctl.conf`

```sh
sysctl fs.inotify.max_user_watches=100000
sysctl fs.inotify.max_queued_events=100000
```
