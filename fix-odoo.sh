#!/bin/bash

echo "🔧 Fixing Odoo App Deployment..."

# Delete existing deployment if it exists
echo "Cleaning up existing deployment..."
kubectl delete deployment odoo postgres -n odoo-dev --ignore-not-found=true
kubectl delete service odoo postgres -n odoo-dev --ignore-not-found=true

# Wait for cleanup
sleep 10

# Sync ArgoCD application
echo "Syncing ArgoCD application..."
argocd app sync odoo-dev --force

# Wait for deployment
echo "Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app=postgres -n odoo-dev --timeout=120s
kubectl wait --for=condition=ready pod -l app=odoo -n odoo-dev --timeout=120s

# Check status
echo "📊 Deployment Status:"
kubectl get pods -n odoo-dev
kubectl get services -n odoo-dev

echo "🔍 Checking logs if pods are not ready..."
kubectl logs -l app=postgres -n odoo-dev --tail=20
kubectl logs -l app=odoo -n odoo-dev --tail=20

echo "✅ Port forward command:"
echo "kubectl port-forward svc/odoo -n odoo-dev 8069:8069"