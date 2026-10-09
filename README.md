# dotfiles

> [!IMPORTANT]
> My personal dotfiles started with MacOS and Linux. Finally, with Windows too.
>
> Linux and MacOS directory uses stow, and the directory is symlinked to the home directory.
> Windows is not, as the configuration files in windows is all over the place, thus win_update.bat is used to synchronise(copy/paste) the configuration files every time I make any change.

## Configuration files

## Setup files

Bash script to setup MacOS with homebrew and Fedora Linux.
- install

Windows batch scripts to setup Windows with scoop.
- win_update.bat

### Common configuration across all platform

- neovim
- starship

- Keyboards layout configuration files.

### Common between mac and Linux

- vim
- tmux

### Individual configuration on each platform

#### Fedora

The configuration files are inside fedora_home

- bash
- alacritty
- foot
- fuzzel
- ghostty
- git
- kanshi
- niri
- rofi
- sway
- swaylock
- waybar
- mimeapps.lis
- okular

Additional desktop files:

- Alacritty
- drawio
- neovide
- nvim

#### MacOS

The configuration files are inside mac_home

- bash
- aerospace
- alacritty
- borders
- ghostty
- git
- sketchybar
- zsh
- okular


#### Windows

The configuration files are inside win_home

- alacritty
- clink
- config
- glazewm
- okular
- wt
- Microsoft.PowerShell_profile.ps
- tmux.con
- vimr
