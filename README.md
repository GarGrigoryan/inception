*This project has been created as part of the 42 curriculum by mmosoyan.*

# Inception

## Description

**Inception** is a system administration project focused on containerization using Docker and Docker Compose. The objective is to build a small multi-service infrastructure from scratch, where each service runs inside its own container and communicates through a Docker network.

The infrastructure includes:
- NGINX with TLS encryption
- WordPress running with PHP-FPM
- MariaDB database
- Static Site (Bonus): A lightweight website serving static content

All containers are built using custom Dockerfiles and follow strict isolation, networking, and persistence rules defined by the 42 subject.

Docker is used to ensure reproducibility, portability, and environment consistency across different systems.

---

## Project Architecture

The infrastructure consists of three services:

### NGINX
- Acts as a reverse proxy
- Serves HTTPS traffic on port 443
- Handles TLS encryption
- Connects to WordPress container

### WordPress
- Runs PHP-FPM
- Connects to MariaDB database
- Stores website files in a persistent volume

### MariaDB
- Stores WordPress database
- Uses persistent storage
- Receives credentials via Docker secrets

### Static Site (Bonus)

- A dedicated container serving a static website (HTML/CSS/JS).
- Decoupled from the database for high performance and reliability.
- Accessible via a specific route (e.g., login.42.fr/static/).

All services:
- Run in separate containers
- Communicate through a Docker bridge network
- Use persistent storage via Docker named volumes
- Are configured through environment variables and secrets

---

## Instructions

### Prerequisites
- Docker Engine
- Docker Compose
- GNU Make
- Linux environment

### 1) Host Setup
Add the project domain to `/etc/hosts`:
127.0.0.1 login.42.fr

### 2) Secrets
Create the `secrets/` directory with files:
db_root_password.txt
db_user_password.txt
wp_admin_password.txt
wp_user_password.txt

Each file should contain only the password.

### 3) Environment Variables
Create `srcs/.env`:

DOMAIN_NAME=login.42.fr
SQL_DATABASE=<database_name>
SQL_USER=<database_user>

WP_TITLE=<title>
WP_ADMIN_USER=<admin_username>
WP_ADMIN_EMAIL=<admin_email>

WP_USER=<wordpress_user>
WP_EMAIL=<wordpress_user_email>


### 4) Build & Start
```bash
make
```
Starts all containers in detached mode, creates volumes, builds images, and sets up networking.

### 5) Access
Open your browser and type the full URL in the address bar:
https://login.42.fr

### 6) Container Management
```bash
make stop   # Stop containers
make start  # Start stopped containers
make down   # Stop and remove containers
```

### 7) Full Cleanup
```bash
make fclean  # Remove containers, images, and volumes
make re      # Rebuild everything from scratch
```

---

## Resources

### Documentation
- Docker Documentation - https://docs.docker.com/
- Docker Compose Documentation - https://docs.docker.com/compose/
- NGINX Documentation - https://nginx.org/en/docs/
- WordPress Documentation - https://wordpress.org/documentation/
- MariaDB Documentation - https://mariadb.org/documentation/

- Docker 101 - https://youtu.be/rIrNIzy6U_g?si=zvJYxAE7TOrorkdk
- Docker tutorial - https://youtu.be/q5S14cfOWfE?si=wAapchLJeg3Zbw4x
- Dockerfile creation tutorial - https://youtu.be/1ymi24PeF3M?si=iv1YOt-mrURoclJ-
- Explaining Docker Compose - https://youtu.be/iOGEBj7Ozak?si=kMx-ztF1RtVdTHkl

---

## AI Usage
AI tools were used only for guidance and documentation purposes, such as:
Understanding Docker concepts and container orchestration,
Structuring the README and improving clarity,
Proofreading explanations and instructions.

---

## Project Description

### Virtual Machines vs Docker
A **virtual machine** emulates an entire computer system. It includes its own operating system, kernel, libraries, and applications. Because each VM runs a full OS, it consumes more memory and storage and takes longer to start. The benefit is very strong isolation and the ability to run different operating systems on the same physical machine.

A **Docker container** does not include a full operating system. Instead, it shares the host system’s kernel and only packages the application with its dependencies. This makes containers lightweight, fast to start, and efficient in resource usage. Containers are mainly used to package and deploy applications consistently across environments.

### Secrets vs Environment Variables
**Environment variables** are key-value pairs passed into a container to configure how an application runs. They are simple and commonly used for things like ports, environment names, or feature flags. However, they are stored in plain text and can be visible through logs, configuration files, or inspection commands, so they are not secure for sensitive information.

Docker **secrets** are designed specifically to store sensitive data such as passwords, API keys, and certificates. They are managed securely by Docker, encrypted, and only exposed to containers that are explicitly allowed to access them. Secrets are not stored in plain text inside the container environment.

### Docker Network vs Host Network
By default, Docker uses a **bridge network** where each container runs in an isolated network environment. The container gets its own internal IP address, and ports must be explicitly mapped to the host to allow external access. This setup improves security and keeps containers separated from the host system.

With host **networking**, the container shares the host machine’s network directly. It does not get a separate IP address and does not require port mapping. This can provide better network performance but reduces isolation and increases security risk because the container behaves like a normal process running on the host machine.

### Docker Volumes vs Bind Mounts
Both Docker volumes and bind mounts are used to persist data outside a container so it is not lost when the container is removed.

A **Docker volume** is managed entirely by Docker. Docker decides When and where the data is stored on the host system. Volumes are portable, easier to back up, and generally preferred for production environments, especially for databases or long-term application data.

A **bind mount** directly connects a specific folder from the host machine to a folder inside the container. This gives you full control over the files from your host system. Bind mounts are commonly used in development because you can edit files on your computer and see changes immediately inside the container. However, they are less portable because they depend on a specific host path.

### Static Site vs Dynamic Site (Bonus)

**Dynamic (WordPress):** Generates content on-the-fly using PHP and MariaDB. It is interactive but requires more resources.

**Static Site:** Serves pre-rendered HTML/CSS. It is incredibly fast, secure, and stays online even if the database service fails.
