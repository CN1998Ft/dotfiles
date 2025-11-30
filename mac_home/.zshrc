# Enable terminal-shell plugins
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# zsh plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
export ZVM_CURSOR_STYLE_ENABLED=false

# alias section
# alias du="du -sh"
# alias du1="du -hd1"
# if command -v lsd &> /dev/null; then
#   alias ls="lsd"
# fi
command -v lsd &> /dev/null && alias ls="lsd"

if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
fi

if command -v zoxide &> /dev/null; then
  alias cd="zd"
  zd() {
    if [ $# -eq 0 ]; then
      builtin cd ~ && return
    elif [ -d "$1" ]; then
      builtin cd "$1"
    else
      z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
  }
fi

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
# alias vim="nvim"


export PATH="$PATH:/Applications/OpenSim\ 4.5/bin"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"


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
