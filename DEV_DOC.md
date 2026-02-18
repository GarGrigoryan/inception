*This documentation is intended for developers looking to build, debug, or modify the Inception infrastructure.*

# Inception: Developer Documentation

## Environment Setup
Before building the project, ensure your development environment meets these requirements:

### 1) Prerequisites:
Docker, Docker Compose, and GNU Make must be installed.

### 2) Domain Mapping:
Your local machine must recognize the project domain. Edit /etc/hosts:
127.0.0.1  login.42.fr

### 3) Configuration Files:
- Ensure srcs/.env is created with the required variables (SQL_DATABASE, WP_TITLE, etc.).
- Ensure the srcs/secrets/ folder contains the .txt files for all sensitive passwords.

## Build and Launch
The project uses custom-built images based on Alpine or Debian.

### 1) Initial Build: Run make to build the images and start the containers.

### 2) Forced Rebuild: If you modify a Dockerfile or a configuration script, use:

```Bash
make re
```
This will trigger a full cleanup and rebuild all images from scratch.

## Developer Commands
Use these commands to interact with the running infrastructure:

### Container Shell:
Access a container's internal terminal for debugging:

```Bash
docker exec -it <container_name> sh
```
### View Logs:
Track real-time output from the services:

```Bash
docker-compose -f srcs/docker-compose.yml logs -f
```

### Inspect Networks:
Verify container communication:

```Bash
docker network ls
docker network inspect inception
```
## Data Persistence & Storage
The project uses Docker Volumes to ensure data survives container restarts and removals. These volumes are mapped to the host's file system:

### 1) Database Data:
Stored in a named volume mapped to /home/login/data/mariadb.

### 2) WordPress Files:
Stored in a named volume mapped to /home/login/data/wordpress.

### 3) Persistence Rules:
make down removes containers but keeps the data in the volumes.
make fclean removes containers, images, and deletes the volumes/data from the host system.
