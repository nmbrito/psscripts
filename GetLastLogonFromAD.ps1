Import-Module ActiveDirectory

$datetoday = Get-Date -Format FileDateTime

$Servers = Get-ADComputer -Properties lastLogonTimeStamp -Filter * -ResultSetSize $null
"Name;DN;lastLogonTimeStamp" | Out-File ".\ComputerList_LastLogon_$datetoday.txt"
ForEach ($Server In $Servers)
{
  $Output = $Server.Name + ";" + $Server.distinguishedName + ";" + [datetime]::FromFileTime($Server.lastLogonTimeStamp)
  Write-Host $Output
  $Output | Out-File ".\ComputerList_LastLogon_$datetoday" -Append
}