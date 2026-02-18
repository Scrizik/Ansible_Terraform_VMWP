# Niveau 3 : Architect - Guide d'utilisation

## 📋 Architecture Multi-Environnements

Ce projet supporte deux environnements distincts sans duplication de code :
- **Production** : Sécurité maximale (HTTPS, Firewall, Backup automatique)
- **Staging** : Configuration allégée pour les tests

## 🚀 Déploiement

### Production
```bash
cd ansible
./deploy-production.sh
```

**Caractéristiques Production :**
- ✅ HTTPS activé (certificat auto-signé)
- ✅ Firewall UFW configuré (ports 22, 80, 443)
- ✅ Backup MariaDB automatique (cron à 2h du matin)
- ✅ Logs séparés par environnement
- ✅ Redirection HTTP → HTTPS

### Staging
```bash
cd ansible
./deploy-staging.sh
```

**Caractéristiques Staging :**
- ❌ HTTPS désactivé (HTTP simple)
- ❌ Firewall désactivé
- ❌ Pas de backup automatique
- ✅ Configuration légère pour tests rapides

## 📁 Structure des environnements

```
ansible/
├── inventories/
│   ├── production/
│   │   ├── hosts.yml                # IPs et hosts production
│   │   └── group_vars/
│   │       └── all.yml              # Variables production
│   └── staging/
│       ├── hosts.yml                # IPs et hosts staging
│       └── group_vars/
│           └── all.yml              # Variables staging
├── roles/
│   ├── common/                      # Utilisateur deploy
│   ├── security/                    # Firewall UFW
│   ├── web/                         # Nginx + HTTPS
│   └── db/                          # MariaDB + Backup
├── site.yml                         # Playbook principal (commun)
├── deploy-production.sh             # Script déploiement prod
└── deploy-staging.sh                # Script déploiement staging
```

## 🔐 Sécurité (Production uniquement)

### Firewall UFW
- Ports autorisés : 22 (SSH), 80 (HTTP), 443 (HTTPS)
- Politique par défaut : DENY incoming, ALLOW outgoing
- Configuration idempotente

### HTTPS
- Certificat SSL auto-signé
- Redirect automatique HTTP → HTTPS
- Headers de sécurité (HSTS, X-Frame-Options, etc.)
- TLS 1.2/1.3 uniquement

## 💾 Backup Base de Données

### Configuration (Production)
- **Fréquence** : Tous les jours à 2h du matin
- **Emplacement** : `/var/backups/mariadb/`
- **Rétention** : 7 jours
- **Format** : SQL compressé (.sql.gz)
- **Logs** : `/var/log/mysql_backup.log`

### Vérifier les backups
```bash
ssh jordan@192.168.1.202
ls -lh /var/backups/mariadb/
tail -f /var/log/mysql_backup.log
```

### Tester le backup manuellement
```bash
ssh jordan@192.168.1.202
sudo /usr/local/bin/backup_mysql.sh
```

## 🔄 Idempotence

Le playbook est **100% idempotent**. Vous pouvez le relancer autant de fois que nécessaire :

```bash
# Première exécution
./deploy-production.sh

# Deuxième exécution immédiate
./deploy-production.sh
# → Aucun changement, toutes les tâches en "ok" (vert)
```

### Preuve d'idempotence
Les logs montrent :
- `changed=0` lors de la 2ème exécution
- Toutes les tâches en état "ok"
- Aucune modification inutile

## 🧪 Tests

### 1. Vérifier la page web

**Production (HTTPS) :**
```bash
curl -k https://192.168.1.201
# ou dans le navigateur : https://192.168.1.201
# (accepter le certificat auto-signé)
```

**Staging (HTTP) :**
```bash
curl http://192.168.1.201
```

### 2. Vérifier le firewall (Production)
```bash
ssh jordan@192.168.1.201
sudo ufw status
```

### 3. Vérifier le cron job (Production)
```bash
ssh jordan@192.168.1.202
sudo crontab -l
```

### 4. Tester la différence Production/Staging
La page web affiche :
- Badge de l'environnement (rouge=production, orange=staging)
- État HTTPS (✅ ou ❌)
- État Firewall (✅ ou ❌)
- État Backup DB (✅ ou ❌)

## 📊 Variables par environnement

| Variable | Production | Staging |
|----------|-----------|---------|
| `environment_name` | production | staging |
| `firewall_enabled` | ✅ true | ❌ false |
| `https_enabled` | ✅ true | ❌ false |
| `db_backup_enabled` | ✅ true | ❌ false |
| `allowed_ports` | [22, 80, 443] | N/A |
| `db_backup_schedule` | "0 2 * * *" | N/A |

## 🎯 Checklist Niveau 3

- ✅ **Gestion d'environnement** : Production & Staging sans duplication
- ✅ **Base de données** : Cron job backup en production
- ✅ **Sécurité** : Firewall UFW + restriction ports
- ✅ **HTTPS** : Certificat SSL avec redirect HTTP→HTTPS
- ✅ **Idempotence** : Playbook relançable sans erreurs

## 🛠️ Commandes utiles

```bash
# Lister les inventories
ansible-inventory -i inventories/production/hosts.yml --list

# Mode dry-run (test)
ansible-playbook -i inventories/production/hosts.yml site.yml -K --check

# Mode verbose
ansible-playbook -i inventories/production/hosts.yml site.yml -K -vv

# Exécuter uniquement certains tags
ansible-playbook -i inventories/production/hosts.yml site.yml -K --tags backup

# Vérifier la syntaxe
ansible-playbook site.yml --syntax-check
```

## 📝 Notes importantes

1. **Certificat SSL** : Auto-signé, navigateur affichera un avertissement
2. **Même infrastructure** : Staging et Production partagent les mêmes VMs (démo)
3. **Mot de passe sudo** : Flag `-K` demande le password (Serveur1234)
4. **Backup initial** : Première sauvegarde à 2h du matin le lendemain
