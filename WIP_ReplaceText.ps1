<#
Script name
-----------
    Replace Text

Description
-----------
    Replaces a set of strings in a configuration file.
    This isn't an universal replacer.
    Title is a work in progress.

Objective
---------
    Replace the following information:
        hostname "host"
        ip default-gateway 127.0.0.1
        ip address 127.0.0.1 255.255.255.0

Planned features
----------------
    Drag and drop files.
    Read from arguments with $Args[$i].
    File explorer popup
#>

# Global variables
$PSS_ContentDirectory = ""
$PSS_TargetHostname = "Hostlimit15"
$PSS_TargetDGW = "666.666.666.666"
$PSS_TargetIP = "999.999.999.999"
$PSS_TargetMask = "555.555.555.555"

# Version 1 - START {{{1
# -----------------
$PSS_OriginalTarget = "teste.conf"
$PSS_CopiedTarget = ( "alt_" + $PSS_OriginalTarget )

Copy-Item $PSS_OriginalTarget -Destination $PSS_CopiedTarget
( Get-Content -Path $PSS_CopiedTarget -Raw ) -replace 'hostname ".*"', "hostname ${PSS_TargetHostname}" |`
    Set-Content -Path $PSS_CopiedTarget
( Get-Content -Path $PSS_CopiedTarget -Raw ) -replace 'ip default-gateway \d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}', "ip default-gateway ${PSS_TargetDGW}" |`
    Set-Content -Path $PSS_CopiedTarget
( Get-Content -Path $PSS_CopiedTarget -Raw ) -replace 'ip address \d{1,3}.\d{1,3}.\d{1,3}.\d{1,3} \d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}', "ip address ${PSS_TargetIP} ${PSS_TargetMask}" |`
    Set-Content -Path $PSS_CopiedTarget
# 1}}}

#TRY
$original_file = 'path\filename.abc'
$destination_file =  'path\filename.abc.new'
(Get-Content $original_file) | Foreach-Object {
    $_ -replace 'something1', 'something1aa' `
       -replace 'something2', 'something2bb' `
       -replace 'something3', 'something3cc' `
       -replace 'something4', 'something4dd' `
       -replace 'something5', 'something5dsf' `
       -replace 'something6', 'something6dfsfds'
    } | Set-Content $destination_file


#TRY
$x = $_ -replace 'something1', 'something1aa'
$x = $x -replace 'something2', 'something2bb'
...
$x


#TRY
$lookupTable = @{
    'something1' = 'something1aa'
    'something2' = 'something2bb'
    'something3' = 'something3cc'
    'something4' = 'something4dd'
    'something5' = 'something5dsf'
    'something6' = 'something6dfsfds'
}

$original_file = 'path\filename.abc'
$destination_file =  'path\filename.abc.new'

Get-Content -Path $original_file | ForEach-Object {
    $line = $_

    $lookupTable.GetEnumerator() | ForEach-Object {
        if ($line -match $_.Key)
        {
            $line = $line -replace $_.Key, $_.Value
        }
    }
   $line
} | Set-Content -Path $destination_file

#TRY
$lookupTable = @{
    'something1' = 'something1aa'
    'something2' = 'something2bb'
    'something3' = 'something3cc'
    'something4' = 'something4dd'
    'something5' = 'something5dsf'
    'something6' = 'something6dfsfds'
}

$original_file = 'path\filename.abc'
$destination_file =  'path\filename.abc.new'

Get-Content -Path $original_file | ForEach-Object {
    $line = $_

    $lookupTable.GetEnumerator() | ForEach-Object {
        if ($line -match $_.Key)
        {
            $line -replace $_.Key, $_.Value
            break
        }
    }
} | Set-Content -Path $destination_file

#TRY
function Replace-String {
    [CmdletBinding()][OutputType([string])] param(
        [Parameter(Mandatory = $True, ValueFromPipeLine = $True)]$InputObject,
        [Parameter(Mandatory = $True, Position = 0)][Array]$Pair,
        [Alias('CaseSensitive')][switch]$MatchCase
    )
    for ($i = 0; $i -lt $Pair.get_Count()) {
        if ($Pair[$i] -is [Array]) {
            $InputObject = $InputObject |Replace-String -MatchCase:$MatchCase $Pair[$i++]
        }
        else {
            $Regex = $Pair[$i++]
            $Substitute = if ($i -lt $Pair.get_Count() -and $Pair[$i] -isnot [Array]) { $Pair[$i++] }
            if ($MatchCase) { $InputObject = $InputObject -cReplace $Regex, $Substitute }
            else            { $InputObject = $InputObject -iReplace $Regex, $Substitute }
        }
    }
    $InputObject
}; Set-Alias Replace Replace-String
use:$lookupTable |Replace 'something1', 'something1aa', 'something2', 'something2bb', 'something3', 'something3cc'
or: $lookupTable |Replace ('something1', 'something1aa'), ('something2', 'something2bb'), ('something3', 'something3cc')



#isto pode dar jeito
Function Get-Folder($initialDirectory="")

{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = "Select a folder"
    $foldername.rootfolder = "MyComputer"
    $foldername.SelectedPath = $initialDirectory

    if($foldername.ShowDialog() -eq "OK")
    {
        $folder += $foldername.SelectedPath
    }
    return $folder
}

$a = Get-Folder

#isto tambem
Add-Type -AssemblyName System.Windows.Forms
$browser = New-Object System.Windows.Forms.FolderBrowserDialog
$null = $browser.ShowDialog()
$path = $browser.SelectedPath

#e isto que select apenas uma pasta:
Function Get-Folder($initialDirectory) {
    [void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    $FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $FolderBrowserDialog.RootFolder = 'MyComputer'
    if ($initialDirectory) { $FolderBrowserDialog.SelectedPath = $initialDirectory }
    [void] $FolderBrowserDialog.ShowDialog()
    return $FolderBrowserDialog.SelectedPath
}
($FolderPermissions = Get-Folder C:\Users | get-acl | select -exp access | ft)

#e isto que ficheiros
function Get-File($initialDirectory) {   
    [void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    if ($initialDirectory) { $OpenFileDialog.initialDirectory = $initialDirectory }
    $OpenFileDialog.filter = 'All files (*.*)|*.*'
    [void] $OpenFileDialog.ShowDialog()
    return $OpenFileDialog.FileName
}
($FilePermissions = Get-File C:\ | get-acl | select -exp access | ft)




# Global variables
$PSVar_ContentDirectory = ""
$PSVar_ReplacedDirectory = ""
$PSVar_TargetHostname = ""
$PSVar_TargetDGW = ""
$PSVar_TargetIP = ""
$PSVar_TargetMask = ""


if ( $PSVar_ContentDirectory -eq "" )
{
    $PSVar_GetFileConf = Get-ChildItem -Path "$pwd" -Include *.conf

}
$PSVar_ReadHostname = Read-Host "Hostname: "
$PSVar_ReadDefaultGateway = Read-Host "Default-gateway: "
$PSVar_ReadIP = Read-Host "IP: "
$PSVar_ReadSubMask = Read-Host "Subnet mask: "

ForEach ( $PSVar_FileConf in $PSVar_ContentDirectory )
{
    Copy-Item $PSVar_FileConf -Destination 



}





#( $PSS_CurrentTarget ) -replace 'hostname ".*"', "hostname ${PSS_TargetHostname}" | Set-Content -path ".\Desktop\teste.altered.conf"
#( $PSS_CurrentTarget ) -replace 'ip default-gateway \d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}', "ip default-gateway ${PSS_TargetDGW}" | Set-Content -Path ".\Desktop\teste.altered.conf"
#( $PSS_CurrentTarget ) -replace 'ip address \d{1,3}.\d{1,3}.\d{1,3}.\d{1,3} \d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}', "ip address ${PSS_TargetIP} ${PSS_TargetMask}" | Set-Content -path ".\Desktop\teste.altered.conf"
#$target_hostname = Read-Host "Hostname: "
#$target_dgw = Read-Host "Default-gateway: "
#$target_ip = Read-Host "IP: "
#$target_mask = Read-Host "Subnet mask: "
#
#$target_file_path = Get-Content -Path "FILE_NAME.CONF"
#
#$replace_text_host = ($target_file_path | Select-String -Pattern 'hostname "."') -replace "'hostname "."'", 'hostname "${target_hostname}"'
#$replace_text_dgw = ($target_file_path | Select-String -Pattern 'ip default-gateway ^\d{3}.\d{3}.\d{3}.\d{3}$') -replace 'ip default-gateway ^\d{3}.\d{3}.\d{3}.\d{3}$', 'ip default-gateway ${target_dgw}'
#$replace_text_ipmask = ($target_file_path | Select-String -Pattern 'ip address ^\d{3}.\d{3}.\d{3}.\d{3} \d{3}.\d{3}.\d{3}.\d{3}$') -replace 'ip address ^\d{3}.\d{3}.\d{3}.\d{3} \d{3}.\d{3}.\d{3}.\d{3}$', 'ip address ${target_ip} ${target_mask}'
#
#
#( $target_file_path -Raw ) -replace 'hostname "."', 'hostname "${target_hostname}'                                                              | Set-Content -path ${target_file_path}
#( $target_file_path -Raw ) -replace 'ip default-gateway ^\d{3}.\d{3}.\d{3}.\d{3}$', 'ip default-gateway ${target_dgw}'                          | Set-Content -path ${target_file_path}
#( $target_file_path -Raw ) -replace 'ip address ^\d{3}.\d{3}.\d{3}.\d{3} \d{3}.\d{3}.\d{3}.\d{3}$', 'ip address ${target_ip} ${target_mask}'    | Set-Content -path ${target_file_path}

## Test
#
#function Set-Text2Replace
#{
#    param (
#
#    )
#$target_hostname = Read-Host "Hostname: "
#$target_dgw = Read-Host "Default-gateway: "
#$target_ip = Read-Host "IP: "
#$target_mask = Read-Host "Subnet mask: "
#
#
#
#}
#
## First we'll try to read from arguments.
## It can be passed via parameters or drag and drop.
## If none of them we're done, try to read the folder
#if ( $Args -ge 0 )
#{
#
#}
#else
#{
#    if ( $content_directory -eq "")
#    {
#        # Get all conf files
#        $get_fconf = Get-ChildItem -Path "$pwd" -Include *.conf
#        ForEach ( $existing_file in $get_fconf )
#        {
#            $fpath_joined = Join-Path -Path "$pwd" -ChildPath "$existing_file"
#            Get-Content -Path "$fpath_joined"
#            Set-Text2Replace
#        }
#    }
#    else
#    {
#    
#    }
#
#}
#
