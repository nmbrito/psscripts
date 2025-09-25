# Note to remember if quotes are needed: " Text `"Text2 $($_.HeaderName)`""
# Use -Whatif parameter if testing output

# Vars
# Import CSV
$csvFile = Import-Csv -Path ListaSeries.csv -Delimiter ';'
	
$csvFile | ForEach-Object {
Add-Content -Path .\genseries\$($_.filename).md -Value @"
---
tags: 
nome: `"$($_.name)`"
nome-alternativo: 
estado: $($_.status)
último-episódio-visto: $($_.currentep)
atualizado-a: $($_.date)
plataforma: $($_.platform)
comentários: `"$($_.comments)`"
---

# Links

"@
if ($($_.stream) -eq "série")      {Add-Content -Path .\genseries\$($_.Filename).md -Value "[série]($($_.stream))" }

Write-Output "Feito: $($_.name)"
}