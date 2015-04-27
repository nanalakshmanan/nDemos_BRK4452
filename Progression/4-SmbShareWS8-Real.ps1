# But actual creating a share in Idempotent way would be

$shareExists = $false
$smbShare = Get-SmbShare -Name $Name -ErrorAction SilentlyContinue
if($smbShare -ne $null)
{
    Write-Verbose -Message "Share with name $Name exists"
    $shareExists = $true
}

if ($shareExists -eq $false)
{
    Write-Verbose "Creating share $Name to ensure it is Present"
    New-SmbShare @psboundparameters
}
else
{
    # Need to call either Set-SmbShare or *ShareAccess cmdlets
    if ($psboundparameters.ContainsKey("ChangeAccess"))
    {
        $changeAccessValue = $psboundparameters["ChangeAccess"]
        $psboundparameters.Remove("ChangeAccess")
    }
    if ($psboundparameters.ContainsKey("ReadAccess"))
    {
        $readAccessValue = $psboundparameters["ReadAccess"]
        $psboundparameters.Remove("ReadAccess")
    }
    if ($psboundparameters.ContainsKey("FullAccess"))
    {
        $fullAccessValue = $psboundparameters["FullAccess"]
        $psboundparameters.Remove("FullAccess")
    }
    if ($psboundparameters.ContainsKey("NoAccess"))
    {
        $noAccessValue = $psboundparameters["NoAccess"]
        $psboundparameters.Remove("NoAccess")
    }
            
    # Use Set-SmbShare for performing operations other than changing access
    Set-SmbShare @PSBoundParameters -Force
            
    # Use *SmbShareAccess cmdlets to change access
    $smbshareAccessValues = Get-SmbShareAccess -Name $Name
    if ($ChangeAccess -ne $null)
    {
        # Blow off whatever is in there and replace it with this list
        $smbshareAccessValues | ? {$_.AccessControlType  -eq 'Allow' -and $_.AccessRight -eq 'Change'} `
                                | % {
                                    Remove-AccessPermission -ShareName $Name -UserName $_.AccountName -AccessPermission Change
                                    }
                                  
        $changeAccessValue | % {
                                Set-AccessPermission -ShareName $Name -AccessPermission "Change" -Username $_
                                }
    }
    $smbshareAccessValues = Get-SmbShareAccess -Name $Name
    if ($ReadAccess -ne $null)
    {
        # Blow off whatever is in there and replace it with this list
        $smbshareAccessValues | ? {$_.AccessControlType  -eq 'Allow' -and $_.AccessRight -eq 'Read'} `
                                | % {
                                    Remove-AccessPermission -ShareName $Name -UserName $_.AccountName -AccessPermission Read
                                    }

        $readAccessValue | % {
                                Set-AccessPermission -ShareName $Name -AccessPermission "Read" -Username $_                        
                                }
    }
    $smbshareAccessValues = Get-SmbShareAccess -Name $Name
    if ($FullAccess -ne $null)
    {
        # Blow off whatever is in there and replace it with this list
        $smbshareAccessValues | ? {$_.AccessControlType  -eq 'Allow' -and $_.AccessRight -eq 'Full'} `
                                | % {
                                    Remove-AccessPermission -ShareName $Name -UserName $_.AccountName -AccessPermission Full
                                    }

        $fullAccessValue | % {
                                Set-AccessPermission -ShareName $Name -AccessPermission "Full" -Username $_                        
                                }
    }
    $smbshareAccessValues = Get-SmbShareAccess -Name $Name
    if ($NoAccess -ne $null)
    {
        # Blow off whatever is in there and replace it with this list
        $smbshareAccessValues | ? {$_.AccessControlType  -eq 'Deny'} `
                                | % {
                                    Remove-AccessPermission -ShareName $Name -UserName $_.AccountName -AccessPermission No
                                    }
        $noAccessValue | % {
                                Set-AccessPermission -ShareName $Name -AccessPermission "No" -Username $_
                            }
    }
}