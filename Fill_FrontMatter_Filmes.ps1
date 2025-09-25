# Note to remember if quotes are needed: " Text `"Text2 $($_.HeaderName)`""
# Use -Whatif parameter if testing output

# Vars
# Import CSV
$csvFile = Import-Csv -Path ListaFilmes.csv -Delimiter ';'
	
$csvFile | ForEach-Object {
Add-Content -Path .\genfilmes\$($_.filename).md -Value @"
---
tags: 
nome: `"$($_.name)`"
nome-alternativo: 
ano: $($_.year)
estado: $($_.status)
visto-a: 
qualidade: $($_.quality)
legendas:
plataforma:
"@
if ($($_.deleted) -eq "YES") {Add-Content -Path .\genfilmes\$($_.filename).md -Value "Removido: true"} else {Add-Content -Path .\genfilmes\$($_.filename).md -Value "Removido: false"}
Add-Content -Path .\genfilmes\$($_.filename).md -Value @"
comentários: 
"@
if ($($_.version) -ne "") {Add-Content -Path .\genfilmes\$($_.filename).md -Value " - `"Versão: $($_.version)`""}
Add-Content -Path .\genfilmes\$($_.name).md -Value @"
---
"@

Write-Output "Feito: $($_.name)"
}