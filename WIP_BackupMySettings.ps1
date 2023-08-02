# Global vars
$backup_datetoday = Get-Date -Format FileDateTime
$backup_user = echo ($env:USERNAME)

$backup_destination_path = "C:\Users\$backup_user\Desktop\SettingsBackup-$backupdatetoday"

$wt_config_path = "C:\Users\$backup_user\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$vsc_config_path = "C:\Users\$backup_user\AppData\Roaming\Code\User"
$pwsh_profile_path = "C:\Users\$backup_user\Documents\PowerShell"

# Windows Terminal
xcopy $wt_config_path\settings.json
