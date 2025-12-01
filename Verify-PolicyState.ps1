# 1. Disconnect the old session
Disconnect-MgGraph

# 2. Re-connect with BOTH Policy and Group permissions
Connect-MgGraph -Scopes "Policy.Read.All", "Group.Read.All"

# 3. Now try the command again
Get-MgGroup -Filter "DisplayName eq 'Sec-BreakGlass-Exclusion'" | Select-Object Id