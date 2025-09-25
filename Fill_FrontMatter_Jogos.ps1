# Note to remember if quotes are needed: " Text `"Text2 $($_.HeaderName)`""
# Use -Whatif parameter if testing output

# Vars
# Import CSV
$csvFile = Import-Csv -Path ListaJogos.csv -Delimiter ';'
	
$csvFile | ForEach-Object {
Add-Content -Path .\genjogos\$($_.filename).md -Value @"
---
tags: 
nome: `"$($_.name)`"
nome-alternativo: `"$($_.altname)`"
estado:
concluído-a: 
plataformas:
"@
if ($($_.steam) -ne "") 			{Add-Content -Path .\genjogos\$($_.filename).md -Value " - Steam"			}
if ($($_.gog) -ne "") 				{Add-Content -Path .\genjogos\$($_.filename).md -Value " - GOG"				}
if ($($_.microsoftstore) -ne "")	{Add-Content -Path .\genjogos\$($_.filename).md -Value " - Microsoft Store"	}
if ($($_.ubisoftconnect) -ne "") 	{Add-Content -Path .\genjogos\$($_.filename).md -Value " - Ubisoft Connect"	}
if ($($_.ea) -ne "") 				{Add-Content -Path .\genjogos\$($_.filename).md -Value " - EA"				}
if ($($_.battlenet) -ne "") 		{Add-Content -Path .\genjogos\$($_.filename).md -Value " - Battle.net"		}
if ($($_.epicgamesstore) -ne "") 	{Add-Content -Path .\genjogos\$($_.filename).md -Value " - Epic Games Store" }
if ($($_.nintendo) -ne "") 			{Add-Content -Path .\genjogos\$($_.filename).md -Value " - Nintendo"			}
Add-Content -Path .\genjogos\$($_.filename).md -Value @"
proezas: de
comentários: 
"@
if ($($_.version) -ne "") 			{Add-Content -Path .\genjogos\$($_.filename).md -Value " - `"Versão: $($_.version)`""       }
if ($($_.superseeds) -ne "") 	    {Add-Content -Path .\genjogos\$($_.filename).md -Value " - `"Substituí: $($_.superseeds)`"" }
Add-Content -Path .\genjogos\$($_.filename).md -Value @"
steamdeck: false
---
"@

Write-Output "Feito: $($_.name)"
}
