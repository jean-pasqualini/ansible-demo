# 🚀 Déploiement Symfony avec Ansible

Ce projet utilise **Ansible** pour automatiser l'installation d'un environnement serveur et le déploiement d'applications Symfony.
Il est divisé en deux grandes étapes : le **provisioning** (environnement serveur) et le **déploiement** (code de l'application Symfony).

---

## 🧰 Prérequis

* Python 3
* `make`
* Accès SSH aux serveurs (définis dans `ansible/hosts.ini`)
* Accès à la clé de chiffrement Ansible Vault (`.vault_pass.txt`)

---

## 🛠️ Installation (en local)

```bash
make install-python
source ~/.venvs/ansible/bin/activate
make install-ansible VENV=1
make get-ansible-vendor
```

---

## 🔐 Configuration

1. Crée un fichier `.vault_pass.txt` à la racine du projet contenant le mot de passe de **Ansible Vault**.

2. Modifie le fichier `ansible/hosts.ini` en y renseignant les IPs ou noms DNS des serveurs cibles :

```ini
[app]
192.0.2.10 ansible_user=ubuntu
```

---

## ⚙️ Provisioning (environnement serveur)

> Cette étape installe les composants nécessaires au fonctionnement de Symfony : **NGINX**, **PHP**, **MySQL**, etc.

### Commande :

```bash
make provisioning APP_NAME=(app-knp|app-symfony)
```

---

## 🚀 Déploiement de l’application Symfony

> Cette étape déploie le code source, installe les dépendances, applique les migrations, et vide le cache Symfony.

### Commande :

```bash
make deploy SYMFONY_ENV=(prod|dev|test) APP_NAME=(app-knp|app-symfony)
```

---

## ✅ Résumé des commandes

| Étape                   | Commande                                            |
| ----------------------- | --------------------------------------------------- |
| Installer Python & venv | `make install-python`                               |
| Activer l’environnement | `source ~/.venvs/ansible/bin/activate`              |
| Installer Ansible       | `make install-ansible VENV=1`                       |
| Installer les rôles     | `make get-ansible-vendor`                           |
| Provisioning            | `make provisioning APP_NAME=app-symfony`            |
| Déploiement             | `make deploy SYMFONY_ENV=prod APP_NAME=app-symfony` |
