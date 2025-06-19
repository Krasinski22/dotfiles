param (
    [Parameter(Mandatory=$true)]
    [string]$NewPath
)

# Remove barras finais
$NewPath = $NewPath.TrimEnd('\')

# Pega o PATH atual do usuário
$oldPath = [Environment]::GetEnvironmentVariable("Path", "User")

# Verifica se o caminho já está presente (case-insensitive)
if ($oldPath.Split(';') -notcontains $NewPath) {
    $newPathValue = "$oldPath;$NewPath"
    [Environment]::SetEnvironmentVariable("Path", $newPathValue, "User")
    Write-Output "Adicionado: $NewPath"
} else {
    Write-Output "Já existe no PATH: $NewPath"
}
