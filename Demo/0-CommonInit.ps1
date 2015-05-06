#region Initialization
$PSDefaultParameterValues = @{'Find-Module:Repository'='NanaGallery'}
$PSDefaultParameterValues += @{'Install-Module:Repository'='NanaGallery'}
$PSDefaultParameterValues += @{'Publish-Module:Repository'='NanaGallery'}

$NodeName    = 'Nana-Test-1' 
$OutputPath  = 'D:\Nana\Test\CompiledConfigurations'
$SourcePath  = 'C:\Content\content\BakeryWebsite'
$ResourcePath= "$($env:TEMP)\Modules"

if ($null -eq $Credential)
{
  $Credential = Get-Credential
}
#endregion Initialization