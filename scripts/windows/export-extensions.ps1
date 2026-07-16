$dotfilesRoot = & git -C $PSScriptRoot rev-parse --show-toplevel
$dotfilesRoot = $dotfilesRoot -replace '/', '\'

code --list-extensions | Out-File -Encoding utf8 "$dotfilesRoot\vscode\extensions.txt"
Write-Host "Extensions exported: $(Get-Content "$dotfilesRoot\vscode\extensions.txt" | Measure-Object -Line | Select-Object -ExpandProperty Lines)"