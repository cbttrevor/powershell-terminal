do {
    $KeyInfo = $Host.UI.RawUI.KeyAvailable ? $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyUp') : $null
    if ($KeyInfo) { Write-Host -Object ($KeyInfo | ConvertTo-Json) }
    Start-Sleep -Milliseconds 20
} while ($true)