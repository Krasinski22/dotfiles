oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/M365Princess.omp.json" | Invoke-Expression

function Show-InputDevices {
    # Corrected line: The entire argument string for rundll32 is enclosed in double quotes.
    rundll32 "Shell32,Control_RunDLL input.dll,,{C07337D3-DB2C-4D0B-9A93-B722A6C106E2}"
}


function ff {
    [CmdletBinding()]
    param (
        # O nome do arquivo/padrão é o único parâmetro posicional e é mandatório
        [Parameter(Position=0, Mandatory=$true)]
        [string]$FileName,

        # O diretório é sempre nomeado, é opcional, e agora aceita -d como alias!
        [Parameter(HelpMessage='O diretório para iniciar a busca. Se omitido, a busca começa na raiz da unidade atual.')]
        [Alias('d')] # <--- AQUI ESTÁ A MUDANÇA
        [string]$Directory
    )

    # Variáveis internas para a busca
    $searchFileName = $FileName
    $searchDirectory = $Directory

    # --- Lógica de determinação do diretório de busca ---

    # Se o parâmetro -Directory (ou -d) NÃO foi fornecido, determinamos a raiz da unidade atual
    if ([string]::IsNullOrEmpty($Directory)) {
        try {
            $currentPath = (Get-Location).Path
            # Extrai a letra do drive e forma o caminho raiz (ex: C:\)
            $driveLetter = ($currentPath.Split(':', 2)[0]) + ":"
            $searchDirectory = $driveLetter + "\"
            Write-Host "Pesquisando '$searchFileName' na raiz da unidade atual ($searchDirectory)..." -ForegroundColor Cyan
        }
        catch {
            # Fallback seguro para C:\ se não conseguir determinar a unidade atual
            $searchDirectory = "C:\"
            Write-Warning "Não foi possível determinar a raiz da unidade atual. Usando C:\ como padrão para a busca de '$searchFileName'."
        }
    }
    else {
        # Se o parâmetro -Directory (ou -d) FOI fornecido, usamos ele
        Write-Host "Pesquisando '$searchFileName' em '$searchDirectory'..." -ForegroundColor Cyan
    }

    # --- Execução da busca ---
    try {
        # Verifica se o diretório de busca existe
        if (-not (Test-Path $searchDirectory -PathType Container)) {
            Write-Error "O diretório '$searchDirectory' não existe ou não pôde ser acessado."
            return # Sai da função se o diretório não existir
        }

        # Realiza a busca
        # Usamos Where-Object -like para maior flexibilidade na comparação do nome do arquivo
        Get-ChildItem -Path $searchDirectory -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Name -like $searchFileName } | ForEach-Object {
            # Exibe o caminho completo do arquivo encontrado
            Write-Output $_.FullName
        }
    }
    catch {
        # Captura erros gerais de execução do Get-ChildItem, como permissões negadas em subdiretórios.
        Write-Error "Ocorreu um erro ao procurar em '$searchDirectory': $($_.Exception.Message)"
    }
}


function trash($path) {
    $fullPath = (Resolve-Path -Path $path).Path

    if (Test-Path $fullPath) {
        $item = Get-Item $fullPath

        if ($item.PSIsContainer) {
          # Handle directory
            $parentPath = $item.Parent.FullName
        } else {
            # Handle file
            $parentPath = $item.DirectoryName
        }

        $shell = New-Object -ComObject 'Shell.Application'
        $shellItem = $shell.NameSpace($parentPath).ParseName($item.Name)

        if ($item) {
            $shellItem.InvokeVerb('delete')
            Write-Host "Item '$fullPath' has been moved to the Recycle Bin."
        } else {
            Write-Host "Error: Could not find the item '$fullPath' to trash."
        }
    } else {
        Write-Host "Error: Item '$fullPath' does not exist."
    }
}

function poweroff {
    Stop-Computer -Force
}

#function lightWin {
#    start-process start-process -filepath $HOME\AppData\Local\Microsoft\Windows\Themes\light\light.theme
#}


#function darkWin {
#    start-process start-process -filepath $HOME\AppData\Local\Microsoft\Windows\Themes\dark\dark.theme
#}


function git-cred-store {
  git config --global credential.helper store
}

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
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
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

function trash($path) {
    $fullPath = (Resolve-Path -Path $path).Path

    if (Test-Path $fullPath) {
        $item = Get-Item $fullPath

        if ($item.PSIsContainer) {
          # Handle directory
            $parentPath = $item.Parent.FullName
        } else {
            # Handle file
            $parentPath = $item.DirectoryName
        }

        $shell = New-Object -ComObject 'Shell.Application'
        $shellItem = $shell.NameSpace($parentPath).ParseName($item.Name)

        if ($item) {
            $shellItem.InvokeVerb('delete')
            Write-Host "Item '$fullPath' has been moved to the Recycle Bin."
        } else {
            Write-Host "Error: Could not find the item '$fullPath' to trash."
        }
    } else {
        Write-Host "Error: Item '$fullPath' does not exist."
    }
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
