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
'alacritty'
'miktex'
'vim'
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
# elseif (-Not (Test-Path $startup_alacritty))
# {
#     $shell=New-Object -comObject WScript.Shell
#     $shortcut=$shell.CreateShortcut($startup_alacritty)
#     $shortcut.TargetPath=$alacritty
#     $shortcut.Save()
# }
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

# vim
$me=$(whoami).split("\")[1]
if ($me -eq "mn19fz"){
    $home_path=$([Environment]::GetFolderPath("MyDocuments"))
} else {
    $home_path=$($HOME)
}
$vim_path=$home_path+"\.vimrc"
$gvim_path=$home_path+"\_vimrc"
if ( Test-Path $home_path ){
    Copy-Item -Force ./win_home/vimrc $vim_path
    Copy-Item -Force ./win_home/vimrc $gvim_path
}
# if ( Test-Path $HOME/.config/vim ){
#     Remove-Item -Recurse -Force $HOME/.config/vim
# }

# Alacritty
if ($me -eq "mn19fz"){
    Copy-Item -Force ./win_home/alacritty/alacritty_mn19fz.toml `
    $HOME/AppData/Roaming/alacritty/alacritty.toml
} else {
    # Copy-Item -Recurse -Force ./win_home/alacritty $HOME/AppData/Roaming/
    Copy-Item -Force ./win_home/alacritty/alacritty.toml `
    $HOME/AppData/Roaming/alacritty/alacritty.toml
}

# PowerShell
Copy-Item -Force ./win_home/Microsoft.PowerShell_profile.ps1 $PROFILE

# YASB and Starship
$config_dir = $(ls ./win_home/config/)
for (($i=0); $config=$config_dir[$i]; $i++)
{
    Copy-Item -Force -Recurse ./win_home/config/$config $HOME/.config/
}

# Glazewm
if ($me -eq "mn19fz"){
    Copy-Item -Force ./win_home/glazewm/config_mn19fz.yaml `
    $HOME/.glzr/glazewm/config.yaml
} else {
    Copy-Item -Force ./win_home/glazewm/config.yaml `
    $HOME/.glzr/glazewm/config.yaml
}

# Okular
Copy-Item -Force -Recurse ./win_home/okular $HOME/AppData/Local/kxmlgui5/

echo ""
echo "Synchronzed all windows configurations."
echo ""
# <== Configuration synchronizing section

. $PROFILE

echo ""
echo "Happy coding!"
echo ""
