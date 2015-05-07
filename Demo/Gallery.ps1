$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"
 
# can simply find modules out of the box using Find-Module
Find-Module -OutVariable Modules

# modules are tagged 
$Modules | Format-Table Name, Version, Tags -AutoSize

# can find modules based on tags 
Find-Module -OutVariable FilteredModules -Tag DSCResourceKit

# find DSC resources available in the gallery
Find-DscResource -Name xService

# can find multiple versions of a module
Find-Module -name xPSDesiredStateConfiguration -AllVersions

# can search on authors
Find-Module -Filter Microsoft

# can install a module using Install-Module
Install-Module xWordPress -Verbose 