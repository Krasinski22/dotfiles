$myuser = $env:username

function Safe-Symlink {
    param (
        [string]$LinkPath,
        [string]$TargetPath
    )

    # Verifica se o destino existe
    if (-Not (Test-Path $TargetPath)) {
        Write-Error "ERRO: O caminho de destino NÃO existe: $TargetPath"
        exit 1
    }

    # Cria o diretório pai do link, se necessário
    $LinkParent = Split-Path $LinkPath -Parent
    if (-Not (Test-Path $LinkParent)) {
        Write-Host "Diretório pai do link não encontrado. Criando: $LinkParent"
        New-Item -ItemType Directory -Path $LinkParent -Force | Out-Null
    }

    # Remove link ou pasta existente no caminho do link
    if (Test-Path $LinkPath) {
        Write-Host "Removendo: $LinkPath"
        Remove-Item -Path $LinkPath -Force -Recurse
    }

    Write-Host "Criando link: $LinkPath -> $TargetPath"
    New-Item -ItemType SymbolicLink -Path $LinkPath -Target $TargetPath | Out-Null
}


# Verifica se o script está sendo executado como administrador
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Run as admin"
    exit
}

Safe-Symlink "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" "$HOME\scripts\windows-terminal\settings.json"

# Safe-Symlink "$HOME\AppData\Local\Google\Chrome" "D:\software\chrome-data"
# Safe-Symlink "$HOME\AppData\Roaming\Telegram Desktop\tdata" "D:\software\telegram-data"
# Safe-Symlink "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\my-software" "D:\software\"


# Safe-Symlink "$HOME\AppData\Local\AutoDarkMode" "$HOME\scripts\autodarkmode"
# Safe-Symlink "$HOME\AppData\Roaming\AutoDarkMode" "$HOME\scripts\autodarkmode"

Safe-Symlink "$HOME\AppData\Roaming\mpv\input.conf" "$HOME\scripts\mpv\input.conf"
Safe-Symlink "$HOME\AppData\Roaming\mpv\mpv.conf" "$HOME\scripts\mpv\mpv.conf"

Safe-Symlink "$HOME\AppData\Roaming\FlowLauncher\Settings" "$HOME\scripts\FlowLauncher\Settings"

Safe-Symlink "$HOME\.glzr\glazewm\config.yaml" "$HOME\scripts\glazewm\config.yaml"

Safe-Symlink "$HOME\.config\yasb\config.yaml" "$HOME\scripts\yasb\config.yaml"
Safe-Symlink "$HOME\.config\yasb\styles.css" "$HOME\scripts\yasb\styles.css"

Safe-Symlink "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" "$HOME\scripts\powershell\Microsoft.PowerShell_profile.ps1"

Safe-Symlink "$HOME\.wezterm.lua" "$HOME\scripts\wezterm\wezterm-windows.lua" 

Safe-Symlink "$HOME\AppData\Roaming\DS4Windows" "$HOME\scripts\ds4windows"


#Safe-Symlink "$HOME\AppData\Roaming\Sublime Text\Packages\$myuser\Default (Windows).sublime-keymap" "$HOME\scripts\sublime-keymap.sublime-keymap"

#Safe-Symlink "$HOME\AppData\Roaming\Sublime Text\Packages\$myuser\PowerShell.sublime-settings" "$HOME\scripts\Sublime-PowerShell.sublime-settings"

#Safe-Symlink "$HOME\AppData\Roaming\Sublime Text\Packages\$myuser\Preferences.sublime-settings" "$HOME\scripts\Preferences.sublime-settings"

#Safe-Symlink "$HOME\AppData\Roaming\Sublime Text\Packages\$myuser\Package Control.sublime-settings" "$HOME\scripts\Package Control.sublime-settings"

Safe-Symlink "$HOME\AppData\Roaming\Sublime Text\Packages\User\" "$HOME\scripts\sublime\User"

Safe-Symlink "$HOME\monitors.cfg" "$HOME\scripts\monitors.cfg"