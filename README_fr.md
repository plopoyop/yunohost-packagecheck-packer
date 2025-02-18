# Packer Debian 12 pour Yunohost Package Check

Ce projet est un template [Packer](https://www.packer.io/) permettant de construire une image Debian 12 préconfigurée pour être utilisée avec le [package_check](https://github.com/YunoHost/package_check) de [YunoHost](https://yunohost.org/).

## 📦 Fonctionnalités
- Basé sur **Debian 12**
- Configuration des identifiants SSH :
  - **Utilisateur** : `yunohost`
  - **Mot de passe** : `yunohost`
- Installation et configuration minimale pour supporter `package_check`

## 🚀 Prérequis
- [Packer](https://developer.hashicorp.com/packer/downloads) installé sur votre machine
- **QEMU**
- [Task](https://taskfile.dev/) installé pour l'automatisation des tâches

## 🛠️ Utilisation
### 1️⃣ Cloner le dépôt
```sh
git clone https://github.com/plopoyop/yunohost-packagecheck-packer.git
cd yunohost-packagecheck-packer
```

### 2️⃣ Utiliser Taskfile
Ce projet inclut un fichier `Taskfile.yml` pour simplifier l'exécution des commandes courantes :

- Lister toutes les tâches disponibles :
  ```sh
  task
  ```
- Initialiser les plugins Packer :
  ```sh
  task init
  ```
- Nettoyer les fichiers de build précédents :
  ```sh
  task clean
  ```
- Construire l'image :
  ```sh
  task build
  ```

L'image générée sera disponible dans le dossier `output/yunohost-package-check`.

### 3️⃣ Construire l'image manuellement
Si vous ne souhaitez pas utiliser `Taskfile`, exécutez directement :
```sh
packer build .
```

### 4️⃣ Utiliser l'image
Une fois la construction terminée, l’image est prête à être utilisée avec `package_check` de Yunohost.

## 📜 Licence
Ce projet est sous licence **MIT**. Voir le fichier `LICENSE` pour plus d’informations.

## 🤝 Contribution
Les contributions sont les bienvenues ! N’hésitez pas à ouvrir une issue ou une pull request.

---

💡 **Liens utiles** :
- [YunoHost package_check](https://yunohost.org/packaging_apps)
- [Documentation Packer](https://developer.hashicorp.com/packer/docs)
- [Taskfile.dev Documentation](https://taskfile.dev/)
