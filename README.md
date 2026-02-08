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

---

### Host Configuration

Add the project domain to your hosts file:

```bash
sudo nano /etc/hosts
