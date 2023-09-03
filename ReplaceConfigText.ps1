<#
Script name
-----------
    ReplaceConfigText

Description
-----------
    Replaces a set of strings in a configuration file.
    This isn't an universal replacer.
    Title is a work in progress.

Objective
---------
    Select a directory and pick configuration files.
    Replace the following information:
        hostname "host"
        ip default-gateway 127.0.0.1
        ip address 127.0.0.1 255.255.255.0
#>

# Global variables
$PSVar_ContentDirectory = ""
$PSVar_TargetHostname = ""
$PSVar_TargetDefaultGateway = ""
$PSVar_TargetIP = ""
$PSVar_TargetSubnetMask = ""
$PSVar_RegexPatternHostname = "/[\w-_.]{1,15}/"
$PSVar_RegexPatternDefaultGateway = "/(( 25[0-5] | 2[0-4][0-9] | [01]?[0-9][0-9]? )\.){3}(( 25[0-5] | 2[0-4][0-9] | [01]?[0-9][0-9]? ))/"
$PSVar_RegexPatternIP = "/(( 25[0-5] | 2[0-4][0-9] | [01]?[0-9][0-9]? )\.){3}(( 25[0-5] | 2[0-4][0-9] | [01]?[0-9][0-9]? ))/"
$PSVar_RegexPatternSubnetMask = "/(( 25[0-5] | 2[0-4][0-9] | [01]?[0-9][0-9]? )\.){3}(( 25[0-5] | 2[0-4][0-9] | [01]?[0-9][0-9]? ))/"

$PSVar_DateNow = Get-Date -Format FileDateTime
$PSVar_WelcomeMessage = @"
Welcome to ReplaceConfigText.
-----------------------------
"@

# Version 1 - START {{{1
# -----------------
###$PSVar_OriginalTarget = "teste.conf"
###$PSVar_CopiedTarget = ( "alt_" + $PSVar_OriginalTarget )
###
###Copy-Item $PSVar_OriginalTarget -Destination $PSVar_CopiedTarget
###( Get-Content -Path $PSVar_CopiedTarget -Raw ) -replace 'hostname ".*"', "hostname ${PSVar_TargetHostname}" |`
###    Set-Content -Path $PSVar_CopiedTarget
###( Get-Content -Path $PSVar_CopiedTarget -Raw ) -replace 'ip default-gateway \d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}', "ip default-gateway ${PSVar_TargetDefaultGateway}" |`
###    Set-Content -Path $PSVar_CopiedTarget
###( Get-Content -Path $PSVar_CopiedTarget -Raw ) -replace 'ip address \d{1,3}.\d{1,3}.\d{1,3}.\d{1,3} \d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}', "ip address ${PSVar_TargetIP} ${PSVar_TargetSubnetMask}" |`
###    Set-Content -Path $PSVar_CopiedTarget
# 1}}}

# Version 2 - START {{{1
# -----------------
###$PSS_OriginalTarget = "teste.conf"
###$PSS_CopiedTarget = ( "alt_" + $PSS_OriginalTarget )
###
###    ( $PSVar_CopiedTargetContent ) -replace "hostname "${PSVar_RegexPatternHostname}"", "hostname ${PSVar_TargetHostname}"                                                  | Set-Content -Path $PSVar_CopiedTarget
###    ( $PSVar_CopiedTargetContent ) -replace "ip default-gateway ${PSVar_RegexPatternDefaultGateway}", "ip default-gateway ${PSVar_TargetDefaultGateway}"                    | Set-Content -Path $PSVar_CopiedTarget
###    ( $PSVar_CopiedTargetContent ) -replace "ip address ${PSVar_RegexPatternIP} ${PSVar_RegexPatternSubnetMask}", "ip address ${PSVar_TargetIP} ${PSVar_TargetSubnetMask}"  | Set-Content -Path $PSVar_CopiedTarget
# 1}}}

# Version 3 - START {{{1
# -----------------

# Function: Get-ReplaceConfigTextGatherInfo
# Description:
#   Reads user input and stores in variable.
# ------------------------------------------
function Get-ReplaceConfigTextGatherInfo
{
    if ( $PSVar_TargetHostname -eq "" )
    {
        while ( $PSVar_TargetHostname -notmatch $PSVar_RegexPatternHostname )
        {
            $PSVar_TargetHostname = Read-Host "Hostname: "
        }
    }

    if ( $PSVar_TargetDefaultGateway -eq "" )
    {
        while ( $PSVar_TargetDefaultGateway -notmatch $PSVar_RegexPatternDefaultGateway )
        {
            $PSVar_TargetDefaultGateway = Read-Host "Default-gateway: " 
        }
    }

    if ($PSVar_TargetIP -eq "")
    {
        while ( $PSVar_TargetIP -notmatch $PSVar_RegexPatternIP )
        {
            $PSVar_TargetIP = Read-Host "IP: "
        }
    }

    if ($PSVar_TargetSubnetMask -eq "" )
    {
        while ( $PSVar_TargetSubnetMask -notmatch $PSVar_RegexPatternSubnetMask )
        {
            $PSVar_TargetSubnetMask = Read-Host "Subnet mask: "
        }
    }
}

# Function: Get-ReplaceConfigTextFilesFromDir
# Description:
#   If $PSVar_ContentDirectory is empty prompts user for files.
#   Else, gets files from the defined directory.
#   It also creates a new subdirectory for the edited files, called "Edited".
# ---------------------------------------------------------------------------
function Get-ReplaceConfigTextFilesFromDir
{
    if ( $PSVar_ContentDirectory -eq "")
    {
        Add-Type -AssemblyName System.Windows.Forms
        $PSVar_ContentDirectory = New-Object -Typename System.Windows.Forms.OpenFileDialog
        $PSVar_ContentDirectory.ShowDialog()
        $PSVar_ContentDirectory.Description = "Select a file"
        $PSVar_ContentDirectory.InitialDirectory = "$env:USERPROFILE"
        $PSVar_ContentDirectory.Multiselect = $True
        $PSVar_ContentDirectory.Filter = “Config files (*.conf)|*.conf”
        
        if($PSVar_ContentDirectory.ShowDialog() -eq "OK")
        {
            $PSVar_OriginalTarget += $PSVar_ContentDirectory.FileName
        }
        $PSVar_ContentDirectory = Split-Path -Parent $PSVar_ContentDirectory.FileName
    }
    else
    {
        $PSVar_OriginalTarget = Get-ChildItem -Path ${PSVar_ContentDirectory} -Include *.conf
    }

    if ( Test-Path -Path "${PSVar_ContentDirectory}\Edited" -eq "False" )
    {
        New-Item -Path "${PSVar_ContentDirectory}" -Name "Edited" -ItemType "directory"
    }
}

# Function: Set-ReplaceConfigTextWriteInfo
# Description:
#   Replaces the default words with the user inputs.
# --------------------------------------------------
function Set-ReplaceConfigTextWriteInfo
{
    ( $PSVar_CopiedTargetContent ) | Foreach-Object {
        $_ -replace "hostname `"${PSVar_RegexPatternHostname}`"",                             "hostname `"${PSVar_TargetHostname}`"" `
           -replace "ip default-gateway ${PSVar_RegexPatternDefaultGateway}",               "ip default-gateway ${PSVar_TargetDefaultGateway}" `
           -replace "ip address ${PSVar_RegexPatternIP} ${PSVar_RegexPatternSubnetMask}",   "ip address ${PSVar_TargetIP} ${PSVar_TargetSubnetMask}" `
        } | Set-Content -Path $PSVar_CopiedTarget
}

# Main
Write-Output "${PSVar_WelcomeMessage}"

Get-ReplaceConfigTextFilesFromDir

ForEach ( ${PSVar_ConfigFile} in ${PSVar_OriginalTarget} )
{
    Write-Output "Editing ${PSVar_ConfigFile}"

    ${PSVar_CopiedTarget} = ( ${PSVar_ConfigFile} + "_replaced" )
    Copy-Item ${PSVar_ConfigFile} -Destination "${PSVar_ContentDirectory}\Edited\${PSVar_CopiedTarget}" -PassThru
    $PSVar_CopiedTargetContent = Get-Content -Path $PSVar_CopiedTarget -Raw 

    Get-ReplaceConfigTextGatherInfo
    Write-Out "
    Replacing:
        * Hostname with ${PSVar_TargetHostname}.
        * Default gateway with ${PSVar_TargetDefaultGateway}.
        * IP with ${PSVar_TargetIP}.
        * Subnet mask with ${PSVar_TargetSubnetMask}.
    "

    Set-ReplaceConfigTextWriteInfo
        
    Write-Output "File ${PSVar_ConfigFile} copied as ${PSVar_CopiedTarget} with replaced text."
}
# 1}}}

