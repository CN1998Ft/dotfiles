
# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$PATH:/Applications/FEBioStudio.app/Contents/MacOS"
export PATH="$PATH:/Applications/OpenSim\ 4.5/bin"

export XDG_CONFIG_HOME="$HOME/.config"
