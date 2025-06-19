function Set-DriveIcon {
    param (
        [string]$DriveLetter,
        [string]$IconPath
    )

    $basePath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\DriveIcons"
    $regPath = "$basePath\$DriveLetter\DefaultIcon"

    # Garante que a hierarquia exista
    if (-not (Test-Path "$basePath\$DriveLetter")) {
        New-Item -Path "$basePath\$DriveLetter" -Force | Out-Null
    }

    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    # Define o ícone
    Set-ItemProperty -Path $regPath -Name '(Default)' -Value $IconPath
}


function Set-ComputerIcon {
    Set-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\DefaultIcon" `
             -Value "$HOME\scripts\images\icons\computer.ico"
}



function Set-RecycleBinIcons {
    # full recycle bin icon
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" `
                     -Name "full" `
                     -Value "$HOME\scripts\images\icons\recycle-bin-full-miku.ico"

    # empty recycle bin icon
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" `
                     -Name "empty" `
                     -Value "$HOME\scripts\images\icons\recycle-bin-empty-miku.ico"
}



function Set-UserFolderIcon {
    $userIconPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{59031a47-3f72-44a7-89c5-5595fe6b30ee}\DefaultIcon"

    # create key if it doesn't exist
    if (-not (Test-Path $userIconPath)) {
        New-Item -Path $userIconPath -Force | Out-Null
    }

    Set-Item -Path $userIconPath -Value "$HOME\scripts\images\icons\userIcon.ico"
}

function Set-UserFolderIconDesktopIni {
        $userFolder = [Environment]::GetFolderPath("UserProfile")
    $desktopIniPath = Join-Path $userFolder "desktop.ini"

    $iconPath = "$HOME\scripts\images\icons\userIcon.ico"

    $iniContent = @"
        [.ShellClassInfo]
        IconResource=$iconPath,0
        IconFile=$iconPath
        IconIndex=0
"@.Trim()

    Set-Content -Path $desktopIniPath -Value $iniContent -Encoding UTF8

    # Marca como arquivo de sistema e oculto
    attrib +s +h $desktopIniPath
}



Set-ComputerIcon
Set-RecycleBinIcons
Set-UserFolderIcon
Set-UserFolderIconDesktopIni
Set-DriveIcon -DriveLetter 'C' -IconPath "$HOME\scripts\images\icons\c-drive.ico"
Set-DriveIcon -DriveLetter 'D' -IconPath "$HOME\scripts\images\icons\d-drive.ico"





# reload explorer
Stop-Process -Name explorer -Force
Start-Process explorer.exe
