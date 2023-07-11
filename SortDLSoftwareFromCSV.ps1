# Mass download renamer for MDT
# Version 3

# Use -Whatif parameter if testing output

# Vars
# Import CSV
$csvFile = Import-Csv -Path filenameDB.csv -Delimiter ';'
# Set the path to the downloaded software files you wish to rename.
$srcPath = "DIR_GOES_HERE"
# Set the export path where you want the new renamed files to go.
$destPath = "DESTINATION_DIR_GOES_HERE"
# Get srcPath list
$dirFiles = Get-ChildItem -Path $srcPath

ForEach ( $currentApp in $dirFiles )
{
    $i = 0
    $csvFile | Select-Object matchrgx,destfull | Select-Object -ExpandProperty matchrgx | Where-Object { 
        if ( ($currentApp.Name -Match ${_}) -eq 'True' )
        {
            $currentAppDir = $csvFile | Where-Object matchrgx -like $_ | Select-Object -ExpandProperty destfull
            Move-Item -Path $currentApp -Force -Verbose -Destination $destPath\$currentAppDir -WhatIf
            Add-Content -Path .\Logs\SortDLSoftwareFromCSV_log_$datetoday.txt -Value "$currentApp moved to $destPath\$currentAppDir" -PassThru
            Continue
        }
        else
        {
            $i++
            if ( $csvFile.count -eq $i )
            {
                Add-Content -Path .\Logs\SortDLSoftwareFromCSV_log_$datetoday.txt -Value "$currentApp doesn't exist in the current CSV database" -PassThru
            }
        }

    }
}