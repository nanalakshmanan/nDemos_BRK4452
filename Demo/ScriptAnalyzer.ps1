$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"

# Look for the latest version of script analyzer
Find-Module -Name *scriptAnalyzer* -Verbose -OutVariable SAModule

# It is currently developed as open source
$SAModule.ProjectUri

# Install the module
Install-Module PSScriptAnalyzer -Verbose -ErrorAction SilentlyContinue -Force

# Here are the list of commands
Get-Command -Module PSScriptAnalyzer

# list the rules available
Get-ScriptAnalyzerRule -Verbose | Out-GridView

# You can invoke rules on a specific file
Invoke-ScriptAnalyzer "$ScriptPath\..\Content\CreateWebsite.ps1" -Verbose

# you can invoke rules by severity
Invoke-ScriptAnalyzer "$ScriptPath\..\Content\CreateWebsite.ps1"  -Severity Error -Verbose

# you can include/exclude certain rules
Invoke-ScriptAnalyzer "$ScriptPath\..\Content\CreateWebsite.ps1" -IncludeRule PSUseApprovedVerbs -Verbose

# you can run custom rules
$Module = Get-Module -ListAvailable nScriptAnalyzerRules

Get-ScriptAnalyzerRule -CustomizedRulePath $Module.ModuleBase 

# here is the rule code
psedit "$($Module.ModuleBase)\nScriptAnalyzerRules.psm1 "

# invoke the custom rule
Invoke-ScriptAnalyzer -Path "$ScriptPath\..\Content\CreateWebsite.ps1" -CustomizedRulePath $Module.ModuleBase -IncludeRule nTestDescriptionAndAuthorField -Verbose