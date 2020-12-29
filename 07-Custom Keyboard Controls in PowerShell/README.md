## Learning Objectives

* You can prompt for user input using `Read-Host`
  * This isn't a very powerful tool though
* You can control PowerShell Terminal UIs by capturing keyboard strokes instead
* The PowerShell Host RawUI has a `ReadKey()` method as well as a `KeyAvailable` property
* When `KeyAvailable` is `$true`, you can capture the key stroke with the `ReadKey` method