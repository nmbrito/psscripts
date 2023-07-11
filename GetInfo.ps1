$datetoday = Get-Date -Format FileDateTime

# Uncomment for debug file
#$dbhostnames = Get-Content -Path .\HOSTNAMESinfodebug.txt
$dbhostnames = Get-Content -Path .\HOSTNAMESGetInfo.txt

$intro_msg = "Collecting computer model, serial number and username!"
Write-Output $intro_msg

ForEach ($hostnames in $dbhostnames)
{
	Add-Content -Path .\Collector\GetInfo_Collector_$datetoday.txt -Value "`n<$hostnames>" -PassThru
	(.\PsExec.exe -n 10 \\$hostnames cmd /c "WMIC COMPUTERSYSTEM GET MODEL && WMIC BIOS GET SERIALNUMBER && WMIC COMPUTERSYSTEM GET USERNAME") | Add-Content -Path .\Collector\GetInfo_Collector_$datetoday.txt
	if($LastExitCode -ne "0")
	{
		Add-Content -Path .\Logs\GetInfo_log_$datetoday.txt -Value "$hostnames Unreachable. Error $LastExitCode. No info gathered." -PassThru
	}
	else
	{
		Add-Content -Path .\Logs\GetInfo_log_$datetoday.txt -Value "$hostnames SUCCESS! Info collected. $LastExitCode." -PassThru
	}
	Add-Content -Path .\Collector\GetInfo_Collector_$datetoday.txt -Value "</$hostnames>" -PassThru
	Write-Output ""
}
