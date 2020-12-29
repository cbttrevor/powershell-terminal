# Examine the Beep static method parameters
[System.Console]::Beep

# Try beeping
[Console]::Beep(500, 1000)

while ($true) {
    $Tone = Get-Random -Minimum 500 -Maximum 2000
    $Length = Get-Random -Minimum 100 -Maximum 800
    [Console]::Beep($Tone, $Length)
}

while ($true) {
    $Tone = [int](1300 + 300*[Math]::Sin([DateTime]::UtcNow.Millisecond))
    $Length = 100
    $Tone
    [Console]::Beep($Tone, $Length)
}