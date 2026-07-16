$dotfilesRoot = & git -C $PSScriptRoot rev-parse --show-toplevel
$dotfilesRoot = $dotfilesRoot -replace '/', '\'

$settingsPath = "$dotfilesRoot\vscode\settings.json"
$settingsTemplatePath = "$dotfilesRoot\vscode\settings.template.json"
$snippetsPath = "$dotfilesRoot\vscode\snippets"

$filesToLink = @(
    "settings.json",
    "keybindings.json"
)

$vscodeTarget = "$env:APPDATA\Code\User"

if (-not (Test-Path $settingsPath)) {
    Copy-Item $settingsTemplatePath -Destination $settingsPath
    Write-Host "Copied settings.template.json to settings.json"
} else {
    Write-Host "Copied template of settings.json already exists, skipping copy"
}

foreach ($file in $filesToLink) {
    $target = "$vscodeTarget\$file"

    if (Test-Path $target) {
        if (-not (Get-Item $target).LinkType) {
            Move-Item $target "$target.bak"
            Write-Host "Backed up existing $file to $file.bak"
        } else {
            Write-Host "$file already exists as a symbolic link, skipping backup"
        }
    } else {
        Write-Host "$file does not exist yet, creating symlink"
    }

    New-Item -ItemType SymbolicLink -Path $target -Target "$dotfilesRoot\vscode\$file" -Force | Out-Null
}

# Snippets folder
$snippetsTarget = "$vscodeTarget\snippets"

$needsCreate = $true

if (Test-Path $snippetsTarget) {
    $item = Get-Item $snippetsTarget
    if (-not $item.LinkType) {
        $backupName = "$snippetsTarget.bak.$(Get-Date -Format 'yyyy-MM-dd-HH-mm-ss')"
        Move-Item $snippetsTarget $backupName
        Write-Host "Backed up existing snippets folder to $backupName"
    } elseif ($item.Target -eq $snippetsPath) {
        Write-Host "Snippets junction already points to the correct target, skipping"
        $needsCreate = $false
    } else {
        Write-Host "Snippets junction points elsewhere ($($item.Target)), recreating"
        Remove-Item $snippetsTarget -Force
    }
}

if ($needsCreate) {
    New-Item -ItemType Junction -Path $snippetsTarget -Target $snippetsPath | Out-Null
    Write-Host "Created snippets junction"
}

Write-Host ""
Write-Host "Installing VS Code extensions from extensions.txt"
Get-Content "$dotfilesRoot\vscode\extensions.txt" | ForEach-Object {
    code --install-extension $_
    Write-Host ""
}
Write-Host "VS Code extensions installation complete"