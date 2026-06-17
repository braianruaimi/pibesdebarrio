$f = 'C:\Users\Juan\Desktop\pibes de barrio\pibesdebarrio\index.html'
$content = Get-Content -Path $f -Raw
if ($content -notmatch '<script src="assets/js/app.js"></script>') {
    $content = [Regex]::Replace($content, '(?s)</body>\s*</html>', '<script src="assets/js/app.js"></script></body></html>')
    Set-Content -Path $f -Value $content -Encoding UTF8
    Write-Output "Insertado script en index.html"
} else {
    Write-Output "Script ya presente en index.html"
}
