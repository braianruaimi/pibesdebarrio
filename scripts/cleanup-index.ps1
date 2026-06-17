$f = 'C:\Users\Juan\Desktop\pibes de barrio\pibesdebarrio\index.html'
$c = Get-Content -Path $f -Raw

# Reemplazar la hoja de estilos de Next por la hoja centralizada
$c = [Regex]::Replace($c, '<link[^>]+href="/_next/static/css/[^"]+"[^>]*>', '<link rel="stylesheet" href="assets/css/style.css" />', 'IgnoreCase')

# Eliminar scripts que cargan chunks de Next.js y build/ssg manifest
$c = [Regex]::Replace($c, '<script[^>]+src="/_next/static/[^"]+"[^>]*>\s*</script>', '', 'IgnoreCase')

# Eliminar etiquetas <noscript data-n-css=""></noscript> si hay duplicados
$c = $c -replace '<noscript data-n-css=""></noscript>',''

# Insertar el script app.js antes del cierre de body si no existe
if ($c -notmatch 'assets/js/app.js') {
    $c = [Regex]::Replace($c, '(?s)</body>','<script src="assets/js/app.js"></script></body>')
}

Set-Content -Path $f -Value $c -Encoding UTF8
Write-Output "index.html limpiado y actualizado"
