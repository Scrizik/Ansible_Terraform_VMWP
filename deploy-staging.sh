#!/bin/bash
# Script de déploiement complet STAGING (Terraform + Ansible)

set -e

echo "🧪 Déploiement Infrastructure STAGING"
echo "======================================"
echo ""

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Étape 1: Terraform
echo -e "${BLUE}📦 Étape 1/3: Provisionnement Terraform${NC}"
echo "----------------------------------------"
cd terraform

echo "Initialisation Terraform..."
terraform init

echo ""
echo "Création des VMs de staging..."
terraform apply -var-file="staging.tfvars" -auto-approve

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
ansible all -i inventories/staging/hosts.yml -m ping

echo ""
echo "Configuration des serveurs..."
ansible-playbook -i inventories/staging/hosts.yml site.yml

cd ..

# Étape 3: Vérification
echo ""
echo -e "${BLUE}✅ Étape 3/3: Vérification${NC}"
echo "---------------------------"
echo ""
echo -e "${GREEN}✅ Déploiement STAGING terminé avec succès!${NC}"
echo ""
echo "📋 Infrastructure déployée:"
echo "  • web-server-staging: 192.168.1.211"
echo "  • db-server-staging: 192.168.1.212"
echo ""
echo "🌐 Accès:"
echo "  • HTTP: http://192.168.1.211"
echo ""
echo -e "${YELLOW}⚠️  Configuration Staging (allégée):${NC}"
echo "  • Firewall UFW: Désactivé"
echo "  • HTTPS: Désactivé"
echo "  • Backup DB: Désactivé"
echo ""
echo "💡 Commandes utiles:"
echo "  • Détruire: cd terraform && terraform destroy -var-file='staging.tfvars'"
echo "  • Tester: curl http://192.168.1.211"
