$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"

#region Compile configuration

. "$ScriptPath\Configuration.Website.2.ps1"

# Create the MOF file using configuration parameters
FourthCoffeeWebSite -NodeName        $NodeName `
                    -WebSiteName     'FourthCoffee' `
                    -SourcePath      $SourcePath  `
                    -DestinationPath 'C:\inetpub\FourthCoffee' `
                    -OutputPath      $OutputPath

#endregion Compile configuration

#region deploy configuration

Start-DscConfiguration -Path $OutputPath -ComputerName $NodeName -Wait -Verbose -Credential $Credential -Force

#endregion deploy configuration

#region Cleanup
Remove-Item -Force -Recurse $OutputPath
#endregion Cleanup