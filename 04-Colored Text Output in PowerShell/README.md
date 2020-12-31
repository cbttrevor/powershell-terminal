## Learning Objectives

* You can use [ANSI escape codes](https://en.wikipedia.org/wiki/ANSI_escape_code) to color text in PowerShell
* Your terminal will need to properly support ANSI escape codes
* ANSI escape codes enable you to use a 24-bit color palette to color your output
* The `-ForegroundColor` and `-BackgroundColor` parameters on the `Write-Host` command only accept 16 pre-defined color values
  * Pre-defined console colors are determined by the color palette in your terminal
* Use PowerShell ANSI escape character