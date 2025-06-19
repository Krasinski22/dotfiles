param(
    [Parameter(Mandatory=$true)]
    [string]$NewPath
)

# Verifica se o diretório existe, se não existir, cria
if (-not (Test-Path -Path $NewPath)) {
    New-Item -ItemType Directory -Path $NewPath -Force
}

$DownloadsGUID = "{374DE290-123F-4565-9164-39C4925E467B}"

# Atualiza o registro com o novo caminho
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" `
                 -Name $DownloadsGUID `
                 -Value $NewPath

# Reinicia o Explorer para aplicar as alterações
Stop-Process -Name explorer -Force

Write-Host "Diretório de downloads alterado para: $NewPath"