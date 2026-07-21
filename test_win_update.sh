#!/usr/bin/env bash
cd "$(dirname "$0")" && echo "[Current dir: $PWD]"

os_name=$(uname)
NT_name='^.*_NT-.*$'

if [[ ! "$os_name" =~ $NT_name ]]; then
    echo "This script is for Windows bash only, try run ./install instead."
fi

echo "[Checking if scoop is installed]"

if ! command -v scoop &> /dev/null; then
    echo "!!!!! scoop is not installed !!!!!"
    # Execute the installation command
    curl -s get.scoop.sh | sh
    scoop install git
fi

# Add buckets extra if not added
if [ ! -d "$HOME/scoop/buckets/extras" ]; then
    scoop bucket add extras
fi

package="bat cloc eza fastfetch fd ffmpeg fzf git glazewm lazygit neovim"
package1="ripgrep starship yasb zoxide alacritty miktex pandoc glow mpv"
package2="jq poppler resvg imagemagick pwsh luajit nodejs"
package3="clink yt-dlp yazi 7zip psmux neovide okular draw.io"

for p in $package $package1 $package2 $package3; do
    if [ ! -d "$HOME/scoop/apps/$p" ]; then
        echo "installing Package: [$p]"
        scoop install "$p"
    fi
done

# <== Configuration synchronizing section
echo "[Synchronising configuration files]"

# Neovim
# Using standard ~/.config/nvim unless explicit localappdata equivalent is needed
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

rm -rf "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_CONFIG_HOME/nvim"
cp -r ./c_config/nvim/* "$XDG_CONFIG_HOME/nvim/" 2>/dev/null

# vim
if [ "$USER" = "mn19fz" ]; then
    cp ./win_home/vimrc /M/.vimrc 2>/dev/null
else
    cp ./win_home/vimrc "$HOME/.vimrc" 2>/dev/null
fi

# alacritty
rm -rf "$XDG_CONFIG_HOME/alacritty"
mkdir -p "$XDG_CONFIG_HOME/alacritty"
cp -r ./win_home/alacritty/* "$XDG_CONFIG_HOME/alacritty/" 2>/dev/null

# Windows Terminal (Kept for compatibility, adjusting path format)
# Note: This directory path contains Windows apps references, leaving structural layout matching your original logic.
WT_PATH="$HOME/.local/share/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
mkdir -p "$WT_PATH"
cp "./win_home/wt/settings.json" "$WT_PATH/settings.json" 2>/dev/null

# .config
rm -rf "$HOME/.config" 2>/dev/null
mkdir -p "$HOME/.config" 2>/dev/null
cp -r ./win_home/config/* "$HOME/.config/" 2>/dev/null

# glazewm
rm -rf "$HOME/.glzr/glazewm"
mkdir -p "$HOME/.glzr/glazewm"
if [ "$USER" = "mn19fz" ]; then
    cp "./win_home/glazewm/config_mn19fz.yaml" "$HOME/.glzr/glazewm/config.yaml" 2>/dev/null
else
    cp "./win_home/glazewm/config.yaml" "$HOME/.glzr/glazewm/" 2>/dev/null
fi

# Add glazewm to startup (Kept structural paths intact, converted script content)
# Converted batch file writing syntax to shell format
STARTUP_PATH="$XDG_CONFIG_HOME/autostart" # standard linux startup path alternative
rm -rf "$STARTUP_PATH/"* 2>/dev/null

cat << 'EOF' > glazewm.sh
#!/bin/bash
export __COMPAT_LAYER=RunAsInvoker
"$HOME/scoop/apps/glazewm/current/glazewm.exe" &
EOF
chmod +x glazewm.sh

if [ "$USER" = "mn19fz" ]; then
    glazewm_bat_path="$HOME/Desktop/glazewm.sh"
else
    glazewm_bat_path="$STARTUP_PATH/glazewm.sh"
fi
mkdir -p "$(dirname "$glazewm_bat_path")"
mv "./glazewm.sh" "$glazewm_bat_path" 2>/dev/null

# Okular
rm -rf "$XDG_CONFIG_HOME/kxmlgui5" 2>/dev/null
mkdir -p "$XDG_CONFIG_HOME/kxmlgui5/okular" 2>/dev/null
cp -r ./win_home/okular/* "$XDG_CONFIG_HOME/kxmlgui5/okular/" 2>/dev/null

# psmux
cp "./win_home/tmux.conf" "$HOME/.tmux.conf" 2>/dev/null

# Clink
rm -rf "$XDG_CONFIG_HOME/clink" 2>/dev/null
mkdir -p "$XDG_CONFIG_HOME/clink" 2>/dev/null
cp -r ./win_home/clink/* "$XDG_CONFIG_HOME/clink/" 2>/dev/null

# Executing clink config commands safely if clink exists
if command -v clink &> /dev/null; then
    clink set fzf.exe_location "$HOME/scoop/apps/fzf/current/fzf.exe" >/dev/null 2>&1
    clink set fzf.default_bindings true >/dev/null 2>&1
    clink set match.expand_envvars True >/dev/null 2>&1
    clink autorun install >/dev/null 2>&1
fi

echo "[Synchronised all windows configurations.]"
# <== Configuration synchronizing section

echo "[Happy coding!]"
