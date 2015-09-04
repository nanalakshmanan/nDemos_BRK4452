[CmdletBinding()]
param()

$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptPath\0-CommonInit.ps1"

# register the local repository
Register-PSRepository -Name $LocalGallery `
                      -SourceLocation "http://${VMName}:$port/api/v2" `
                      -InstallationPolicy Trusted `
                      -PublishLocation http://${VMName}:$port/api/v2/package 2> $Null

$ModulesFolder = "$ContentFolder\Modules"

# publish all the modules to the local repository
dir $ModulesFolder | % {

    $Path = $_.FullName

    # find the version of the module locally
    $Module = Get-Module -Name $Path -ListAvailable -Verbose:$false

    # check if the version is already available in the gallery
    $GalleryModule = $null
    $GalleryModule = Find-Module -Name $Module.Name `
                                 -RequiredVersion $Module.Version `
                                 -Repository $LocalGallery `
                                 -ErrorAction SilentlyContinue

    # publish if the required version is not available
    if ($null -eq $GalleryModule)
    {
        Write-Verbose -Message "Publishing module $($Module.Name) with version $($Module.Version)"
        Publish-Module -Path $_.FullName `
                       -NuGetApiKey $ApiKey `
                       -Repository $LocalGallery `
                       -Tags 'DscResource' `
                       -Verbose
    }
    else
    {
        Write-Verbose -Message "$($Module.Name) with version $($Module.Version) already available, skip publishing"
    }
}