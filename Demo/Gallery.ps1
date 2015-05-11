$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"
 
# can simply find modules out of the box using Find-Module
Find-Module -OutVariable Modules

# modules are tagged 
$Modules | Format-Table Name, Version, Tags -AutoSize

# can find modules based on tags 
# you can add your own tags
Find-Module -OutVariable FilteredModules -Tag DSCResource

# find DSC resources available in the gallery
Find-DscResource -Name xWebsite

# can find multiple versions of a module
Find-Module -name xPSDesiredStateConfiguration -AllVersions

# can search on authors
# -Filter operates against the module manifest
Find-Module -Filter Microsoft

# can install a module using Install-Module
Install-Module xWebAdministration -Verbose 