oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/M365Princess.omp.json" | Invoke-Expression

function poweroff {
    Stop-Computer -Force
}

#function lightWin {
#    start-process start-process -filepath $HOME\AppData\Local\Microsoft\Windows\Themes\light\light.theme
#}


#function darkWin {
#    start-process start-process -filepath $HOME\AppData\Local\Microsoft\Windows\Themes\dark\dark.theme
#}


Function yt {
    param (
        [string]$Link,
        [string]$Directory = "$env:USERPROFILE",
        [string]$Mode = "default"  # "default" ou "normal" ou "mp3"
    )

    ### Tratamento do diretório (igual à versão anterior) ###
    if ($Directory -match '^\.') {
        $Directory = [System.IO.Path]::Combine((Get-Location).Path, $Directory)
    }
    $Directory = [System.IO.Path]::GetFullPath($Directory.Trim('"'))
    $Directory = [System.IO.Path]::TrimEndingDirectorySeparator($Directory) + [System.IO.Path]::DirectorySeparatorChar
    if (-not (Test-Path $Directory)) {
        New-Item -ItemType Directory -Path $Directory -Force | Out-Null
    }
    $outputPath = [System.IO.Path]::Combine($Directory, '%(title)s.%(ext)s')

    ### Modo de download ###
    if ($Mode -eq "normal") {
        # Modo normal (como antes)
        yt-dlp $Link -o $outputPath -f mp4
    }
    elseif ($Mode -eq "mp3") {
        yt-dlp $Link -o $outputPath -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0
    }
    else {
        # Modo padrão aprimorado (MP4 + metadados + capítulos)
        yt-dlp $Link -o $outputPath `
            -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" `
            --embed-metadata `
            --embed-chapters `
            --merge-output-format mp4
    }
}


Function Git-Push {
    git add .
    git commit -m "b"
    git push origin main
}

$wtSettings = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"


Function Import-Task {
    param (
        [string]$TaskXmlPath,
        [string]$TaskName
    )
    Register-ScheduledTask -Xml (Get-Content $TaskXmlPath | Out-String) -TaskName $TaskName
}


function touch($file) { "" | Out-File $file -Encoding ASCII }

function which { 
    Get-Command $args | Select-Object -ExpandProperty Source 
}


function iconset {
    Start-Process rundll32 -ArgumentList "shell32.dll,Control_RunDLL desk.cpl,,0"
}


function winutil {
    irm "https://christitus.com/win" | iex
}

function reload-profile {
    . $profile
}

function unzip ($file) {
    Write-Output("Extracting", $file, "to", $pwd)
    $fullFile = Get-ChildItem -Path $pwd -Filter $file | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function df {
    get-volume
}

function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

#function pkill($name) {
#    Get-Process -Name $name -ErrorAction SilentlyContinue | Stop-Process -Force
#}


function pgrep($name) {
    Get-Process $name
}

function head {
  param($Path, $n = 10)
  Get-Content $Path -Head $n
}

function tail {
  param($Path, $n = 10, [switch]$f = $false)
  Get-Content $Path -Tail $n -Wait:$f
}

function ch {
    # Clear history
    $path = (Get-PSReadlineOption).HistorySavePath
    Clear-Content $path
    Write-Host "History has been deleted"
    Invoke-Command { & "pwsh.exe" -nolog } -NoNewScope
}

function ln {
    param (
        [Parameter(Mandatory=$true)][string]$target,
        [Parameter(Mandatory=$true)][string]$link
    )
    
    # Cria um link simbólico (como no Unix)
    New-Item -ItemType SymbolicLink -Path $link -Target $target
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
