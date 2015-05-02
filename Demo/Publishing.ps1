$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"

# Let us look at properties of a module in the gallery
Find-Module xWebAdministration | Format-List * -Force

# Some of these fields are always populated from the 
# module manifest, some can be specified from the
# command line
Get-Command Publish-Module -Syntax

# however all of them can be specified from the command line
# and is recommended
New-ModuleManifest "$ScriptPath\Manifest.psd1" -Verbose
psedit "$ScriptPath\Manifest.psd1"
Remove-Item -Force "$ScriptPath\Manifest.psd1"

# Publish the module (will prompt for API key)
Publish-Module -Path "$ScriptPath\..\WebsiteModule" -Verbose 