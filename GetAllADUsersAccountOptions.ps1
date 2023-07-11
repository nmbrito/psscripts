Import-Module ActiveDirectory

Get-ADUser -Filter * -Properties * | select CN,DisplayName,CanonicalName,SamAccountName,EmailAddress,pwdLastSet,CannotChangePassword,PasswordNeverExpires,AllowReversiblePasswordEncryption,Enabled,SmartcardLogonRequired,AccountNotDelegated,UseDESKeyOnly,msDS-SupportedEncryptionTypes,DoesNotRequirePreAuth | Export-CSV c:\GetAccountOptionsTable.csv -Encoding UTF8

# Limit to OU= and less information exported
# Get-ADUser -Filter * -SearchBase "OU=INSERT_NAME_HERE,DC=INSERT_NAME_HERE,DC=local" -properties * | Select pwdLastSet,CannotChangePassword,PasswordNeverExpires,AllowReversiblePasswordEncryption,Enabled,SmartcardLogonRequired,AccountNotDelegated,UseDESKeyOnly,msDS-SupportedEncryptionTypes,DoesNotRequirePreAuth | FT | Export-CSV c:\GetAccountOptionsTable.csv -Encoding UTF8