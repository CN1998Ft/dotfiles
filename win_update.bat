@echo off
setlocal enabledelayedexpansion

:: Move to parent dir of the batch file
cd /D "%~dp0"
echo [I am currently in %cd%]

:: Check if scoop is installed
echo [Checking if scoop is installed]

where scoop >nul 2>nul
if %errorlevel% neq 0 (
    echo !!!!! scoop is not installed !!!!!
    powershell -NoProfile -ExecutionPolicy Bypass -Command "irm get.scoop.sh | iex"
    call scoop install git
)

:: Add buckets extra if not added
if not exist "%USERPROFILE%\scoop\buckets\extras" (
    call scoop bucket add extras
)

set package=bat cloc eza fastfetch fd ffmpeg fzf git glazewm lazygit neovim
set package1=ripgrep starship yasb zoxide alacritty miktex pandoc glow mpv
set package2=jq poppler resvg imagemagick pwsh luajit nodejs
set package3=clink yt-dlp yazi 7zip psmux neovide okular draw.io

for %%p in (%package% %package1% %package2% %package3%) do (
    if not exist "%USERPROFILE%\scoop\apps\%%p" (
        echo installing Package: [%%p]
	call scoop install %%p
    )
)

:: <== Configuration synchronizing section
echo [Synchronising configuration files]

:: Neovim
if exist "%LOCALAPPDATA%\nvim" rmdir /S /Q "%LOCALAPPDATA%\nvim"
mkdir "%LOCALAPPDATA%\nvim"
xcopy /S /I /Y ".\c_config\nvim" "%LOCALAPPDATA%\nvim" >nul 2>nul

:: vim
if %USERNAME% == mn19fz (
    copy /Y .\win_home\vimrc M:\.vimrc >nul 2>nul
) else (
    copy /Y .\win_home\vimrc %USERPROFILE%\.vimrc >nul 2>nul
)

:: alacritty
if exist "%APPDATA%\alacritty" rmdir /S /Q "%APPDATA%\alacritty"
mkdir "%APPDATA%\alacritty"
xcopy /S /I /Y ".\win_home\alacritty" "%APPDATA%\alacritty" >nul 2>nul

:: Windows Terminal
copy /Y ".\win_home\wt\settings.json" "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" >nul 2>nul

:: .config
if exist "%USERPROFILE%\.config" rmdir /S /Q "%USERPROFILE%\.config" >nul 2>nul
mkdir "%USERPROFILE%\.config" >nul 2>nul
xcopy /S /I /Y ".\win_home\config" "%USERPROFILE%\.config" >nul 2>nul

:: glazewm
if exist "%USERPROFILE%\.glzr\glazewm" rmdir /S /Q "%USERPROFILE%\.glzr\glazewm"
if not exist "%USERPROFILE%\.glzr" mkdir "%USERPROFILE%\.glzr"
mkdir "%USERPROFILE%\.glzr\glazewm"
if %USERNAME%==mn19fz (
    copy /Y ".\win_home\glazewm\config_mn19fz.yaml" ^
    "%USERPROFILE%\.glzr\glazewm\config.yaml" >nul 2>nul
) else (
    copy /Y ".\win_home\glazewm\config.yaml"  "%USERPROFILE%\.glzr\glazewm" ^
    >nul 2>nul
)
:: Add glazewm to startup
del /S /Q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\*" >nul 2>nul
echo @echo off > glazewm.bat
echo set __COMPAT_LAYER=RunAsInvoker >> glazewm.bat
echo start "" "%USERPROFILE%\scoop\apps\glazewm\current\glazewm.exe" >> glazewm.bat
if %USERNAME%==mn19fz (
    set glazewm_bat_path="%USERPROFILE%\Desktop\glazewm.bat"
) else (
    set glazewm_bat_path="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\glazewm.bat"
)
move /Y ".\glazewm.bat" %glazewm_bat_path% >nul 2>nul

:: Okular
if exist "%LOCALAPPDATA%\kxmlgui5" rmdir /S /Q "%LOCALAPPDATA%\kxmlgui5" 2>nul
if not exist "%LOCALAPPDATA%\kxmlgui5" mkdir "%LOCALAPPDATA%\kxmlgui5" 2>nul
if not exist "%LOCALAPPDATA%\kxmlgui5\okular" mkdir "%LOCALAPPDATA%\kxmlgui5\okular" 2>nul
xcopy /S /I /Y ".\win_home\okular" "%LOCALAPPDATA%\kxmlgui5\okular" >nul 2>nul

:: psmux
copy /Y ".\win_home\tmux.conf" "%USERPROFILE%\.tmux.conf" >nul 2>nul


:: Clink
if exist "%LOCALAPPDATA%\clink" rmdir /s /q "%LOCALAPPDATA%\clink" >nul 2>nul
mkdir "%LOCALAPPDATA%\clink" 2>nul
xcopy /S /I /Y ".\win_home\clink" "%LOCALAPPDATA%\clink" >nul 2>nul
call clink set fzf.exe_location "%USERPROFILE%\scoop\apps\fzf\current\fzf.exe" >nul 2>nul
call clink set fzf.default_bindings true >nul 2>nul
call clink set match.expand_envvars True >nul 2>nul
call clink autorun install >nul 2>nul

echo [Synchronised all windows configurations.]
:: <== Configuration synchronizing section

echo [Happy coding!]
