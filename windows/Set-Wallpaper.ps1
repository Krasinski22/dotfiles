param (
    [Parameter(Position=0, Mandatory=$true)]
    [string]$InputPath
)

function Set-Wallpaper($imagePath) {
    Add-Type @"
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@

    [Wallpaper]::SystemParametersInfo(20, 0, $imagePath, 3)
}

if ($InputPath -match '^(http|https)://') {
    # É uma URL: baixa a imagem
    $fileName = Split-Path $InputPath -Leaf
    $localPath = "$env:USERPROFILE\$fileName"
    Invoke-WebRequest -Uri $InputPath -OutFile $localPath
    Set-Wallpaper -imagePath $localPath
} else {
    # É um caminho local: resolve caminho absoluto
    $resolvedPath = Resolve-Path -Path $InputPath
    Set-Wallpaper -imagePath $resolvedPath
}
