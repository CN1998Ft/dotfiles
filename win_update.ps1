# This is the PowerShell script for updating the config on Windows.
echo "I am currently in $(pwd)"

# Check if scoop.sh is installed and add extras to bucket
echo "Checking is scoop is installed"
if (-Not (get-command scoop))
{
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

echo "Updating scoop buckets"
scoop bucket add extras
scoop update

$packages = @(
'bat'
'cloc'
'eza'
'fastfetch'
'fd'
'ffmpeg'
'fzf'
'git'
'glazewm'
'lazygit'
'neovim'
'ripgrep'
'starship'
'yasb'
'zoxide'
)

for (($i=0); $package = $packages[$i]; $i++)
{
    # echo $package
    scoop install $package
    scoop update $package
}

# Add glazewm to startup folder
$startup_glazewm="$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/glazewm.exe"
$glazewm_scoop="$HOME/scoop/apps/glazewm/current/glazewm.exe"
if (-Not(test-path $startup_glazewm))
{
    if (test-path $glazewm_scoop)
    {
        clear
        echo Hello
        Copy-Item -Force $glazewm_scoop $startup_glazewm
    }
}

# Start synchronize configuration files
echo "Synchronizing Windows configuration"

# Neovim
Copy-Item -Recurse -Force ./win_home/nvim $HOME/AppData/Local/

# PowerShell
Copy-Item -Force ./win_home/Microsoft.PowerShell_profile.ps1 $PROFILE

# YASB and Starship
$config_dir = $(ls ./win_home/config/)
for (($i=0); $config=$config_dir[$i]; $i++)
{
    Copy-Item -Force -Recurse ./win_home/config/$config $HOME/.config/
    # if (test-path $HOME/.config/$config)
    # {
    #     echo yes
    # }
}

# Glazewm
Copy-Item -Force -Recurse ./win_home/glazewm $HOME/.glzr/

echo "Synchronzed all windows configurations."
echo "Happy coding!"
