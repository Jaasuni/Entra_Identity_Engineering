# 🔐 Project: Enterprise SaaS Integration (SAML SSO)

**Role:** Identity Engineer  
**Status:** Validated  
**Technology:** Microsoft Entra ID, SAML 2.0, Enterprise Applications, Microsoft Graph API

## 1. Executive Summary
Integrated a third-party SaaS application ("Microsoft Entra SAML Toolkit") with Microsoft Entra ID to enable Single Sign-On (SSO). This implementation eliminates the need for separate passwords, enforces tenant security policies (MFA), and centralizes access lifecycle management.

## 2. Solution Architecture

### 2.1 Application Configuration
* **App Name:** Microsoft Entra SAML Toolkit
* **Sign-On Protocol:** SAML 2.0 (SP-Initiated & IDP-Initiated)
* **Assignment Mode:** `User Assignment Required` (Prevents unauthorized access).

### 2.2 SAML Trust Relationship
* **Identifier (Entity ID):** `https://samltoolkit.azurewebsites.net`
* **Reply URL (ACS):** `https://samltoolkit.azurewebsites.net/SAML/Consume/20587`
* **Certificate:** Standard Token Signing Certificate (SHA-256).

## 3. Validation & Auditing

### 3.1 Backend Configuration Audit (Microsoft Graph API)
*Verification of Service Principal configuration and SAML mode enforcement via Graph Explorer.*

**API Endpoint:** `GET https://graph.microsoft.com/v1.0/servicePrincipals?$filter=displayName eq 'Microsoft Entra SAML Toolkit'`

**Response Evidence:**
```json
{
    "preferredSingleSignOnMode": "saml",
    "preferredTokenSigningKeyThumbprint": "69FB0E8E3E399302FF41BF09ADCA06EB3045B15C",
    "replyUrls": [
        "[https://samltoolkit.azurewebsites.net/SAML/Consume/20587](https://samltoolkit.azurewebsites.net/SAML/Consume/20587)"
    ],
    "servicePrincipalNames": [
        "[https://samltoolkit.azurewebsites.net](https://samltoolkit.azurewebsites.net)",
        "87e8d9b4-f4a4-4181-a57f-3befb08373dc"
    ],
    "servicePrincipalType": "Application"
}
```
### 3.2 Successful Auth Flow
Successful token issuance and claim consumption by the Service Provider.
<img width="1441" height="783" alt="Graph_ServicePrincipal_Audit png" src="https://github.com/user-attachments/assets/9c8270b3-365a-4ceb-9985-d5f6c3886243" />
<img width="1625" height="894" alt="SAML_SSO_Success png" src="https://github.com/user-attachments/assets/97a8b1c6-fe6e-48cf-aaf4-5051dc4596f6" />
