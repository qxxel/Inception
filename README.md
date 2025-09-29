# Inception
![42 Project](https://img.shields.io/badge/42-Project-black)  
![Language](https://img.shields.io/badge/Docker-0E7FC0?logo=Docker)

---

## 📌 Summary
- [About](#about)
- [Features](#features)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Directories structure](#directories-structure)
- [Ressources](#ressources)
- [Author](#author)

---

<a id="about"></a>
## 📖 About

**Inception** is a project of 42 school.  
The goal is to build a complete web infrastructure using **Docker** and **Docker Compose**, with multiple containerized services working together. This project demonstrates mastery of containerization, networking, SSL configuration, and DevOps best practices.  

The infrastructure consists of:
- **NGINX** as a reverse proxy with TLS/SSL encryption
- **WordPress** with PHP-FPM for content management
- **MariaDB** as the database backend

---

<a id="features"></a>
## ✨ Features

✅ Multi-container architecture with Docker Compose  
✅ NGINX reverse proxy with HTTPS/TLS (self-signed certificates)  
✅ WordPress installation automated via WP-CLI  
✅ MariaDB database with secure configuration  
✅ Isolated Docker network for inter-service communication  
✅ Persistent volumes for database and WordPress data  
✅ Environment variables for secure credential management  
✅ Automated deployment with Makefile  
✅ Custom domain support (agerbaud.42.fr)

---

<a id="installation"></a>
## ⚙️ Installation

**1. Clone the repository**

```bash
git clone git@github.com:qxxel/Inception.git
```

**2. Access the directory**

```bash
cd Inception
```

---

<a id="utilisation"></a>
## 🕹️ Utilisation

**1. Create directories for volumes**

```bash
mkdir -p /home/$USER/data/mariadb;
mkdir -p /home/$USER/data/wordpress
```

**2. Compile to launch the project**

```bash
make
```

This command will call the Makefile, that launch the command `docker compose`. After the build of images, you can access https://localhost:443 on your browser.  
⚠️ You need to be admin on your device, if you're not try in a VM.

---

<a id="directories-structure"></a>
## 📂 Directories structure

```plaintext
📂 Inception
 ┣ 📂 srcs					→ sources files
 ┃  ┣ 📂 requirements		→ requirements of the project
 ┃  ┃  ┣ 📂 requirements	→ files for mariadb image
 ┃  ┃  ┣ 📂 nginx			→ files for nginx image
 ┃  ┃  ┣ 📂 wordpress		→ files for wordpress image
 ┃  ┣ .env
 ┃  ┗ docker-compose.yml
 ┣ .gitignore
 ┣ Makefile
 ┗ README.md
```

---

<a id="ressources"></a>
## 🔗 Ressources

* [42](42.fr)

---

<a id="author"></a>
## 👤 Author

* Axel – [GitHub](https://gitub.com/qxxel)
* 42 student - login: *agerbaud*