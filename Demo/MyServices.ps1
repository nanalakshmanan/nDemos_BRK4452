$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"

# discover if there are required resources
Find-DscResource -Name xFirewall

# get the module
Install-Module xNetworking -Verbose -Force

# now start writing a configuration
psedit "$ScriptPath\Configuration.Service.1.ps1"

# configurations are like functions - so they can have parameters
# and help
psedit "$ScriptPath\Configuration.Service.2.ps1"

# Now you can invoke a configuration
psedit "$ScriptPath\Invoke-MyServices.ps1"

# This configuration can now be packaged in a module for sharing
psedit "$ScriptPath\..\MyServices\MyServices.psm1"

