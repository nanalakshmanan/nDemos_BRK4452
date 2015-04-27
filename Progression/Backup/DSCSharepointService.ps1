configuration SharepointService
{
    Service Started
    {
        Name        = “Spooler”,“AudioSrv”, "TabletInputService"
        State       = "Stopped"
        StartupType = "Manual“
    }

    Service Stopped
    {
        Name        = "WerSvc"
        State       = "Stopped"
        StartupType = "Disabled"
    } 
}  
 
