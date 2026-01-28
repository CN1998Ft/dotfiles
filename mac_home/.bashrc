# .bashrc

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
eval "$(/opt/homebrew/bin/brew shellenv)"

# Shell options
shopt -s cdspell
shopt -s checkwinsize
shopt -s extglob
shopt -s autocd
shopt -s dirspell

# ==> Aliases
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

if command -v eza &>/dev/null; then
    alias ls="eza -lh --group-directories-first --icons=auto"
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

openf() {
    fzf_in="$(fzf)"
    if [[ -n $fzf_in ]]; then
        open $fzf_in
    fi
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/fengtaozhang/miniforge3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/fengtaozhang/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/fengtaozhang/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/fengtaozhang/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/Users/fengtaozhang/miniforge3/bin/mamba'
export MAMBA_ROOT_PREFIX='/Users/fengtaozhang/miniforge3'
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE" # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# --------------------- Temporary stuff ---------------------

# >>> Python path for specific projects, temporarily  >>>
export PYTHONPATH="/Users/fengtaozhang/me/university_of_leeds/PhD/git_local/project_related:$PYTHONPYTH"
export PATH="$PATH:/Applications/FEBioStudio.app/Contents/MacOS"
export PATH="$PATH:/Applications/OpenSim\ 4.5/bin"
# <<< Python path for specific projects, temporarily  <<<

# >>>> work alias >>>>
alias opensim="open /Applications/OpenSim\ 4.5/OpenSim\ 4.5.app"
alias pwe="conda activate phd; cd project_related;"
alias pwen="pwe; nvim"
