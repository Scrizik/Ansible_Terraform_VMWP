#!/bin/bash
# Script de déploiement STAGING
# Utilise l'inventory et les variables de staging

set -e

echo "🧪 Déploiement en STAGING"
echo "=========================="
echo ""

cd "$(dirname "$0")"

echo "📦 Installation des dépendances Ansible..."
ansible-galaxy collection install -r requirements.yml

echo ""
echo "🔍 Test de connectivité..."
ansible all -i inventories/staging/hosts.yml -m ping

echo ""
echo "📋 Lancement du playbook..."
ansible-playbook -i inventories/staging/hosts.yml site.yml -K

echo ""
echo "✅ Déploiement STAGING terminé!"
echo ""
echo "🌐 Accès: http://192.168.1.201"
echo "ℹ️  Note: HTTPS désactivé en staging"
