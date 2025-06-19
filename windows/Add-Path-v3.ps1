param (
    [Parameter(Mandatory = $true)]
    [string]$NewPath
)

Set-StrictMode -Version Latest

function Normalize-Path([string]$Path) {
    return $Path.Trim().Trim('"').TrimEnd('\').ToLower()
}

function Add-To-Path([string]$PathToAdd, [ref]$NewEntries, [string[]]$ExistingPaths) {
    $Normalized = Normalize-Path $PathToAdd

    if ($ExistingPaths -contains $Normalized) {
        Write-Output "Já existe no PATH: $PathToAdd"
        return
    }

    if (-Not (Test-Path $PathToAdd)) {
        Write-Warning "$PathToAdd não existe no sistema de arquivos."
    }

    $NewEntries.Value += $PathToAdd
    Write-Output "Adicionado: $PathToAdd"
}

# Pega o PATH atual do usuário
$oldPath = [Environment]::GetEnvironmentVariable("Path", "User")
if (-not $oldPath) { $oldPath = "" }

$pathParts = $oldPath -split ';' | ForEach-Object { Normalize-Path $_ }
$newPathList = @()

# Verifica se é arquivo de caminhos ou caminho único
if (Test-Path $NewPath -PathType Leaf) {
    Get-Content $NewPath | ForEach-Object {
        if ($_ -and $_.Trim() -ne '') {
            Add-To-Path $_ ([ref]$newPathList) $pathParts
        }
    }
} else {
    Add-To-Path $NewPath ([ref]$newPathList) $pathParts
}

# Atualiza PATH se necessário
if ($newPathList.Count -gt 0) {
    $combined = @($oldPath.TrimEnd(';')) + $newPathList
    $newPathValue = ($combined -join ';').Trim(';')
    [Environment]::SetEnvironmentVariable("Path", $newPathValue, "User")
}

# Debug: mostra PATH final
$finalPath = [Environment]::GetEnvironmentVariable("Path", "User")
Write-Output "`nPATH final do usuário:"
Write-Output $finalPath
