class DockerManager {
    $ContainerList
    $RawUI = $Host.UI.RawUI
    [int] $SelectedItem = 0
    $PreviousBufferSize
    [datetime] $LastWindowResize = (Get-Date)

    DockerManager() {
        # Initialize stuff here
        $this.RunSampleContainers()
        $this.PreviousBufferSize = $this.RawUI.BufferSize
        $this.PrintContainers()
    }

    SetCursor($x = 0, $y = 0) {
        [Console]::CursorVisible = $false
        $this.RawUI.CursorPosition = [System.Management.Automation.Host.Coordinates]::new($x, $y)
    }

    UpdateContainers() {
        $this.ContainerList = @(docker ps --format '{{.ID}}')
    }

    PrintContainers() {
        
        Clear-Host
        Write-Host -Object 'Refreshing container list ...'
        $this.UpdateContainers()

        Clear-Host

        if (!$this.ContainerList) {
            $this.SetCursor(2,0)
            Write-Host -Object 'No Docker containers running'
        }
        else {
            foreach ($Container in $this.ContainerList) {
                $this.SetCursor(2, $this.ContainerList.IndexOf($Container))
                Write-Host -Object "`e[38;2;100;100;0m$Container`e[m"
            }
        }

        $this.PrintStatusBar()
        $this.UpdateSelection()
        $this.PrintSelection()
    }

    UpdateSelection() {
        $this.SelectedItem = $this.SelectedItem -lt 0 ? 0 : $this.SelectedItem
        if ($this.SelectedItem -gt ($this.ContainerList.Count-1)) {
            $this.SelectedItem = $this.ContainerList.Count-1
        }
    }

    PrintSelection() {
        $this.ClearSelection()
        if (!$this.ContainerList) { return }
        $this.SetCursor(0, $this.SelectedItem)
        Write-Host -Object (emoji MUSHROOM) -NoNewline
    }

    PrintStatusBar() {
        $this.SetCursor(0, $this.RawUI.BufferSize.Height-1)
        
        $LeftMessage = 'Welcome to Docker Manager'
        $LeftFormattedMessage = "`e[48;2;150;125;255m$LeftMessage"
        
        $ContainerCount = $this.ContainerList ? $this.ContainerList.Count : 0
        $RightMessage = 'Containers: {0}' -f $ContainerCount
        $RightFormattedMessage = "`e[48;2;150;125;255m$RightMessage`e[m"

        $StatusCharCount = $this.RawUI.BufferSize.Width - $LeftMessage.Length - $RightMessage.Length
        $String = $LeftFormattedMessage + "`e[38;2;150;125;255m" + ("`u{2588}" * $StatusCharCount) + "`e[m" + $RightFormattedMessage
        Write-Host -NoNewline -Object $String
    }

    ClearSelection() {
        0..($this.RawUI.BufferSize.Height-2) | % { 
            $this.SetCursor(0, $PSItem)
            Write-Host -Object '  ' -NoNewline
        }
    }

    RunSampleContainers() {
        1..2 | % { docker run --rm -dit python }
    }

    RemoveContainer([string] $Id) {
        if (!$this.ContainerList) { return }
        Clear-Host
        Write-Host -Object ('Removing container ID {0}' -f $Id)
        $null = docker rm -f $Id
        $this.PrintContainers()
    }

    ResizeWindow() {
        # Don't update too often, if the user is actively resizing the window
        if (((Get-Date) - $this.LastWindowResize).TotalMilliseconds -lt 800) { return }
        if ($this.RawUI.BufferSize -ne $this.PreviousBufferSize) {
            $this.PreviousBufferSize = $this.RawUI.BufferSize
            $this.LastWindowResize = Get-Date
            $this.PrintContainers()
        }
    }

    Run() {
        :exitapp
        do {
            Start-Sleep -Milliseconds 5
            if ($this.RawUI.KeyAvailable) {
                $KeyInfo = $this.RawUI.ReadKey('NoEcho,IncludeKeyUp')
                # Write-Host -Object 'Read key'
            }
            switch ($KeyInfo) {
                { $PSItem.VirtualKeyCode -eq 85 } {
                    $this.PrintContainers()
                    break
                }
                { $PSItem.VirtualKeyCode -eq 38 } {
                    if ($this.SelectedItem -gt 0) {
                        $this.SelectedItem--
                    }
                    $this.PrintSelection()
                }
                { $PSItem.VirtualKeyCode -eq 40 } {
                    if ($this.SelectedItem -lt ($this.ContainerList.Count-1)) {
                        $this.SelectedItem++
                    }
                    $this.PrintSelection()
                }
                { $PSItem.VirtualKeyCode -eq 46 } {
                    $this.RemoveContainer($this.ContainerList[$this.SelectedItem])
                }
                { $PSItem.VirtualKeyCode -eq 81 -and $PSItem.ControlKeyState -eq 0 } {
                    Clear-Host
                    break exitapp
                }
                default {
                    # No action
                    if ($PSItem) {
                        # Write-Host -Object ($PSItem | ConvertTo-Json -Compress)
                        # Write-Host $this.ContainerList.Count
                    }
                    $this.ResizeWindow()
                    break
                }
            }
            Remove-Variable -Name KeyInfo -ErrorAction Ignore
        } while ($true)
    }
}

[DockerManager]::new().Run()