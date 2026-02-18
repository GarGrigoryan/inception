*This documentation is intended for users and administrators of the Inception stack.*

# Inception: User & Administrator Documentation

## Services Provided
The Inception stack provides a secure, containerized web environment consisting of:

Web Server (NGINX): Serves the website over HTTPS (TLS v1.3) and acts as the entry point for all traffic.

Content Management (WordPress): A fully functional blog/website platform powered by PHP-FPM.

Database (MariaDB): A relational database management system that stores all WordPress posts, users, and settings.

Static Site (Bonus): A fast, lightweight site (e.g., a personal portfolio) served directly without a database dependency.

## Managing the Project
The project is managed using a Makefile to simplify Docker commands.

Start the project:
```bash
 make
 ```

Stop the project (keep data):
```bash
 make stop
```

Stop and remove containers:
```bash
make down
```


## Accessing the Website

### The Web Interface
Once the stack is running, open your web browser and navigate to: https://login.42.fr (Replace login with your specific 42 username).

### The Administration Panel
To manage the website content, access the WordPress dashboard at: https://login.42.fr/wp-admin

### Portfolio/Static Site (Bonus)
Access URL: https://login.42.fr/static

Note: Because the project uses a self-signed SSL certificate, your browser will show a security warning. You must click "Advanced" and "Proceed" to access the site.

## Credentials Management
Credentials are not hardcoded into the images for security reasons. They are managed via:

Secrets: Sensitive passwords (DB Root, DB User, WP Admin) are stored in the srcs/secrets/ directory.

Environment Variables: General configuration like usernames and database names are located in srcs/.env.

To update a password, modify the corresponding .txt file in the secrets folder and rebuild the project.

## Health Check
To verify that all services are running correctly, use the following command:

```Bash
docker ps
```
A healthy stack should show three containers (nginx, wordpress, and mariadb) with a status of "Up".
