# This is the PowerShell script for updating the config on Windows.
echo "I am currently in $(pwd)"

# ==> Scoop related section
# Check if scoop.sh is installed and add extras to bucket
echo "Checking is scoop is installed"
if (-Not (get-command scoop))
{
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# Added buckets extras if not added
echo "Check the status of scoop and buckets"
$buckets=$(ls $HOME/scoop/buckets)
if (-Not ($buckets -contains "extras"))
{
    scoop bucket add extras
}
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

# Install mising packages if 
$installed=$(ls $HOME/scoop/apps)
for (($i=0); $package = $packages[$i]; $i++)
{
    if (-Not ($installed -contains "$package"))
    {
        echo "Installing Package: $package"
        scoop install $package
    }
    else
    {
        scoop update $package
    }

}
# <== Scoop related section

# ==> Added startup app section
# Add wt and glazewm to startup folder
$startup_dir="$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/"
$glazewm="$HOME/scoop/apps/glazewm/current/glazewm.exe"
Copy-Item -Force -Recurse $glazewm $startup_dir


# <== Added startup app section

# ==> Configuration synchronizing section
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
}

# Glazewm
Copy-Item -Force -Recurse ./win_home/glazewm $HOME/.glzr/

echo "Synchronzed all windows configurations."
# <== Configuration synchronizing section

echo "Happy coding!"
