#!/bin/bash

set -e  # Arrête le script en cas d'erreur

echo "============================================"
echo "🚀 Déploiement Infrastructure Complète"
echo "============================================"
echo ""

# Étape 1: Terraform
echo "📦 Étape 1/2: Provisionnement avec Terraform"
echo "--------------------------------------------"
cd terraform

echo "  → Initialisation Terraform..."
terraform init

echo "  → Application de la configuration..."
terraform apply -auto-approve

cd ..
echo ""

# Étape 2: Ansible
echo "⚙️  Étape 2/2: Configuration avec Ansible"
echo "--------------------------------------------"
cd ansible

echo "  → Attente du démarrage des VMs (45s)..."
sleep 45

echo "  → Test de connectivité..."
ansible all -i inventory.yml -m ping

echo "  → Exécution du playbook..."
ansible-playbook -i inventory.yml site.yml

cd ..
echo ""

echo "============================================"
echo "✅ Déploiement terminé avec succès !"
echo "============================================"
echo ""
echo "🌐 Accès web: http://192.168.1.201"
echo "🗄️  Serveur DB: 192.168.1.202"
echo ""
