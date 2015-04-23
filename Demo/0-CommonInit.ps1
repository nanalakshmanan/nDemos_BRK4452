#region Initialization
$PSDefaultParameterValues = @{'Find-Module:Repository'='PSGallery'}
$PSDefaultParameterValues += @{'Install-Module:Repository'='PSGallery'}
$PSDefaultParameterValues += @{'Publish-Module:Repository'='MSPSGallery'}

$NodeName    = 'Nana-Test-1' 
$OutputPath  = 'D:\Nana\Test\CompiledConfigurations'
$SourcePath  = 'C:\Content\content\BakeryWebsite'
if ($Credential -eq $Null)
{
  $Credential = Get-Credential
}
#endregion Initialization