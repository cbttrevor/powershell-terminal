# Install the Console GUI Tools
Install-Module -Name Microsoft.PowerShell.ConsoleGuiTools -Scope CurrentUser -Force

# Explore the commands in the module
Get-Command -Module Microsoft.PowerShell.ConsoleGuiTools

# Export some data in the console grid view
Get-Process | Out-ConsoleGridView