﻿$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"

# discover if there are required resources
Find-DscResource xWebsite

# get the module
Install-Module xWebAdministration -Verbose 

# now start writing a configuration
psedit "$ScriptPath\Configuration.Website.1.ps1"

# configurations are like functions - so they can have parameters
# and help
psedit "$ScriptPath\Configuration.Website.2.ps1"

# Now you can invoke a configuration
psedit "$ScriptPath\Invoke-Website.ps1"

# This configuration can now be packaged in a module for sharing
psedit "$ScriptPath\..\WebsiteModule\WebsiteModule.psm1"

