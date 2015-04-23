Configuration FourthCoffeeWebsite
{    
    # Import the module that defines custom resources
    Import-DscResource -Module xWebAdministration

    Node 'Nana-Test-1'
    {
        # Install the IIS role
        WindowsFeature IIS
        {
            Ensure          = 'Present'
            Name            = 'Web-Server'
        }

        # Install the ASP .NET 4.5 role
        WindowsFeature AspNet45
        {
            Ensure          = 'Present'
            Name            = 'Web-Asp-Net45'
        }        
    }
}
