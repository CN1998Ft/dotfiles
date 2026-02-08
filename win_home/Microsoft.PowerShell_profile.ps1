# ==> region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "$HOME/miniforge3/Scripts/conda.exe") {
    (& "$HOME/miniforge3/Scripts/conda.exe" "shell.powershell" "hook") |
    Out-String | ?{$_} | Invoke-Expression
}
#> <== endregion

# ==> Ennable plugins/addons
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (&starship init powershell)
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
#> <== plugins/addons

# ==> Aliases
function zd{
        if ($args.Count -eq 0){
                Set-Location
            }
        elseif(Test-Path -Path $args){
                Set-Location @args
            }
        else{
                $pwd_1="$(pwd)"
                z @args
                $pwd_2="$(pwd)"
                if ($pwd_1 -ne $pwd_2){
                    Write-Host -NoNewline "`u{F17A9}"
                    echo $pwd_2
                    }
                else {
                    Write-Host "Error: Directory not found"
                    }
            }
    }
function openf{
    $fzf_in="$(fzf)"
    if (($fzf_in -ne $null) -and ($fzf_in -ne '')){
        echo $fzf_in
        Invoke-Item $fzf_in
    }
}
if (Test-Path Alias:cd){
	Remove-Item Alias:cd -Force
	Set-Alias -Name cd -Value zd
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
  conda activate phd
}
function pwen {
  cd "project";
  conda activate phd;
  nvim
}
#> <== PhD Aliases

# ==> Powershell config
# Set-PSReadLineOption -EditMode vi
#> <== Powershell config
