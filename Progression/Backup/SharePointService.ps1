Function DisableServices([xml]$xmlinput)
{
    If ($xmlinput.Configuration.Install.Disable.UnusedServices -eq $true)
    {
        WriteLine
        Write-Host -ForegroundColor White " - Setting services Spooler, AudioSrv and TabletInputService to Manual..."
 
        $servicesToSetManual = "Spooler","AudioSrv","TabletInputService"
        ForEach ($svcName in $servicesToSetManual)
        {
            $svc = get-wmiobject win32_service | where-object {$_.Name -eq $svcName}
            $svcStartMode = $svc.StartMode
            $svcState = $svc.State
            If (($svcState -eq "Running") -and ($svcStartMode -eq "Auto"))
            {
                Stop-Service -Name $svcName
                Set-Service -name $svcName -StartupType Manual
                Write-Host -ForegroundColor White " - Service $svcName is now set to Manual start"
            }
            Else
            {
                Write-Host -ForegroundColor White " - $svcName is already stopped and set Manual, no action required."
            }
        }
 
        Write-Host -ForegroundColor White " - Setting unused services WerSvc to Disabled..."
        $servicesToDisable = "WerSvc"
        ForEach ($svcName in $servicesToDisable)
        {
            $svc = get-wmiobject win32_service | where-object {$_.Name -eq $svcName}
            $svcStartMode = $svc.StartMode
            $svcState = $svc.State
            If (($svcState -eq "Running") -and (($svcStartMode -eq "Auto") -or ($svcStartMode -eq "Manual")))
            {
                Stop-Service -Name $svcName
                Set-Service -name $svcName -StartupType Disabled
                Write-Host -ForegroundColor White " - Service $svcName is now stopped and disabled."
            }
            Else
            {
                Write-Host -ForegroundColor White " - $svcName is already stopped and disabled, no action required."
            }
        }
        Write-Host -ForegroundColor White " - Finished disabling services."
        WriteLine
