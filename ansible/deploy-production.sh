#!/bin/bash
# Script de déploiement PRODUCTION
# Utilise l'inventory et les variables de production

set -e

echo "🚀 Déploiement en PRODUCTION"
echo "=============================="
echo ""

cd "$(dirname "$0")"

# Vérifier que nous sommes sur la bonne branche
BRANCH=$(git branch --show-current)
if [ "$BRANCH" != "main" ]; then
    echo "⚠️  ATTENTION: Vous n'êtes pas sur la branche 'main' (branche actuelle: $BRANCH)"
    read -p "Continuer quand même? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo "📦 Installation des dépendances Ansible..."
ansible-galaxy collection install -r requirements.yml

echo ""
echo "🔍 Test de connectivité..."
ansible all -i inventories/production/hosts.yml -m ping

echo ""
echo "📋 Lancement du playbook..."
ansible-playbook -i inventories/production/hosts.yml site.yml -K

echo ""
echo "✅ Déploiement PRODUCTION terminé!"
echo ""
echo "🌐 Accès: https://192.168.1.201"
echo "🔒 Note: Le certificat SSL est auto-signé"
