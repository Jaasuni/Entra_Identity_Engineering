# 🔐 Project: Custom Graph API Integration (Workload Identity)

**Role:** Identity Architect
**Status:** Registered & Consented
**Technology:** Entra ID App Registrations, OAuth 2.0, Microsoft Graph API

## 1. Executive Summary
Designed a secure service principal identity (`Graph-Audit-Tool`) to facilitate automated background reporting. Implemented "Least Privilege" by scoping permissions strictly to `User.Read.All` and requiring explicit Admin Consent, preventing over-privileged access tokens.

## 2. Configuration Details

### 2.1 Identity Architecture
* **Application (Client) ID:** `[REDACTED_FOR_SECURITY]`
* **Object Type:** Single Tenant Application.
* **Auth Flow:** Client Credentials Flow (Daemon/Background Service).

### 2.2 Permission Scoping (Least Privilege)
| API | Permission | Type | Justification |
| :--- | :--- | :--- | :--- |
| Microsoft Graph | `User.Read` | Delegated | Allow signed-in user to read own profile. |
| Microsoft Graph | `User.Read.All` | Application | Allow automation script to audit user license status (No user present). |

### 2.3 Consent Framework
* **Admin Consent:** Explicitly granted for `User.Read.All` to authorize the background service for the tenant.

## 3. Validation (PowerShell Audit)
*Verification of the architectural distinction between the Application Object (Blueprint) and Service Principal (Local Identity).*

```powershell
# Connect to Graph
Connect-MgGraph -Scopes "Application.Read.All"

# 1. Retrieve the App Registration (The Definition)
$AppReg = Get-MgApplication -Filter "DisplayName eq 'Graph-Audit-Tool'"

# 2. Retrieve the Service Principal (The Enterprise App Identity)
$SP = Get-MgServicePrincipal -Filter "AppId eq '$($AppReg.AppId)'"

# 3. Prove they are distinct objects (Exam Critical Concept)
Write-Host "Blueprint ID: $($AppReg.Id)"
Write-Host "Identity ID:  $($SP.Id)"
