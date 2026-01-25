# dotfiles

My personal dotfiles started with MacOs and Linux. Finally, with Windows too.

## macOs
>
> [!NOTE]
> The sketchybar is created and integrate with aerospace. However, it is far
> from complete. Thus, not enabled.

- aerospace
- ghostty
- git
- neovim
- *sketchybar* [Unfinished]
- vim
- zsh
- starship

## Linux
>
> [!WARNING]
> The Linux dotfiles were adopted from Omarchy Linux, but I am planning to use
> Fedora Linux. Not tested and migration has yet started. Will use gnome
> instead of hyprland. As Fedora is the plan and Wayland is the default, I am
> considering sway.

- ghostty
- Alacritty
- git
- vim
- sway <!-- - *~~hyprland~~* potential replacement [sway] -->
- starship
- .bashrc

## Windows
>
> [!NOTE]
> Since Windows does not have any tool like GNU/stow, we will create a
> PowerShell script to create symlink for the following configurations.

- neovim
- starship
- pwsh
- yasb
- glazewm

---

## TODO

    1. Figure out the xdg-open, xdg-mime, and xdg-settings on linux.

## Shortcuts

### Universal shortcuts table

|Application Shortcuts| Description |
|------------|-------------|
|cmd/super/win+enter|Launch ghostty/terminal|
|cmd/super/win+b|Launch Google chrome|
|cmd/super/win+y|Launch Youtube|
|cmd/super/win+w/q|Close focused window|

|Window manager bindings| Description |
|------------|-------------|
|alt+hjkl(motions keys)|Change focused window|
|alt+numbers|Change focused workspaces|
|alt+shift+hjkl(motions keys)|Swap focused window position|
|alt+shift+numbers|send focused window to workspaces(number)|
|alt+f |Toggle focused window fullscreen|
|alt+shift+f |Toggle focused window floating|

### MacOs aerospace specific shortcuts table

|Application Shortcuts| Description |
|------------|-------------|
|alt+slash|Toggle horizontal vertical tiles|
|alt+comma|Toggle horizontal vertical accordion|
