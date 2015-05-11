class foo
{
    [ValidateSet('Hungry', 'Happy', 'Amazing')]
    [string] $IAm 

    WriteIAm()
    {
        #$this.IAm
        Write-Host $this.IAm
    }

}

$f = [foo]::new()
$f.IAm = 'Amazing'
$f.WriteIAm()