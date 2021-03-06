BeforeDiscovery {
    $ThisRoot = Split-Path $PSScriptRoot -Parent
    #Requires -Modules @{ModuleName="Pester";ModuleVersion="5.1.0"}
    Remove-Module PSChickfilA -ErrorAction SilentlyContinue
    Import-Module (Join-Path $ThisRoot 'PSChickfilA.psd1') -Force
}
Describe "PSChickfilA Module" {
    BeforeAll {
        $ThisRoot = Split-Path $PSScriptRoot -Parent
    }
    Context 'Module' {
        It "Imports Successfully" {
            Get-Module PSChickfilA | Should -Not -BeNullOrEmpty
        }
    }
    Context 'Functions' {
        # It 'All: should import successfully' {
        #     $PublicImportedCommands = (Get-Command -Module PSChickfilA).Name
        #     $FunctionRegex = '^Function .+?.(?=\()'
        #     $AllFunctions = ((Get-Content (Join-Path $script:ThisRoot 'PSChickfilA.psm1') | Select-String -Pattern $FunctionRegex).Matches.value | Foreach-Object {@($_ -Split ' ')[1]}) | Sort-Object
        #     $PrivateFunctions = (Compare-Object $PublicImportedCommands $AllFunctions).InputObject

        #     ($PublicImportedCommands + $PrivateFunctions | Sort-Object) | Should -Be $AllFunctions
        # }

        It "Should be valid PowerShell code" {
            $FileContent = Get-Content (Join-Path $ThisRoot 'PSChickfilA.psm1')
            $Errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($FileContent, [ref]$errors)
            $errors.Count | Should -be 0
        }
    }
}