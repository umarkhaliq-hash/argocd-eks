#  ArgoCD GitOps Examples

A comprehensive collection of Kubernetes applications for practicing GitOps with ArgoCD. This repository contains multiple applications with different deployment patterns and environments.

##  Applications

### 1.  E-commerce Frontend
Simple nginx-based frontend application for e-commerce platform.

**Path:** `ecommerce-app/helm-chart`
- **Technology:** Nginx Alpine
- **Environments:** Dev (1 replica) → Stage (2 replicas) → Prod (3 replicas)
- **Access:** NodePort 30090

### 2.  Odoo ERP System
Complete ERP system with PostgreSQL database.

**Path:** `odoo-app/helm-chart`
- **Technology:** Odoo 16.0 + PostgreSQL 13
- **Environments:** Dev → Stage → Prod
- **Access:** NodePort 30080

### 3.  Helm WebApp
Basic web application using Helm charts.

**Path:** `helm-webapp`
- **Technology:** Custom web application
- **Environments:** Dev, Prod configurations

### 4.  Kustomize WebApp
Web application using Kustomize for configuration management.

**Path:** `kustom-webapp`
- **Technology:** Kustomize overlays
- **Environments:** Dev, Prod overlays

##  ArgoCD Application Setup

### For E-commerce Frontend:
```yaml
Repository URL: https://github.com/umarkhaliq-hash/argocd.git
Path: ecommerce-app/helm-chart
Values Files: ../environments/dev/values-dev.yaml
Namespace: ecommerce-dev
```

### For Odoo ERP:
```yaml
Repository URL: https://github.com/umarkhaliq-hash/argocd.git
Path: odoo-app/helm-chart
Values Files: ../environments/dev/values-dev.yaml
Namespace: odoo-dev
```

##  Environment Strategy

| Environment | Purpose | Sync Policy | Replicas |
|-------------|---------|-------------|----------|
| **Dev** | Development & Testing | Auto-sync | 1-2 |
| **Stage** | Pre-production Testing | Auto-sync | 2 |
| **Prod** | Production | Manual sync | 3+ |

##  Quick Start

1. **Clone Repository**
   ```bash
   git clone https://github.com/umarkhaliq-hash/argocd.git
   cd argocd
   ```

2. **Setup ArgoCD**
   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```

3. **Access ArgoCD UI**
   ```bash
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   ```

4. **Create Applications**
   - Open ArgoCD UI at `https://localhost:8080`
   - Use the repository configurations above
   - Deploy environments: Dev → Stage → Prod

##  Repository Structure

```
├── ecommerce-app/           # E-commerce frontend
│   ├── helm-chart/         # Helm templates
│   └── environments/       # Environment configs
├── odoo-app/               # Odoo ERP system
│   ├── helm-chart/         # Helm templates
│   └── environments/       # Environment configs
├── helm-webapp/            # Basic Helm app
├── kustom-webapp/          # Kustomize app
└── README.md              # This file
```

##  Technologies Used

- **ArgoCD** - GitOps continuous delivery
- **Helm** - Kubernetes package manager
- **Kustomize** - Configuration management
- **Kubernetes** - Container orchestration
- **Docker** - Containerization

##  Learning Objectives

-  GitOps workflow with ArgoCD
-  Multi-environment deployments
-  Helm chart management
-  Kustomize configurations
-  Application promotion strategies
-  Resource management across environments

##  Contributing

Feel free to add more applications or improve existing configurations!

---
**Happy GitOps!**