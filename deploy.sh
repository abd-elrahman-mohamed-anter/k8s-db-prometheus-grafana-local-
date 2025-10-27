#!/bin/bash
# Deployment script for Spring PetClinic stack on Minikube
# ---------------------------------------------------------

echo "🚀 Starting deployment on Minikube..."

# Step 1: Apply all YAML files in correct order
kubectl apply -f mysql.yml
kubectl apply -f petclinic.yml
kubectl apply -f svc.yml
kubectl apply -f prometheus.yml
kubectl apply -f grafana.yml
kubectl apply -f ingress.yml

# Step 2: Wait for pods to be ready
echo "⏳ Waiting for pods to start..."
kubectl wait --for=condition=Ready pod --all --timeout=180s

# Step 3: Show status
echo "✅ Deployment complete!"
kubectl get pods
kubectl get svc
kubectl get ingress

# Step 4: Show access info
echo -e "\n🌐 Access URLs:"
echo "PetClinic:    http://petclinic.local"
echo "Prometheus:   http://prometheus.local"
echo "Grafana:      http://grafana.local"
