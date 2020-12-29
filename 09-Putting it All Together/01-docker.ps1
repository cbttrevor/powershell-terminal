class DockerManager {
    $ContainerList
    $RawUI = $Host.UI.RawUI
    [int] $SelectedItem = 0
    $PreviousBufferSize

    DockerManager() {
        # Initialize stuff here
        $this.PreviousBufferSize = $this.RawUI.BufferSize
        $this.PrintContainers()
    }

    SetCursor($x = 0, $y = 0) {
        [Console]::CursorVisible = $false
        $this.RawUI.CursorPosition = [System.Management.Automation.Host.Coordinates]::new($x, $y)
    }

    UpdateContainers() {
        $this.ContainerList = docker ps --format '{{.ID}}'
    }

    PrintContainers() {
        Clear-Host
        Write-Host -Object 'Refreshing container list ...'
        $this.UpdateContainers()
        Clear-Host
        foreach ($Container in $this.ContainerList) {
            $this.SetCursor(2, $this.ContainerList.IndexOf($Container))
            Write-Host -Object "`e[38;2;100;100;0m$Container`e[m"
        }
        $this.PrintStatusBar()
        $this.PrintSelection()
    }

    PrintSelection() {
        $this.ClearSelection()
        $this.SetCursor(0, $this.SelectedItem)
        Write-Host -Object X -NoNewline
    }

    PrintStatusBar() {
        $this.SetCursor(0, $this.RawUI.BufferSize.Height-1)
        
        $Message = 'Welcome to Docker Manager'
        $FormattedMessage = "`e[48;2;150;125;255m$Message"
        Write-Host -Object $FormattedMessage -NoNewline
        
        $StatusCharCount = $this.RawUI.BufferSize.Width - $Message.Length
        $String = "`e[38;2;150;125;255m" + ("`u{2588}" * $StatusCharCount) + "`e[m"
        Write-Host -NoNewline -Object $String
    }

    ClearSelection() {
        0..($this.ContainerList.Count-1) | % { 
            $this.SetCursor(0, $PSItem)
            Write-Host -Object ' ' -NoNewline
        }
    }

    RunSampleContainers() {
        1..4 | % { docker run --rm -dit python }
    }

    Run() {
        do {
            Start-Sleep -Milliseconds 5
            if ($this.RawUI.KeyAvailable) {
                $KeyInfo = $this.RawUI.ReadKey('NoEcho,IncludeKeyUp')
                # Write-Host -Object 'Read key'
            }
            switch ($KeyInfo) {
                { $KeyInfo.VirtualKeyCode -eq 85 } {
                    $this.PrintContainers()
                    break
                }
                { $KeyInfo.VirtualKeyCode -eq 38 } {
                    if ($this.SelectedItem -gt 0) {
                        $this.SelectedItem--
                    }
                    $this.PrintSelection()
                }
                { $KeyInfo.VirtualKeyCode -eq 40 } {
                    if ($this.SelectedItem -lt ($this.ContainerList.Count-1)) {
                        $this.SelectedItem++
                    }
                    $this.PrintSelection()
                }
                { $KeyInfo.VirtualKeyCode -eq 46 } {
                    docker rm -f $this.ContainerList[$this.SelectedItem]
                }
                default {
                    # No action
                    if ($PSItem) {
                    #    Write-Host -Object ($PSItem | ConvertTo-Json -Compress)
                       #Write-Host $this.ContainerList.Count

                    }
                    break
                }
            }
            Remove-Variable -Name KeyInfo -ErrorAction Ignore
        } while ($true)   
    }
}

[DockerManager]::new().Run()