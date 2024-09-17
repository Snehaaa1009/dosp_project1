if ($args.Count -lt 2) {
    Write-Host "Usage: .\script.ps1 <executable> <arg1> <arg2> ... <argN>"
    exit 1
}

# Extract the executable path and the arguments
$executablePath = $args[0]
$executableArgs = $args[1..($args.Length - 1)]

# Check if the file exists
if (-Not (Test-Path $executablePath)) {
    Write-Host "Executable file not found: $executablePath"
    exit 1
}

# Measure real time, user time, and system time using Measure-Command
$executionTime = Measure-Command {
    Start-Process -FilePath $executablePath -ArgumentList $executableArgs -Wait
}

# Real time
$realTime = [math]::Round($executionTime.TotalSeconds, 2)

# CPU time calculation for the process: user time and system time
$process = Start-Process -FilePath $executablePath -ArgumentList $executableArgs -PassThru
$process.WaitForExit()
$cpuTime = $process.UserProcessorTime.TotalSeconds + $process.PrivilegedProcessorTime.TotalSeconds
$cpuTime = [math]::Round($cpuTime, 2)

# Handle small real time cases
if ($realTime -lt 0.01) {
    Write-Host "Real Time too small to measure. Cores used: N/A"
    exit 0
}

# Calculate the ratio of CPU time to real time
$cpuRealRatio = [math]::Round($cpuTime / $realTime, 2)

# Get the number of logical CPU cores
$numCores = (Get-WmiObject Win32_Processor).NumberOfLogicalProcessors

# Display feedback based on the ratio and calculate cores used
if ($cpuRealRatio -lt 1.01) {
    Write-Host "Cores used: Very low parallelism (CPU time close to Real time)"
} elseif ($cpuRealRatio -gt $numCores) {
    Write-Host "Cores used: More than available cores! Something is off."
} else {
    Write-Host "Cores used: Parallelism effective with approx. $([math]::Floor($cpuRealRatio)) cores"
}

# Display the results
Write-Host "Real Time: $realTime seconds"
Write-Host "CPU Time: $cpuTime seconds"
Write-Host "CPU Time to Real Time Ratio: $cpuRealRatio"
Write-Host "Number of Logical CPU Cores: $numCores"
