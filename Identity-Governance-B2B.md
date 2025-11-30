# ⏳ Project: Automated B2B Guest Governance

**Role:** Identity Architect
**Status:** Deployed
**Technology:** Entra ID Entitlement Management, Access Packages

## 1. Executive Summary
Solved the "Guest User Sprawl" issue by implementing Entitlement Management. Replaced manual ad-hoc invitations with a self-service Access Package (`Vendor-Onboarding-Pack`) that enforces mandatory approval workflows and automatic 30-day expiration.

## 2. Governance Architecture

### 2.1 The Container (Catalog)
* **Name:** `Vendor-Project-Alpha`
* **Scope:** Dedicated container for vendor resources to prevent permission bleed into internal datasets.
* **Resources Bundled:**
    * Project SharePoint Site (Role: Visitor)
    * Microsoft Team (Role: Member)
    * Enterprise SaaS App (Role: User)

### 2.2 The Policy (Lifecycle)
* **Target Audience:** External Users (Connected Organizations).
* **Approval Workflow:** Single-stage approval required (Internal Sponsor).
* **Expiration:** Automatic removal of access/guest account after **30 Days**.

## 3. Validation (Audit)
*Robust PowerShell script used to fetch all requests and filter client-side (bypassing API version discrepancies).*

```powershell
# 1. Fetch ALL requests from the Graph API (No Server-Side Filter)
# This uses the "Nuclear Option" to bypass API schema version conflicts
$ApiUrl = "[https://graph.microsoft.com/v1.0/identityGovernance/entitlementManagement/assignmentRequests](https://graph.microsoft.com/v1.0/identityGovernance/entitlementManagement/assignmentRequests)"
$Response = Invoke-MgGraphRequest -Method GET -Uri $ApiUrl

# 2. Filter Client-Side for 'PendingApproval'
# We inspect the raw JSON response locally
$AllRequests = $Response.value
$Pending = $AllRequests | Where-Object { $_.requestState -eq "PendingApproval" }

# 3. Output Results
if ($Pending) {
    Write-Host "Action Required: $($Pending.Count) pending requests." -ForegroundColor Red
    $Pending | Select-Object id, createdDateTime, requestor
} else {
    Write-Host "System Healthy: No pending approvals found." -ForegroundColor Green
}
