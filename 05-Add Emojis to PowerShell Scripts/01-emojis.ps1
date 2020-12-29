# Install the Emoji PowerShell module
Install-Module -Name Emojis -Scope CurrentUser -Force

# Find the commands exported by the module
Get-Command -Module Emojis

Get-Emoji -Name 'AIRPLANE ARRIVING'

# emoji alias is short for Get-Emoji
emoji 'FIRE ENGINE', FIRE, 'FIREWORK SPARKLER'