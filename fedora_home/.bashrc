# .bashrc
[[ -n $PS1 ]] || return

# Source global definitions
if [[ -f /etc/bashrc ]]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi
export PATH

# ==> Set environment section
export EDITOR="nvim"

# XDG specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots/"
export GRIM_DEFAULT_DIR="$HOME/Pictures/Screenshots/"

# partially supported
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export HISTFILE="$XDG_STATE_HOME/bash/history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# history files
export LESSHISTFILE="$XDG_STATE_HOME/less_history"
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
export HISTTIMEFORMAT='%F %T - '
export HISTCONTROL='ignoreboth'
export HISTSIZE=5000
export HISTFILESIZE=5000

# ==> init section
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(fzf --bash)"

# Shell options
shopt -s cdspell
shopt -s checkwinsize
shopt -s extglob
shopt -s autocd
shopt -s dirspell

# ==> Aliases
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

if command -v eza &>/dev/null; then
    alias ls="eza -h --group-directories-first --icons=auto"
fi

if command -v zoxide &>/dev/null; then
    alias cd="zd"
    zd() {
        if [[ $# -eq 0 ]]; then
            builtin cd ~ && return
        elif [[ -d "$1" ]]; then
            builtin cd "$1"
        else
            z "$@" &>/dev/null && echo -ne "\U000F17A9" && pwd || echo "Error: Directory not found"
            # z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
        fi
    }
fi

alias open="xdg-open"

openf() {
    fzf_in="$(fzf)"
    if [[ -n $fzf_in ]]; then
        open $fzf_in
    fi
}

alias n="nvim"

alias nvide="~/AppImages/neovide.AppImage --no-fork & disown"

if command -v luajit &>/dev/null; then
	alias lua="luajit"
fi

if [[ -d "$HOME/miniforge3" ]]; then
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/fengtao/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/fengtao/miniforge3/etc/profile.d/conda.sh" ]; then
            . "/home/fengtao/miniforge3/etc/profile.d/conda.sh"
        else
            export PATH="/home/fengtao/miniforge3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<


    # >>> mamba initialize >>>
    # !! Contents within this block are managed by 'mamba shell init' !!
    export MAMBA_EXE='/home/fengtao/miniforge3/bin/mamba';
    export MAMBA_ROOT_PREFIX='/home/fengtao/miniforge3';
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__mamba_setup"
    else
        alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
    fi
    unset __mamba_setup
    # <<< mamba initialize <<<
    phd_python="$HOME/me/phd/motion_path:"
    export PYTHONPATH="$PYTHONPATH$phd_python"
    alias mwe="cd motion; mamba activate phd"
fi
