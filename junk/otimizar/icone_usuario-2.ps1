function Create-UserFolderDesktopIni {
    $userFolder = [Environment]::GetFolderPath("UserProfile")
    $desktopIniPath = Join-Path $userFolder "desktop.ini"

    $iconPath = "$HOME\scripts\images\icons\userIcon.ico"

    $iniContent = @"
[.ShellClassInfo]
IconResource=$iconPath,0
IconFile=$iconPath
IconIndex=0
"@

    Set-Content -Path $desktopIniPath -Value $iniContent -Encoding UTF8

    # Marca como arquivo de sistema e oculto (recomendado para desktop.ini)
    attrib +s +h $desktopIniPath
}

Create-UserFolderDesktopIni
