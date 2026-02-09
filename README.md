*This project has been created as part of the 42 curriculum by mmosoyan.*

# Inception

## Description

**Inception** is a system administration project focused on containerization using Docker and Docker Compose. The objective is to build a small multi-service infrastructure from scratch, where each service runs inside its own container and communicates through a Docker network.

The infrastructure includes:
- NGINX with TLS encryption
- WordPress running with PHP-FPM
- MariaDB database

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

Each file should contain only the password.

### 3) Environment Variables
Create `srcs/.env`:

DOMAIN_NAME=login.42.fr
SQL_DATABASE=<database_name>
SQL_USER=<database_user>

WP_ADMIN_USER=<admin_username>
WP_ADMIN_EMAIL=<admin_email>

WP_USER=<wordpress_user>
WP_PASSWORD=<wordpress_user_password>
WP_EMAIL=<wordpress_user_email>


### 4) Build & Start
```bash
make
```
Starts all containers in detached mode, creates volumes, builds images, and sets up networking.

### 5) Access
Open your browser and type the full URL in the address bar:
https://mmosoyan.42.fr

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

## AI Usage
AI tools were used only for guidance and documentation purposes, such as:
Understanding Docker concepts and container orchestration,
Structuring the README and improving clarity,
Proofreading explanations and instructions.