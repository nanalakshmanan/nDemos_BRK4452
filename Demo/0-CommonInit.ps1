#region Initialization
$PSDefaultParameterValues = @{'Find-Module:Repository'='NanaGallery'}		
$PSDefaultParameterValues += @{'Install-Module:Repository'='NanaGallery'}		
$PSDefaultParameterValues += @{'Publish-Module:Repository'='NanaGallery'}		
$PSDefaultParameterValues += @{'Find-DscResource:Repository'='NanaGallery'}

# test machine name
$NodeName    = 'Nana-Test-1' 

# path where compiled configurations (.mof files) need to be placed
$OutputPath  = 'D:\Nana\Test\CompiledConfigurations'

# source location of fourthcoffee files
$SourcePath  = 'C:\Content\content\BakeryWebsite'

# temporary location where new-xdscresource need to create
# the resource
$ResourcePath= "$($env:TEMP)\Modules"

# Credential with administrator privileges to connect to test VM
if ($null -eq $Credential)
{
  $Credential = Get-Credential
}
#endregion Initialization
