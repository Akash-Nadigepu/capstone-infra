# Capstone Project – Infrastructure as Code (IaC)

## 📌 Overview

This repository contains the **Infrastructure as Code (IaC)** setup for the **User Management Capstone Project** using Terraform and Bicep. It provisions all necessary Azure resources to host and run a production-grade application with proper CI/CD pipelines, security, monitoring, and high availability across two Azure regions.

---

## 🧱 Modules

### ✅ Terraform Modules (Region 1 – Primary: `polandcentral`)
- `ACR` – Azure Container Registry for app images
- `AKS` – Azure Kubernetes Service (primary cluster)
- `KeyVault` – Stores secrets like SQL credentials
- `SQLDatabase` – Azure SQL DB server and user DB
- `VirtualNetwork` – Custom VNet and subnets for AKS, App Gateway, SQL
- `TrafficManager` – DNS-based failover setup (Terraform-managed)
- `terraform-backend` – Backend state configuration (Azure Blob)

### ✅ Bicep Modules (Region 2 – Secondary: `koreacentral`)
- Secondary `AKS` cluster
- Secondary `VNet` with equivalent subnet structure
- Attached to existing **Traffic Manager** profile for DR

---

## 🧪 CI/CD Pipelines

### 1. CI Pipeline (Per Service)
- **Tools Integrated**:
  - SonarCloud for static code analysis
  - Jacoco for code coverage
  - Docker Build + Push to ACR
- **Technologies**:
  - Java (Spring Boot) – Backend
  - Node.js (React) – Frontend
- **Output**: Docker images tagged and stored in ACR

### 2. CD Pipeline
- Deploys containers to AKS using Helm charts
- Supports multi-environment rollout
- Tied into **Traffic Manager** for failover routing

---

## 🔐 Security Practices
- Secrets managed in **Azure Key Vault**
- Key Vault access is locked to private access only
- Docker images scanned using ACR Tasks or Snyk (optional)
- Linting, code quality, and unit test enforcement via pipelines

---

## 🔄 Disaster Recovery (DR)
- **Primary Region**: `polandcentral` (Terraform-managed)
- **Secondary Region**: `koreacentral` (Bicep-managed)
- **Traffic Manager** with Priority-based routing:
  - Primary AKS: Online
  - Secondary AKS: Standby (used in failover)

---

## 📁 Directory Structure

```bash
capstone-infra/
├── environments/
│   └── primary/              # Terraform for primary (Poland Central)
├── modules/
│   ├── ACR/
│   ├── AKS/
│   ├── KeyVault/
│   ├── SQLDatabase/
│   ├── TrafficManager/
│   ├── VirtualNetwork/
│   └── terraform-backend/
├── bicep/
│   └── secondary/            # Bicep for secondary (Korea Central)
│       ├── aks-secondary.bicep
│       └── vnet-secondary.bicep
└── README.md
