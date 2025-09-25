# Note to remember if quotes are needed: " Text `"Text2 $($_.HeaderName)`""
# Use -Whatif parameter if testing output

# Vars
# Import CSV
$csvFile = Import-Csv -Path ListaSeries.csv -Delimiter ';'
	
$csvFile | ForEach-Object {
Add-Content -Path .\genapps\$($_.filename).md -Value @"
---
tags:
nome: `"$($_.Nome)`"
categoria: ""
plataformas: ""
---

# Links

`"$($_.Link)`"

# Descrição

`"$($_.Descrição)`"

"@
Write-Output "Feito: $($_.name)"
}