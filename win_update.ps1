# This is the PowerShell script for updating the config on Windows.
echo "I am currently in $(pwd)"

# ==> Scoop related section
# Check if scoop.sh is installed and add extras to bucket
echo ""
echo "Checking is scoop is installed"
echo ""
if (-Not (get-command scoop))
{
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# Added buckets extras if not added
echo ""
echo "Check the status of scoop and buckets"
echo ""
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
'Alacritty'
)

# Install mising packages if 
$installed=$(ls $HOME/scoop/apps)
for (($i=0); $package = $packages[$i]; $i++)
{
    if (-Not ($installed -contains "$package"))
    {
        echo ""
        echo "Installing Package: $package"
        echo ""
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
$startup_glazewm="$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/glazewm.lnk"
$glazewm="$HOME/scoop/apps/glazewm/current/glazewm.exe"
if (-Not (Test-Path $startup_glazewm))
{
    $shell=New-Object -comObject WScript.Shell
    $shortcut=$shell.CreateShortcut($startup_glazewm)
    $shortcut.TargetPath=$glazewm
    $shortcut.Save()
}
else
{
    echo ""
	echo "Not extra startup apps needed to add."
    echo ""
}


# <== Added startup app section

# ==> Configuration synchronizing section
# Start synchronize configuration files
echo ""
echo "Synchronizing Windows configuration"
echo ""

# Neovim
Copy-Item -Recurse -Force ./win_home/nvim $HOME/AppData/Local/
Copy-Item -Recurse -Force ./win_home/alacritty $HOME/AppData/

# PowerShell
Copy-Item -Force ./win_home/Microsoft.PowerShell_profile.ps1 $PROFILE

# YASB and Starship and vim
$config_dir = $(ls ./win_home/config/)
for (($i=0); $config=$config_dir[$i]; $i++)
{
    Copy-Item -Force -Recurse ./win_home/config/$config $HOME/.config/
}

# Glazewm
Copy-Item -Force -Recurse ./win_home/glazewm $HOME/.glzr/

echo ""
echo "Synchronzed all windows configurations."
echo ""
# <== Configuration synchronizing section

. $PROFILE

echo ""
echo "Happy coding!"
echo ""
