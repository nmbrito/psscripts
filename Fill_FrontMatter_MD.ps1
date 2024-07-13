# Note to remember if quotes are needed: " Text `"Text2 $($_.HeaderName)`""
# Use -Whatif parameter if testing output

# Vars
# Import CSV
$csvFile = Import-Csv -Path TrackingList.csv -Delimiter ';'
	
$csvFile | ForEach-Object {
Add-Content -Path .\gen\$($_.Title).md -Value @"
---
tags: 
Concluído:
Estado:
Plataformas:
"@
if ($($_.Steam) -ne "") 			{Add-Content -Path .\gen\$($_.Title).md -Value "  - Steam"				}
if ($($_.GOG) -ne "") 				{Add-Content -Path .\gen\$($_.Title).md -Value "  - GOG"				}
if ($($_.MicrosoftStore) -ne "")	{Add-Content -Path .\gen\$($_.Title).md -Value "  - Microsoft Store"	}
if ($($_.UbisoftConnect) -ne "") 	{Add-Content -Path .\gen\$($_.Title).md -Value "  - Ubisoft Connect"	}
if ($($_.EA) -ne "") 				{Add-Content -Path .\gen\$($_.Title).md -Value "  - EA"					}
if ($($_.Battlenet) -ne "") 		{Add-Content -Path .\gen\$($_.Title).md -Value "  - Battle.net"			}
if ($($_.EpicGamesStore) -ne "") 	{Add-Content -Path .\gen\$($_.Title).md -Value "  - Epic Games Store"	}
if ($($_.Nintendo) -ne "") 			{Add-Content -Path .\gen\$($_.Title).md -Value "  - Nintendo"			}
Add-Content -Path .\gen\$($_.Title).md -Value @"
Proezas: 
Comentários: 
Extra:
---
"@ 
}