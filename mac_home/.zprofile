# default programme
export EDITOR="nvim"

# XDG specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# partially supported
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
# bootstrap .zshrc to ~/.config/zsh/.zshrc
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# history files
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export PYTHON_HISTORY="$XDG_DATA_HOME/python/history"

# PATH
# Setting PATH for Python 3.10
export PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$PATH:/Applications/FEBioStudio.app/Contents/MacOS"
export PATH="$PATH:/Applications/OpenSim\ 4.5/bin"
