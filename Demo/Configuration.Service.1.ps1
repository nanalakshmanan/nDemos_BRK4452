Configuration MyServices
{    
    # Import the module that defines custom resources
    Import-DscResource -Module xNetworking, PSDesiredStateConfiguration

    Node 'Nana-Test-1'
    {
        # Ensure remote desktop is turned off
        Service TermService
        {
            Name        = 'TermService'
            State       = 'Stopped'
            StartupType = 'Manual'
        }

        # Ensure Error reporting is turned off
        Service WerSvc
        {
            Name        = 'WerSvc'
            State       = 'Stopped'
            StartupType = 'Manual'
        }

        # Install the IIS role
        WindowsFeature IIS
        {
            Ensure          = 'Present'
            Name            = 'Web-Server'
        }

        # Ensure w3svc is running
        Service w3svc
        {
            Name        = 'w3svc'
            State       = 'Running'
            StartupType = 'Automatic'
            DependsOn   = '[WindowsFeature]IIS'
        }

        # Ensure port 80 is open
        xFirewall Port80
        {
            Access       = 'Allow'
            Name         = 'Port80'
            Description  = 'Allow port 80 open for web connections'
            Direction    = 'Inbound'
            DisplayGroup = 'MSIgnite'
            DisplayName  = 'Firewall rule for MSIgnite'
            Ensure       = 'Present'
            LocalPort    = '80'
            RemotePort   = '80'
            Profile      = 'Any'
            Protocol     = 'TCP'            
            State        = 'Enabled'
       }
    }
}
