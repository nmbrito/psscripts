$datetoday = Get-Date -Format FileDateTime

# Uncomment for debug file
#$dbhostnames = Get-Content -Path .\HOSTNAMESdebug.txt
$dbhostnames = Get-Content -Path .\HOSTNAMES.txt

$intro_msg = "Disabling FastStartup!"
Write-Output $intro_msg

ForEach ($hostnames in $dbhostnames)
{
	.\PsExec.exe -n 10 \\$hostnames cmd /c "powercfg /h off"
	if($LastExitCode -ne "0")
	{
		Add-Content -Path .\Logs\Disable_FastStartup_log_$datetoday.txt -Value "$hostnames Unreachable. Error $LastExitCode. FastStartup still enabled." -PassThru
	}
	else
	{
		Add-Content -Path .\Logs\Disable_FastStartup_log_$datetoday.txt -Value "$hostnames SUCCESS! FastStartup disabled. $LastExitCode." -PassThru
	}
	Write-Output ""
}
