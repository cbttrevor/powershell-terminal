# Let's write a helper function to reposition the cursor
function Set-Cursor {
    [CmdletBinding()]
    param (
        [int] $x = 0,
        [int] $y = 0
    )
    $Host.UI.RawUI.CursorPosition = [System.Management.Automation.Host.Coordinates]::new($x, $y)
}

Clear-Host

function Draw-Box {
    # Draw the top line
    Set-Cursor
    0..9 | % { 
        Write-Host -Object "`u{2588}" -NoNewline
    }

    # Draw the left line
    Set-Cursor
    0..4 | % {
        Set-Cursor -x 0 -y $_
        Write-Host -Object "`u{2588}" -NoNewline
    }

    # Draw the right line
    Set-Cursor
    0..4 | % { 
        Set-Cursor -x 9 -y $_
        Write-Host -Object "`u{2588}" -NoNewline
    }

    # Draw the bottom line
    Set-Cursor -y 4
    0..9 | % { 
        Write-Host -Object "`u{2588}" -NoNewline
    }


}
Clear-Host; Draw-Box;