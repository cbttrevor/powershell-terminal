do {
    Start-Sleep -Milliseconds 100
    if ($Host.UI.RawUI.KeyAvailable) {
        Write-Host -ForegroundColor Red -Object Captured
        $KeyInfo = $Host.UI.RawUI.ReadKey('NoEcho, IncludeKeyUp')
    }

    switch ($KeyInfo) {
        { $PSItem.VirtualKeyCode -eq 65 -and $PSItem.ControlKeyState -eq 'LeftCtrlPressed' } {
            Write-Host -ForegroundColor Blue -Object (Get-Process -Id $Pid).CPU
            break
        }
        default {
            # Write-Host -ForegroundColor White -Object 'Nothing happened'
            # Write-Host -ForegroundColor White -Object ($PSItem | ConvertTo-Json)
            break
        }
    }
    Remove-Variable -Name KeyInfo -ErrorAction Ignore
} while ($true)