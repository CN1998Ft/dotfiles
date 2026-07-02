# This is the PowerShell script for updating the config on Windows.

# Move to the script dir for operation.
cd $PSScriptRoot
echo "I am currently in $(pwd)"

# ==> Scoop related section
# Check if scoop.sh is installed and add extras to bucket
echo ""
echo "Checking if scoop is installed"
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
'alacritty'
'miktex'
'pandoc'
'glow'
'mpv'
'yt-dlp'
'yazi'
'7zip'
'jq'
'poppler'
'resvg'
'imagemagick'
'okular'
'powertoys'
'pwsh'
'luajit'
'nodejs'
'psmux'
'cmake'
'make'
'clink'
)

clink autorun install

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
$startup_glazewm=`
"$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/glazewm.lnk"
$glazewm="$HOME/scoop/apps/glazewm/current/glazewm.exe"
$startup_alacritty=`
"$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/alacritty.lnk"
$alacritty="$HOME/scoop/apps/alacritty/current/alacritty.exe"
if ((-Not (Test-Path $startup_glazewm)) -and `
    (-Not (Test-Path $startup_alacritty)))
{
    $shell=New-Object -comObject WScript.Shell
    $shortcut=$shell.CreateShortcut($startup_glazewm)
    $shortcut.TargetPath=$glazewm
    $shortcut.Save()

    $shell=New-Object -comObject WScript.Shell
    $shortcut=$shell.CreateShortcut($startup_alacritty)
    $shortcut.TargetPath=$alacritty
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
rm -Force -Recurse $HOME/AppData/Local/nvim | Out-Null
if (-Not (Test-path $HOME/AppData/Local/nvim))
{
	mkdir $HOME/AppData/Local/nvim
}
Copy-Item -Recurse -Force ./c_config/nvim $HOME/AppData/Local/

# vim
$me=$(whoami).split("\")[1]
if ($me -eq "mn19fz"){
    $home_path=$([Environment]::GetFolderPath("MyDocuments"))
} else {
    $home_path=$($HOME)
}
$vim_path=$home_path+"\.vimrc"
if ( Test-Path $home_path ){
    Copy-Item -Force ./win_home/vimrc $vim_path
}

# Alacritty
rm -Force -Recurse $HOME/AppData/Roaming/alacritty | Out-Null
if (-Not (Test-path $HOME/AppData/Roaming/alacritty))
{
	mkdir $HOME/AppData/Roaming/alacritty
}
Copy-Item -Force ./win_home/alacritty/alacritty.toml `
$HOME/AppData/Roaming/alacritty/alacritty.toml
Copy-Item -Force ./win_home/alacritty/alacritty_c.toml `
$HOME/AppData/Roaming/alacritty/alacritty_c.toml

# PowerShell
Copy-Item -Force ./win_home/Microsoft.PowerShell_profile.ps1 $PROFILE

# YASB and Starship
rm -Force -Recurse "$HOME/.config" | Out-Null
if (-Not (Test-Path "$HOME/.config"))
{
    mkdir "$HOME/.config"
}
Copy-Item -Recurse -Force ./win_home/config/* "$HOME/.config/"


# Glazewm
rm -Force -Recurse $HOME/.glzr/glazewm | Out-Null
if (-Not (Test-path $HOME/.glzr/glazewm))
{
	mkdir $HOME/.glzr/glazewm
}
if ($me -eq "mn19fz"){
    Copy-Item -Force ./win_home/glazewm/config_mn19fz.yaml `
    $HOME/.glzr/glazewm/config.yaml
} else {
    Copy-Item -Force ./win_home/glazewm/config.yaml `
    $HOME/.glzr/glazewm/config.yaml
}

# Okular
Copy-Item -Force -Recurse ./win_home/okular $HOME/AppData/Local/kxmlgui5/

# psmux
Copy-Item -Force ./win_home/tmux.conf $HOME/.tmux.conf

# Clink
rm -Force -Recurse $env:LOCALAPPDATA/clink | Out-Null
if (-Not (Test-Path $env:LOCALAPPDATA/clink))
{
    mkdir $env:LOCALAPPDATA/clink
}
Copy-Item -Force ./win_home/clink/* $env:LOCALAPPDATA/clink/

echo ""
echo "Synchronzed all windows configurations."
echo ""
# <== Configuration synchronizing section

echo ""
echo "Happy coding!"
echo ""
