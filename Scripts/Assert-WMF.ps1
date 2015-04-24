[CmdletBinding()]
param(

[string[]]
[Parameter(Mandatory=$true)]
$ComputerName,

[Parameter()]
[PSCredential]
$Credential
)

$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"

configuration WMFInstall
{
    Import-DscResource -ModuleName xWindowsUpdate

    node $ComputerName
    { 
      xHotfix Install
      {
          Path   = 'c:\content\content\WMF\WindowsBlue-KB3055381-x64.msu'
          Id     = 'KB3055381'
          Ensure = 'Present'
      }
    }
}

WMFInstall -OutputPath "$WorkingFolder\CompiledConfigurations\WMFInstall" -verbose 

Start-DscConfiguration -Path "$WorkingFolder\CompiledConfigurations\WMFInstall" -ComputerName $ComputerName -Force -Verbose -Wait -cre $Credential

Restart-Computer -ComputerName $ComputerName -Protocol wsman -Wait -Force -Verbose -Credential $Credential
