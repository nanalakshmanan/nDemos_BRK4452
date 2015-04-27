# In Windows 7, it required a combination of PowerShell, WMI, and .NET
$share = [WmiClass] 'Win32_Share'
$dir = "c:\temp" 
$share.Create($dir, "a1share", 0)
$share = Get-WmiObject Win32_Share -Filter "Name=`"a1share`""
$user = New-Object System.Security.Principal.NTAccount("ianlucas")
$SID = $user.Translate([System.Security.Principal.SecurityIdentifier])
$SIDBytes = New-Object byte[] $sid.BinaryLength
$SID.GetBinaryForm($SIDBytes, 0)
$sd = ([WmiClass] 'Win32_SecurityDescriptor').CreateInstance()
$trustee = ([WmiClass] 'Win32_Trustee').CreateInstance()
$ACE = ([WmiClass] 'Win32_ACE').CreateInstance()
$trustee.Name = "ianlucas"
$trustee.Domain = $hostname
$trustee.SID = $SIDBytes
$ace.Trustee = $trustee
$ace.AceType = [Security.AccessControl.AceType]::AccessAllowed
$ace.AccessMask = [Security.AccessControl.FileSystemRights]::FullControl
$sd.DACL += $ace
$share.SetShareInfo($null,$null,$sd)