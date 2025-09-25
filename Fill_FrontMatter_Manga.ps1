# Note to remember if quotes are needed: " Text `"Text2 $($_.HeaderName)`""
# Use -Whatif parameter if testing output

# Vars
# Import CSV
$csvFile = Import-Csv -Path ListaManga.csv -Delimiter ';'
	
$csvFile | ForEach-Object {
Add-Content -Path .\genmangas\$($_.filename).md -Encoding "utf8BOM" -Value @"
---
tags: 
nome: `"$($_.name)`"
nome-alternativo: 
nome-japonês: `"$($_.japanesename)`"
estado: $($_.status)
último-capítulo-lido: `"$($_.current)`"
atualizado-a: $($_.date)
plataforma:
"@
if ($($_.mangaplus) -ne "") {Add-Content -Path .\genmangas\$($_.Filename).md -Value " - MangaPlus"}
if ($($_.other) -ne "")     {Add-Content -Path .\genmangas\$($_.Filename).md -Value " - Outro"    }
Add-Content -Path .\genmangas\$($_.Filename).md -Value @"
comentários: `"$($_.comments)`"
---

# Links

"@
if ($($_.mangaplus) -ne "") {Add-Content -Path .\genmangas\$($_.Filename).md -Value "[MangaPlus]($($_.MangaPlus))"}
if ($($_.other) -ne "")     {Add-Content -Path .\genmangas\$($_.Filename).md -Value "[Outro]($($_.Outro))"        }

Write-Output "Feito: $($_.name)"
}