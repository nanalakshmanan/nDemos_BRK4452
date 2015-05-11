$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"

# Create a new test fixture in pester
New-Fixture -Path "$($ResourcePath)\Tests" -Name nService -Verbose

# it creates a script file and the corresponding test file
psedit "$($ResourcePath)\Tests\nService.ps1"

psedit "$($ResourcePath)\Tests\nService.tests.ps1"

# start filling in tests
# and invoke the tests using Pester
pushd "$($ResourcePath)\Tests"

Invoke-Pester

popd

# here is the full list
$Module = Get-Module -Name nPSDesiredStateConfiguration -ListAvailable

psedit "$($Module.ModuleBase)\Tests\nService.ps1"

psedit "$($Module.ModuleBase)\Tests\nService.tests.ps1"

# Invoke the tests using Pester
pushd "$($Module.ModuleBase)\Tests"

Invoke-Pester

# you can also invoke specific tests or by tags
Invoke-Pester -TestName 'nService.TestTargetResource' -Verbose

Invoke-Pester -Tag UnitTests -Verbose

popd