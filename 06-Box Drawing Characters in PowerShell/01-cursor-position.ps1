# Clear the buffer, to start with a clean slate
Clear-Host

# Set the cursor position
$Host.UI.RawUI.CursorPosition = [System.Management.Automation.Host.Coordinates]::new(38,10)

# Write out some text
Write-Host -NoNewline -Object Hello