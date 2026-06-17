$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path | Resolve-Path -Relative
$index = Join-Path (Resolve-Path "$projectRoot\..") 'index.html'

if (-Not (Test-Path $index)) { Write-Error "No se encontró index.html en $index"; exit 1 }

$content = Get-Content $index -Raw

$files = @('buzologooriginal.png','buzoori.png','jarraoro.png','llaveroori.jpg','rememujer.jpg','remenegra.jpg')

foreach ($f in $files) {
    $escaped = [Regex]::Escape($f)
    $content = $content -replace ('src="\./' + $escaped + '"'), ('src="assets/images/products/' + $f + '"')
    $content = $content -replace ('src="' + $escaped + '"'), ('src="assets/images/products/' + $f + '"')
    $content = $content -replace ("src='./" + $escaped + "'"), ("src='assets/images/products/" + $f + "'")
    $content = $content -replace ("src='" + $escaped + "'"), ("src='assets/images/products/" + $f + "'")
}

Set-Content $index -Value $content -Encoding UTF8
Write-Output "Rutas actualizadas en $index"
