# Detect if a key can be read
$Host.UI.RawUI.KeyAvailable

# ReadKey is a blocking operation
$Host.UI.RawUI.ReadKey()

# You can also pass a few options into ReadKey()
$Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyUp,IncludeKeyDown')

# Let's explore the different values on the ReadKeyOptions enumeration
[System.Management.Automation.Host.ReadKeyOptions] | Get-Member -Static

