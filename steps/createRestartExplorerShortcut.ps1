$s = (New-Object -COM WScript.Shell).CreateShortcut("$env:USERPROFILE\path\restart-explorer.lnk");

$s.TargetPath = "powershell";
$s.Arguments = '-c "stop-process -name explorer –force"';
$s.WorkingDirectory = $null;
$s.IconLocation = "%SystemRoot%\System32\SHELL32.dll,238"
$s.WindowStyle = 7
$s.Save();