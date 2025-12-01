# 🛡️ Project: Phishing-Resistant Identity Perimeter

## 1. Executive Summary
This project hardened the administrative perimeter of the Microsoft Entra ID tenant by enforcing **Phishing-Resistant Multifactor Authentication (MFA)**. This mitigates "Adversary-in-the-Middle" (AiTM) attacks where attackers proxy standard MFA push notifications.

**Exam Objective Covered:** SC-300 Domain 2 (Implement Authentication and Access Management).

## 2. Technical Implementation

### 2.1 Authentication Strengths
Instead of standard MFA, I utilized **Conditional Access Authentication Strengths** to restrict access to specific methods:
* **Allowed:** FIDO2 Security Keys / Passkeys (Device-Bound).
* **Blocked:** SMS, Voice, and Standard Push Notifications (Microsoft Authenticator).

### 2.2 Policy Logic (`CA-002-RequirePhishingResistant-Admins`)
* **Target:** High-Privilege Roles (Global Admin, Security Admin).
* **Condition:** Accessing *Any Cloud App*.
* **Grant Control:** Require Authentication Strength: "Phishing-Resistant MFA".
* **Resilience:** Excluded "Break Glass" Emergency Access Group (`Sec-BreakGlass-Exclusion`) to prevent tenant lockout.

## 3. Validation Strategy
* **Simulation:** Validated policy impact using the **Conditional Access What If** tool prior to enforcement.
* **Verification:** Confirmed policy state (`enabled`) using Microsoft Graph PowerShell.
* **Testing:** Successfully authenticated using a device-bound Passkey on iOS/Windows.

## 4. Artifacts
* [Policy JSON Configuration](../Policies/CA-002-RequirePhishingResistant-Admins.json)
* [Validation Script](../Scripts/Verify-PolicyState.ps1)
