$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"

# resources can also be written using classes
$Module = Get-Module -ListAvailable 'nServiceManager'
psedit "$($Module.ModuleBase)\nService.psm1"

# the .psm1 file containing the class code needs
# to be placed as the rootmodule (current limitation)
# and DscResourcesToExport should contain the 
# resources to export
psedit "$($Module.ModuleBase)\nServiceManager.psd1"