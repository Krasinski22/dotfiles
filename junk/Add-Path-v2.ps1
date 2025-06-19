param (
    [Parameter(Mandatory=$true)]
    [string]$NewPath
)

# Normaliza o novo caminho
$NewPath = $NewPath.TrimEnd('\').Trim()
$NormalizedNewPath = $NewPath.ToLower()

# Pega o PATH atual do usuário
$oldPath = [Environment]::GetEnvironmentVariable("Path", "User")
$pathParts = $oldPath -split ';' | ForEach-Object { $_.Trim().TrimEnd('\').ToLower() }

# Verifica se já existe
if ($pathParts -contains $NormalizedNewPath) {
    Write-Output "Já existe no PATH: $NewPath"
    return
}

# (Opcional) Verifica se o caminho realmente existe no sistema de arquivos
if (-Not (Test-Path $NewPath)) {
    Write-Warning "$NewPath não existe no sistema de arquivos."
}

# Monta novo PATH
$newPathValue = ($oldPath.TrimEnd(';') + ';' + $NewPath).Trim(';')

# Atualiza PATH do usuário
[Environment]::SetEnvironmentVariable("Path", $newPathValue, "User")
Write-Output "Adicionado: $NewPath"
