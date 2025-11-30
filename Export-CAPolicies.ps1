<#
.SYNOPSIS
    Disaster Recovery: Export all Entra ID Conditional Access Policies.
    
.DESCRIPTION
    This script connects to Microsoft Graph, retrieves all Conditional Access policies,
    and exports them as individual JSON files to a timestamped backup directory.
    This serves as a "Snapshot" for change management and disaster recovery.

.NOTES
    Portfolio Script for: github.com/wigginsjason
    Exam Objective: Automate Identity Governance
#>

# 1. Connect to Microsoft Graph with Least Privilege
# We only need to READ policies, not write them.
Write-Host "Connecting to Microsoft Graph..." -ForegroundColor Cyan
Connect-MgGraph -Scopes "Policy.Read.All"

# 2. Retrieve all Conditional Access Policies
Write-Host "Retrieving policies from Entra ID..." -ForegroundColor Cyan
$policies = Get-MgIdentityConditionalAccessPolicy

if ($policies.Count -eq 0) {
    Write-Warning "No Conditional Access policies found in this tenant."
    return
}

# 3. Create a Timestamped Backup Directory
# Format: C:\CABackup\YYYY-MM-DD
$dateStamp = Get-Date -Format "yyyy-MM-dd"
$exportPath = "C:\CABackup\$dateStamp"

if (-not (Test-Path $exportPath)) {
    New-Item -ItemType Directory -Path $exportPath -Force | Out-Null
    Write-Host "Created backup directory: $exportPath" -ForegroundColor Green
}

# 4. Export Loop
# We sanitize the filename to prevent errors with special characters in policy names
foreach ($policy in $policies) {
    $safeName = $policy.DisplayName -replace '[^a-zA-Z0-9]', '_'
    $fileName = "$exportPath\$safeName.json"

    # Convert the object to JSON depth 10 to capture nested conditions (locations, apps)
    $policy | ConvertTo-Json -Depth 10 | Out-File $fileName
    
    Write-Host "  [+] Exported: $($policy.DisplayName)" -ForegroundColor Gray
}

Write-Host "----------------------------------------------------" -ForegroundColor Green
Write-Host "Backup Complete. Total Policies: $($policies.Count)" -ForegroundColor Green
Write-Host "Location: $exportPath" -ForegroundColor Green
Write-Host "----------------------------------------------------" -ForegroundColor Green