# $Host is an "automatic variable" in PowerShell
$Host

# PowerShell isn't just a stand-alone process. It's an engine that can be embedded into other applications.
# You can see the "host" application that's running PowerShell. It's different for VSCode PowerShell and Console Host.
'{0} {1}' -f $Host.Name, $Host.Version

# The UI property on the $Host variable exposes richer terminal functionality
$Host.UI.Prompt('Hello', 'Hello', @(1,2,3))
$Host.UI.PromptForChoice('User Account Selector', 'Please select a user account', @('Administrator', 'User1', 'User2'), 1)

# The RawUI property exposes raw terminal functionality.
#  - Move the cursor
#  - Monitor the window and buffer sizes
$Host.UI.RawUI | Get-Member

# Retrieve the buffer contents
$Result = $Host.UI.RawUI.GetBufferContents(([System.Management.Automation.Host.Rectangle]::new(0,0, $Host.UI.RawUI.BufferSize.Height, $Host.UI.RawUI.BufferSize.Width)))
$Result.Count

# Create a new buffer
$NewBuffer = $Host.UI.RawUI.NewBufferCellArray($Host.UI.RawUI.BufferSize.Width, $Host.UI.RawUI.BufferSize.Height, [System.Management.Automation.Host.BufferCell]::new('a', [System.ConsoleColor]::Gray, [System.ConsoleColor]::Black, [System.Management.Automation.Host.BufferCellType]::Complete))
$NewBuffer.Count

# Apply the new buffer to the UI
$Host.UI.RawUI.SetBufferContents([System.Management.Automation.Host.Coordinates]::new(0,0), $NewBuffer)
