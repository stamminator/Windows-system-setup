# File Explorer sometimes leaves orphaned explorer.exe processes lying around. 
# When the "Launch folder windows in a separate process" setting in Folder Options
# is enabled, I find it happens every single time a File Explorer window is closed.
# This script cleans those up while leaving the main explorer process and any active
# File Explorer windows untouched. Why doesn't File Explorer clean up after itself 
# by default? Who knows.

get-process -name explorer | where-object { $_.MainWindowHandle -eq 0 } | stop-process -force
