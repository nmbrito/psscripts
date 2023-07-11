$datetoday = Get-Date -Format FileDateTime

# Uncomment for debug file
#$dbhostnames = Get-Content -Path .\HOSTNAMESdebug.txt
$dbhostnames = Get-Content -Path .\HOSTNAMESIsAliveList.txt

$intro_msg = "Verifying connectivity to devices!"
Write-Output $intro_msg

ForEach ($hostnames in $dbhostnames)
{
	if (Test-Connection -ComputerName $hostnames -Count 5 -quiet)
	{
		Add-Content -Path .\Logs\IsComputerAlive_log_$datetoday.txt -Value "$hostnames LIGADO!!!!" -PassThru
	}
	else
	{
		Add-Content -Path .\Logs\IsComputerAlive_log_$datetoday.txt -Value "$hostnames DESLIGADO :)" -PassThru
	}
}
