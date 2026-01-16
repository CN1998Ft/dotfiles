# ==> region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "$HOME/miniforge3/Scripts/conda.exe") {
    echo hello
    (& "$HOME/miniforge3/Scripts/conda.exe" "shell.powershell" "hook") |
    Out-String | ?{$_} | Invoke-Expression
}
#> <== endregion

# ==> Ennable plugins/addons
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (&starship init powershell)
#> <== plugins/addons

# ==> Aliases
function vim{
        nvim --clean $args
    }
if (Test-Path Alias:cd){
	Remove-Item Alias:cd -Force
	Set-Alias -Name cd -Value z
}
if (Test-Path Alias:ls){
	Remove-Item Alias:ls -Force
}
function lsa {
    eza -h --group-directories-first --icons=auto @args
}
Set-Alias -Name ls -Value lsa
#> <== Aliases
# ==> PhD Aliases
function pwe{
  cd "project";
  conda activate phd;
  clear
}
function pwen {
  cd "project";
  conda activate phd;
  clear;
  nvim
}
#> <== PhD Aliases

# ==> Powershell config
Set-PSReadLineOption -EditMode vi
#> <== Powershell config
