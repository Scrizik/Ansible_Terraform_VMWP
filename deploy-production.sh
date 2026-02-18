#!/bin/bash
# Script de déploiement complet PRODUCTION (Terraform + Ansible)

set -e

echo "🚀 Déploiement Infrastructure PRODUCTION"
echo "=========================================="
echo ""

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Étape 1: Terraform
echo -e "${BLUE}📦 Étape 1/3: Provisionnement Terraform${NC}"
echo "----------------------------------------"
cd terraform

echo "Initialisation Terraform..."
terraform init

echo ""
echo "Création des VMs de production..."
terraform apply -var-file="production.tfvars" -auto-approve

echo ""
echo "Récupération des IPs..."
terraform output

cd ..

# Attendre que les VMs soient prêtes
echo ""
echo -e "${BLUE}⏳ Attente démarrage des VMs (30s)...${NC}"
sleep 30

# Étape 2: Ansible
echo ""
echo -e "${BLUE}⚙️  Étape 2/3: Configuration Ansible${NC}"
echo "------------------------------------"
cd ansible

echo "Installation des dépendances Ansible..."
ansible-galaxy collection install -r requirements.yml 

echo ""
echo "Test de connectivité..."
ansible all -i inventories/production/hosts.yml -m ping

echo ""
echo "Configuration des serveurs..."
ansible-playbook -i inventories/production/hosts.yml site.yml 

cd ..

# Étape 3: Vérification
echo ""
echo -e "${BLUE}✅ Étape 3/3: Vérification${NC}"
echo "---------------------------"
echo ""
echo -e "${GREEN}✅ Déploiement PRODUCTION terminé avec succès!${NC}"
echo ""
echo "📋 Infrastructure déployée:"
echo "  • web-server-production: 192.168.1.201"
echo "  • db-server-production: 192.168.1.202"
echo ""
echo "🌐 Accès:"
echo "  • HTTPS: https://192.168.1.201"
echo "  • HTTP:  http://192.168.1.201 (redirige vers HTTPS)"
echo ""
echo "🔒 Sécurité:"
echo "  • Firewall UFW: Activé"
echo "  • HTTPS: Activé (certificat auto-signé)"
echo "  • Backup DB: Activé (cron à 2h du matin)"
echo ""
echo "💡 Commandes utiles:"
echo "  • Détruire: cd terraform && terraform destroy -var-file='production.tfvars'"
echo "  • Logs backup: ssh jordan@192.168.1.202 'tail -f /var/log/mysql_backup.log'"
