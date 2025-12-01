# 1. Connect to Microsoft Graph with Read permissions for policies
Connect-MgGraph -Scopes "Policy.Read.All"

# 2. Define the Policy Name you just created
$PolicyName = "CA001-BlockLegacyAuth-AllUsers"

# 3. Get the Policy Object
$Policy = Get-MgIdentityConditionalAccessPolicy -Filter "displayName eq '$PolicyName'"

# 4. The Architect's Export: Convert to JSON
if ($Policy) {
    # Create a clean filename
    $Filename = "./$($PolicyName)_Backup_$(Get-Date -Format 'yyyyMMdd').json"
    
    # Export to JSON (Depth 5 ensures nested objects like 'conditions' are captured)
    $Policy | ConvertTo-Json -Depth 5 | Out-File $Filename
    
    Write-Host "Success! Policy exported to $Filename" -ForegroundColor Green
    Write-Host "Action: Upload this file to your GitHub 'Entra_Identity_Engineering' repo." -ForegroundColor Cyan
} else {
    Write-Host "Error: Policy '$PolicyName' not found." -ForegroundColor Red
}