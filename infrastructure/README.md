# Infrastructure as Code - EKS GitOps Platform

Professional-grade Terraform infrastructure for EKS cluster with GitOps capabilities.

##  Architecture

```
├── environments/          # Environment-specific configurations
│   ├── dev/              # Development environment
│   ├── staging/          # Staging environment
│   └── prod/             # Production environment
├── modules/              # Reusable Terraform modules
│   ├── vpc/              # VPC networking module
│   ├── eks/              # EKS cluster module
│   ├── iam/              # IAM roles module
│   └── s3-backend/       # S3 backend module
└── shared/               # Shared resources and data sources
```

##  Quick Start

### 1. Deploy Development Environment

```bash
cd environments/dev
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

### 2. Configure kubectl

```bash
aws eks update-kubeconfig --region us-west-2 --name argocd-gitops-dev-cluster
```

### 3. Verify Deployment

```bash
kubectl get nodes
kubectl get pods -A
```

##  Features

 **Modular Design** - Reusable, maintainable modules  
 **Multi-Environment** - Dev, Staging, Production ready  
 **Security Best Practices** - IAM roles, security groups  
 **High Availability** - Multi-AZ deployment  
 **Monitoring Ready** - CloudWatch logging enabled  
 **GitOps Ready** - ArgoCD compatible configuration  

##  Customization

Edit `terraform.tfvars` in each environment to customize:

- **VPC CIDR blocks**
- **Instance types and sizes**
- **Kubernetes version**
- **Node group scaling**
- **Logging configuration**

##  Resource Tagging

All resources are automatically tagged with:
- Project name
- Environment
- Owner
- Managed by Terraform
- Creation timestamp

##  Outputs

Each environment provides:
- Cluster endpoint and ARN
- VPC and subnet IDs
- S3 bucket for state storage
- kubectl configuration command

##  Security

- Private subnets for worker nodes
- Security groups with minimal access
- IAM roles with least privilege
- Encrypted S3 state storage
- VPC flow logs (optional)

---
**Enterprise-grade infrastructure for modern DevOps teams**