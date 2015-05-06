$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"

# Develop resources using xDSCResourceDesigner
# This provides a way to model the resources 
# using PowerShell cmdlets
Find-Module -Name xDSCResourceDesigner

Install-Module -Name xDSCResourceDesigner -Verbose -Force

# First model each of the resource property
New-xDscResourceProperty -Name 'PropertyName' `
                         -Type String `
                         -Attribute Key `
                         -ValidateSet 'a','b' `
                         -Description 'Description of PropertyName' `
                         -OutVariable Property

# using a collection of properties create a resource
New-xDscResource -Name 'Nana_xResourceName' `
                 -Property $Property `
                 -FriendlyName 'FriendlyName' `
                 -ModuleName 'nModule' `
                 -Path . `
                 -Verbose

# Remove the generated folder
Remove-Item -Recurse -Force .\nModule 

# Now using these tools, let us model a 
# Service resource
$Module = Get-Module -ListAvailable nPSDesiredStateConfiguration
psedit "$($Module.ModuleBase)\Generator\Generator.ps1"

# The generated files have the schema and skeleton code
psedit "$ResourcePath\nPSDesiredStateConfiguration\DscResources\Nana_nService\Nana_nService.schema.mof"

psedit "$ResourcePath\nPSDesiredStateConfiguration\DscResources\Nana_nService\Nana_nService.psm1"

# Now fill the actual logic, and ensure module is placed in $PSModulePath
psedit "$($Module.ModuleBase)\DscResources\Nana_nService\Nana_nService.psm1"