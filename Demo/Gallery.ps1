$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"
 
# can simply find modules out of the box using Find-Module
Find-Module -OutVariable Modules

# modules are tagged 
$Modules | Format-Table Name, Version, Tags -AutoSize

# can filter based on tags 
Find-Module -OutVariable FilteredModules -Tag DSCResource

# find module containing a resource
Find-Module -DscResource xService

# can find multiple versions of a module
Find-Module -name xPSDesiredStateConfiguration -AllVersions

# can search on authors
Find-Module -Filter Microsoft

# can install a module using Install-Module
Install-Module xWordPress -Verbose 