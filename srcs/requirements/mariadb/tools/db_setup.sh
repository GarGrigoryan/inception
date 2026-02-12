#!/bin/bash
set -e

SQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
SQL_PASSWORD=$(cat /run/secrets/db_user_password)

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    echo "Configuring MariaDB users and database..."

    cat <<EOF > /tmp/init.sql
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    /usr/sbin/mysqld --user=mysql --bootstrap < /tmp/init.sql
    rm -f /tmp/init.sql
fi

echo "Starting MariaDB..."
exec /usr/sbin/mysqld --user=mysql --console
