$DataFile   = Import-PowerShellDataFile .\MSFTNetworking.Tools.psd1 -ErrorAction SilentlyContinue
$TestModule = Test-ModuleManifest       .\MSFTNetworking.Tools.psd1 -ErrorAction SilentlyContinue

Describe 'MSFTNetwork.Tools-Manifest' {
    Context Validation {
        It "[Import-PowerShellDataFile] - MSFTNetworking.Tools.psd1 is a valid PowerShell Data File" {
            $DataFile | Should Not BeNullOrEmpty
        }

        It "[Test-ModuleManifest] - MSFTNetworking.Tools.psd1 should pass the basic test" {
            $TestModule | Should Not BeNullOrEmpty
        }

        It "Should specify 3 modules" {
            ($TestModule).RequiredModules.Count | Should BeGreaterThan 2
        }

        'DataCenterBridging', 'VMNetworkAdapter', 'SoftwareTimestamping' | ForEach-Object {
            It "Should contain the $_ Module" {
                $_ -in ($TestModule).RequiredModules.Name | Should be $true
            }
        }
    }
}
