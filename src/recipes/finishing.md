# Finishing

## Catppuccin

- [ ] Rebuild **bat**'s cache to add the new syntax highlighting: `bat cache
--build`
- [ ] Check if Catppuccin is available:
```bash
bat --list-themes | rg "Catppuccin"
```
- [ ] Apply Catppuccin Mocha Mauve color theme to firefox: [simply click
here](https://color.firefox.com/?theme=XQAAAAJEBAAAAAAAAABBqYhm849SCicxcUcPX38oKRicm6da8pFtMcajvXaAE3RJ0F_F447xQs-L1kFlGgDKq4IIvWciiy4upusW7OvXIRinrLrwLvjXB37kvhN5ElayHo02fx3o8RrDShIhRpNiQMOdww5V2sCMLAfehhpkvCNGPFQ9qpGpx7BgGSYPGUMFXC1Ua9FaxHdWOc93hEJrTCm7pTY2gENlkIGOUk-0q5koU7B1u0Ej-oMph40xEOeck_YUJD52Bwer09STdlto8FTe2opihD2FyRdpJyZydtlY3dK_RO373JUB4GPAs2saJone2-92ozhdZDXTzFe1BzECDYiTLKw8wgkHlYGBfEaHwiRhB6Xx67wrqMSr8VhLm8d-NCA1DySJVtxxWJN-qabWQpDds2gw6dhs97Ngt5Z_6ZhJ5vv31xfjj2v6iK816VOdJaIaQu4xsqHAytxXRLJQ8LtmF0BsXZI5kUVsRJUHALGJAvl388n-yyQfaq8ZWzVK-rrBoAJJqwlvJaa-7K1eFh6NaMojpf5pl-eqKMtg1KMmYlS4DjK6Z__leZhs)

## Neovim

- [ ] Launch **Neovim** to fetch its configuration: `nvim`
- [ ] Include the api-key for **WakaTime** plugin:
```bash
# launch the website and copy the api key
start https://wakatime.com/api-key
```
```bash
# run the following cmd inside neovim and paste the key
WakaTimeApiKey
```

## Yazi

- [ ] Fetch the plugins using Yazi package manager:
```bash
ya pack -i
```
```bash
ya pack -u
```