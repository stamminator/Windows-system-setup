# If the "Launch folder windows in a separate process" setting in Folder Options is enabled,
# this script closes all explorer.exe processes that do not have a corresponding active window
# while leaving active File Explorer windows untouched. Affected explorer.exe processes include
# the main process that controls taskbar, start menu, etc. (which will automatically restart), 
# as well as any orphaned explorer.exe processes that may have been left behind by closed 
# File Explorer windows.
#
# If "Launch folder windows in a separate process" is disabled, this effectively does the same
# thing as restarting explorer from Task Manager, so you'll lose all File Explorer windows. In
# that case, you might as well just run `stop-process -name explorer –force`

add-type -name User32 -namespace WinAPI -memberDefinition @"
    [DllImport("user32.dll")]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out int lpdwProcessId);
"@

$activeExplorerPIDs = @(new-object -comObject Shell.Application).Windows() | 
    where-object { $_.FullName -like '*\explorer.exe' } | 
    foreach-object {
        $processId = 0
        [WinAPI.User32]::GetWindowThreadProcessId([IntPtr]$_.HWND, [ref]$processId) | out-null
        $processId 
    }

get-process -name explorer | 
    where-object { $activeExplorerPIDs -notcontains $_.Id } | 
    stop-process -force
