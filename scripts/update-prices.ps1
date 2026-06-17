# Script para actualizar el precio del "Vaso Termico Edicion Limitada"
# Reemplaza el precio numérico en el bundle y el texto visible en index.html

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Resolve-Path "$root\.."

$indexFile = Join-Path $projectRoot 'index.html'
$bundle = Join-Path $projectRoot '_next\static\chunks\pages\index-796cbcfa8dcc4711.js'

if (Test-Path $indexFile) {
    (Get-Content $indexFile -Raw) -replace '14\.390', '14.999' | Set-Content $indexFile -Encoding UTF8
    Write-Output "Actualizado $indexFile"
} else { Write-Warning "No se encontró $indexFile" }

if (Test-Path $bundle) {
    (Get-Content $bundle -Raw) -replace 'price:14390', 'price:14999' | Set-Content $bundle -Encoding UTF8
    Write-Output "Actualizado $bundle"
} else { Write-Warning "No se encontró $bundle" }

Write-Output "Hecho. Limpia caches y recarga la página (DevTools -> Application)."
