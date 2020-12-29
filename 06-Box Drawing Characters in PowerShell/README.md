## Learning Objectives

* You can draw box characters using special unicode characters
* In PowerShell double-quoted strings, you can use the following syntax to write a unicode character: ``"`u{2588}"``
* _Alternatively_, you can embed the character directly inside your PowerShell script.
  * ⚠ Make sure your script file encoding is set to a unicode supported format, such as UTF-8
* Wikipedia has an [excellent reference](https://en.wikipedia.org/wiki/Box-drawing_character) for unicode box characters
* Set cursor coordinates using the `$Host.UI.RawUI.CursorPosition` property.
  * Assign an instance of `[System.Management.Automation.Host.Coordinates]` to it.
* Use the `Write-Host` command with the `-NoNewLine` parameter to write out characters