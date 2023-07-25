# WIP
#
# TODO: Use Get-Content

# Drag and drop files or read from arguments with $Args[$i]
# Example text to search and replace
#   hostname "host"
#   ip default-gateway 127.0.0.1
#   ip address 127.0.0.1 255.255.255.0
#
#   hostname "$target_hostname"
#   ip default-gateway $target_dgw
#   ip address $target_ip $target_mask

# Global Variables
$content_directory = ""


$target_hostname = Read-Host "Hostname: "
$target_dgw = Read-Host "Default-gateway: "
$target_ip = Read-Host "IP: "
$target_mask = Read-Host "Subnet mask: "

$target_file_path = Get-Content -Path "FILE_NAME.CONF"

$replace_text_host = ($target_file_path | Select-String -Pattern 'hostname "."') -replace "'hostname "."'", 'hostname "${target_hostname}"'
$replace_text_dgw = ($target_file_path | Select-String -Pattern 'ip default-gateway ^\d{3}.\d{3}.\d{3}.\d{3}$') -replace 'ip default-gateway ^\d{3}.\d{3}.\d{3}.\d{3}$', 'ip default-gateway ${target_dgw}'
$replace_text_ipmask = ($target_file_path | Select-String -Pattern 'ip address ^\d{3}.\d{3}.\d{3}.\d{3} \d{3}.\d{3}.\d{3}.\d{3}$') -replace 'ip address ^\d{3}.\d{3}.\d{3}.\d{3} \d{3}.\d{3}.\d{3}.\d{3}$', 'ip address ${target_ip} ${target_mask}'


( $target_file_path -Raw ) -replace 'hostname "."', 'hostname "${target_hostname}'                                                              | Set-Content -path ${target_file_path}
( $target_file_path -Raw ) -replace 'ip default-gateway ^\d{3}.\d{3}.\d{3}.\d{3}$', 'ip default-gateway ${target_dgw}'                          | Set-Content -path ${target_file_path}
( $target_file_path -Raw ) -replace 'ip address ^\d{3}.\d{3}.\d{3}.\d{3} \d{3}.\d{3}.\d{3}.\d{3}$', 'ip address ${target_ip} ${target_mask}'    | Set-Content -path ${target_file_path}

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
