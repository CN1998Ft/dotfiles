# Enable terminal-shell plugins
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# zsh plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZVM_CURSOR_STYLE_ENABLED=false

# alias section
# alias du="du -sh"
# alias du1="du -hd1"
# if command -v lsd &> /dev/null; then
#   alias ls="lsd"
# fi

unalias run-help
autoload run-help
HELPDIR="/usr/share/zsh/$ZSH_VERSION/help"
alias help=run-help

command -v lsd &> /dev/null && alias ls="lsd"

if command -v eza &> /dev/null; then
  alias ls='eza -h --group-directories-first --icons=auto'
fi

if command -v zoxide &> /dev/null; then
  alias cd="zd"
  zd() {
    if [ $# -eq 0 ]; then
      builtin cd ~ && return
    elif [ -d "$1" ]; then
      builtin cd "$1"
    else
      z "$@" 2>&1 > /dev/null && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
  }
fi

openf(){
    fzf_in="$(fzf)"
    if [[ -n $fzf_in ]]; then
        open $fzf_in
    fi
}

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
# alias vim="nvim"


# history options
HISTSIZE=1000000
SAVESIZE=1000000
[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTCONTROL=ignoreboth #Ignore duplicateds and commands

[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
# zsh completion system
autoload -Uz compinit
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION

setopt auto_list
setopt auto_menu
zstyle ':completion:*' menu select


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/fengtaozhang/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
export MAMBA_EXE='/Users/fengtaozhang/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/Users/fengtaozhang/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# --------------------- Temporary stuff --------------------- 

# >>> Python path for specific projects, temporarily  >>>
export PYTHONPATH="/Users/fengtaozhang/me/university_of_leeds/PhD/git_local/project_related:$PYTHONPYTH"
# <<< Python path for specific projects, temporarily  <<<

# >>>> work alias >>>>
alias opensim="open /Applications/OpenSim\ 4.5/OpenSim\ 4.5.app"
alias pwe="conda activate phd; cd project_related;"
alias pwen="pwe; nvim"
