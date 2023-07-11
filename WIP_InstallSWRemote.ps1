# Define computer list (only numbers)
$hostnamesList = "C:\Users\CICLadmin\Desktop\iHOSTNAMES.txt"

# Read answers text
$validText = @("Yes","yes","YES","y","Y","sim","Sim","SIM","s","S")

# Define repositories directory, comma seperated
$repositoryList = @(
	"DIR_GOES_HERE"
)

# Global silent parameters
$msiParams = "msiexec.exe /i $installer /qn ALLUSERS=1"
$exeParams = "$installer /S /VerySilent /NoRestart"
$msixbundle = ""

# Pinged array list
$validComputers = @()

function IsRemotePSSOn #TODO
{
	Verificar se está ativo
	não está tenta ativar
	Se ativou então reporta OK
	Se ao fim de 3 tentativas não ativou então reporta NOK
}

function IsRemoteComputerOn
{
	Return Test-Connection -ComputerName $hostnames -Count 5 -quiet
}

function InputHOSTNAMES
{
    [CmdletBinding()]
    PARAM
	(
        [Parameter (Mandatory=$true)]
        [String]$hostnames
    )
    
	process
	{
		ForEach ($repo in $repositoryList)
		{
			if (IsRemoteComputerOn -eq "True")
			{
				if (IsRemotePSSOn -eq "True")
				{
					New-PSSession -ComputerName $hostnames -Credential $localDom\$remoteUser
				}
			}
			else
			{
				Write-Output "Computer DOWN!"
			}
		}
	}
}

function ReadHOSTNAMES_FromList
{
	ForEach ($computer in $hostnamesList)
	{
		if (IsRemoteComputerOn -eq "True")
		{
			$validComputers += $computer
		}
	}

	ForEach ($pingedComputers in $validComputers)
	{
		if (IsRemotePSSOn -eq "False")
		{
			Continue
		}
		
		ForEach ($repos in $repositoryList)
		{
			ForEach ($installer in $repos)
			{
				qualquer coisa remote-pss-session instalar
			}
		}
	}
}

# Main

$readInput = Read-Host "Read from list or direct input? [Y/N]"
$localDom = Read-Host "Enter Domain: " -AsSecureString
$remoteUser = Read-Host "Enter username: " -AsSecureString
$remotePWD = Read-Host "Enter password: " -AsSecureString

if ($readInput -eq "$validText")
{
	InputHOSTNAMES
}
else
{
	ReadHOSTNAMES_FromList
}
