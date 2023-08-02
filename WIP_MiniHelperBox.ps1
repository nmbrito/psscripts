# Collection of commands to help customers

# Global variables
$dom_in = echo ($env:USERDOMAIN)
$dom_user = echo ($env:USERNAME)
$today_date = Get-Date -Format "dd/MM/YY HH:mm:ss"

# Force global policy update after password change
function UpdatePassword
{
    #CMD
    net user /domain $dom_user *
    gpupdate /force
    shutdown -r

    #PWSH
    Invoke-GPUpdate -Force
    Restart-Computer -Confirm

}

# Password expire date
function WhenPassExpire
{
    net user /domain $dom_user 


}

# Computer uptime
function ComputerUptime
{
    Get-Uptime
}

# Clear browser cache
function ClearBrowserCache
{


}

