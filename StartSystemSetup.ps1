# Define log file path
$logPath = "logs\log.txt"

# Function to log messages
function Log-Message {
    param([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp : $message" | Out-File -Append -FilePath $logPath
}

# Function to execute a script with error handling
function Run-Step {
    param([string]$scriptPath)
    
    try {
        Log-Message "Starting $scriptPath"
        . $scriptPath
        Log-Message "Successfully executed $scriptPath"
    }
    catch {
        Log-Message "Error in ${scriptPath}: $_"
    }
}

Run-Step "steps\createRestartExplorerShortcut.ps1";