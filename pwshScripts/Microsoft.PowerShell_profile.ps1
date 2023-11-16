# ---
# Import local function
# ---
. "$PSScriptRoot\functions.ps1"

# ---
# Import local configs
# ---
. "$PSScriptRoot\configs.ps1"

# ---
# ENV variables
# ---
$ENV:STARSHIP_CONFIG = "~/.config/starship.toml"

# ---
# Tools
# ---
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# ---
# Aliases
# ---
New-Alias which Get-Command
New-Alias vim nvim
New-Alias grep Select-String
New-Alias time Get-TimePythonScript
New-Alias makepdf ConvertTo-PDF
New-Alias pullall Optimize-Git

# ---
# OS-specific settings
# ---
switch ($PSVersionTable.OS) {
    { $_ -like "Microsoft Windows*" } {
        . "$PSScriptRoot\windows.ps1"
    }
    { $_ -like "Darwin*" } {
        . "$PSScriptRoot\unix.ps1"
    }
    { $_ -like "Linux*" } {
        . "$PSScriptRoot\unix.ps1"
    }
    default {
        Write-Error "Unknown OS."
        return
    }
}

# ---
# Modules
# ---
Import-Module -Name Terminal-Icons
Import-Module -Name EnvLoader
Import-Module -Name Pansies
Import-Module -Name Pode

# ---
# For auto-completion
# ---
Import-Module posh-cargo

Import-Module posh-dotnet

Import-Module DockerCompletion

Import-Module posh-git

Import-Module PSKubectlCompletion

Import-Module npm-completion
