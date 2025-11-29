# ⏳ Project: Privileged Identity Management (JIT Access)

**Role:** Identity Governance Admin  
**Status:** Enforced  
**Technology:** Microsoft Entra PIM, Just-In-Time (JIT) Access

## 1. Executive Summary
Implemented a Least Privilege administrative model using Privileged Identity Management (PIM). Converted standing "User Administrator" access to "Eligible" status, requiring Just-In-Time (JIT) activation with mandatory justification and time-bound duration (1 hour). This reduces the attack surface by ensuring no accounts hold permanent elevated privileges.

## 2. Governance Architecture

### 2.1 Role Configuration
* **Target Role:** User Administrator (Can reset passwords, but cannot manage other admins).
* **Assignment Type:** `Eligible` (Requires manual activation).
* **Principal:** Helpdesk Staff (Simulated user "Alex Wilber").

### 2.2 Activation Policy
* **Max Duration:** 4 Hours.
* **Justification:** Required (Must enter ticket number).
* **MFA:** Enforced on activation.
* **Approval:** Disabled for this role (Auto-approval enabled for efficiency).

## 3. Validation

### 3.1 End-User Experience (JIT Activation)
*Evidence of the user successfully activating the role for a specific time window.*

<img width="1914" height="529" alt="PIM_JIT_Activation png" src="https://github.com/user-attachments/assets/736a5c0f-a5f2-4104-a607-d7993dc49f21" />


### 3.2 Compliance Auditing
*Admin audit logs capturing the elevation event, justification reason, and expiration time.*


<img width="1632" height="804" alt="PIM_Audit_Log png" src="https://github.com/user-attachments/assets/40820aac-5c1b-4fdc-98f8-ef0813863671" />

## 4. Operational Procedures
1.  **Request:** User navigates to PIM -> My Roles -> Activate.
2.  **Audit:** Security team reviews "PIM Resource Audit" monthly for anomalous activations or missing justifications.
