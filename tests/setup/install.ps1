git clone -q https://github.com/PowerShell/DscResource.Tests

Import-Module -Name "$env:APPVEYOR_BUILD_FOLDER\DscResource.Tests\AppVeyor.psm1"
Invoke-AppveyorInstallTask

[string[]]$PowerShellModules = @("Pester", 'posh-git', 'psake', 'poshspec', 'PSScriptAnalyzer')

$ModuleManifest = Test-ModuleManifest .\$($env:RepoName).psd1 -ErrorAction SilentlyContinue
write-output $env:RepoName
write-output $env:RepoName
write-output $env:RepoName
$repoRequiredModules = $ModuleManifest.RequiredModules.Name
$PowerShellModules += $repoRequiredModules

# This section is taken care of by Invoke-AppVeyorInstallTask
<#[string[]]$PackageProviders = @('NuGet', 'PowerShellGet')

# Install package providers for PowerShell Modules
ForEach ($Provider in $PackageProviders) {
    If (!(Get-PackageProvider $Provider -ErrorAction SilentlyContinue)) {
        Install-PackageProvider $Provider -Force -ForceBootstrap -Scope CurrentUser
    }
}#>

# Install the PowerShell Modules
ForEach ($Module in $PowerShellModules) {
    If (!(Get-Module -ListAvailable $Module -ErrorAction SilentlyContinue)) {
        Install-Module $Module -Scope CurrentUser -Force -Repository PSGallery
    }
    
    Import-Module $Module
}
