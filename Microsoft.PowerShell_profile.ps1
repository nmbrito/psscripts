oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/slimfat.omp.json" | Invoke-Expression

Clear-Host

# Functions
Function CatMyAlias
{
	Write-Host  "-> hostinfo ###
-> rdpwho SERVER
-> rdpmurder USER_ID SERVER 
-> conncmd HOSTNAME
-> connpwsh HOSTNAME
-> reload
"
}

Function Reload-PowerShellProfile {& $profile}

function RemoteConnect
{
    [CmdletBinding()]
    [Alias("hostinfo")]
    PARAM(
        [Parameter (Mandatory=$true)]
        [String]$hostname
    )
    
	process {
		\\live.sysinternals.com\tools\PsExec.exe \\$hostname cmd /c "WMIC COMPUTERSYSTEM GET MODEL && WMIC BIOS GET SERIALNUMBER && WMIC COMPUTERSYSTEM GET USERNAME && exit"
	}
}

function VerificarRDPUser
{
    [CmdletBinding()]
    [Alias("rdpwho")]
	PARAM(
		[Parameter (Mandatory=$true)]
		[String]$serverID
    )

	QUser /server:$serverID
}

function MatarRDPUser
{
    [CmdletBinding()]
    [Alias("rdpmurder")]
    PARAM(
        [Parameter (Mandatory=$true)]
		[String]$serverID
        [String]$userID
    )
    
	Logoff $userID /server:$serverID
}

function RemoteConnectCMD
{
    [CmdletBinding()]
    [Alias("conncmd")]
    PARAM(
        [Parameter (Mandatory=$true)]
        [String]$compcmd
    )
    
    \\live.sysinternals.com\tools\PsExec.exe \\$compcmd cmd
}

function RemoteConnectPWSH
{
    [CmdletBinding()]
    [Alias("connpwsh")]
    PARAM(
        [Parameter (Mandatory=$true)]
        [String]$comppwsh
    )
	
    \\live.sysinternals.com\tools\PsExec.exe \\$comppwsh powershell
	
	if ($comppwsh -like 'CHANGE_THIS') {
		Import-Module ActiveDirectory
	}
}

# Set-Alias
Set-Alias reload Reload-PowerShellProfile
Set-Alias catalias CatMyAlias