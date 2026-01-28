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

vim() {
	nvim -u $HOME/.config/vim/vimrc $@
}
