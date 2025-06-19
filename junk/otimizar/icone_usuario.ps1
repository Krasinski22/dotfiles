$userIconPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{59031a47-3f72-44a7-89c5-5595fe6b30ee}\DefaultIcon"

# Cria a chave se não existir
If (-not (Test-Path $userIconPath)) {
    New-Item -Path $userIconPath -Force | Out-Null
}

# Define o ícone como valor padrão da chave
Set-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{59031a47-3f72-44a7-89c5-5595fe6b30ee}\DefaultIcon" -Value "C:\icons\Steins;Gate\Okabe 009.ico"
