#!/bin/bash

set -e  # Arrête le script en cas d'erreur

echo "============================================"
echo          "Infrastructure Complète"
echo "============================================"
echo ""

# Étape 1: Terraform
echo  "Étape 1/2: Provisionnement avec Terraform"
echo "--------------------------------------------"
cd terraform

echo "  → Initialisation Terraform..."
terraform init

echo "  → Application de la configuration..."
terraform apply -auto-approve

cd ..
echo ""

# Étape 2: Ansible
echo "   Étape 2/2: Configuration avec Ansible"
echo "--------------------------------------------"
cd ansible

echo "  → Attente du démarrage des VMs (30s)..."
sleep 30

echo "  → Test de connectivité..."
ansible all -i inventory.yml -m ping

echo "  → Exécution du playbook..."
ansible-playbook -i inventory.yml site.yml

cd ..
echo ""

echo "============================================"
echo     "Déploiement terminé avec succès !"
echo "============================================"
echo ""

# Récupérer les IPs depuis Terraform
echo "Récupération des adresses IP..."
cd terraform
WEB_IP=$(terraform output -raw web_server_ip)
DB_IP=$(terraform output -raw db_server_ip)
cd ..

echo ""
echo "Accès web: http://$WEB_IP"
echo "Serveur DB: $DB_IP"
echo ""
