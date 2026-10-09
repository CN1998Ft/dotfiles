# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    unset GTK_IM_MODULE
else
    export GTK_IM_MODULE=fcitx
fi

# User specific environment and startup programs
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots/"
export GRIM_DEFAULT_DIR="$HOME/Pictures/Screenshots/"
