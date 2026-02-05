#!/bin/bash
set -e


SQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
SQL_PASSWORD=$(cat /run/secrets/db_user_password)

if [ ! -d "/var/lib/mysql/$SQL_DATABASE" ]; then
    # Initialize MariaDB data directory
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start temporary server to configure DB
    tfile=`mktemp`
    if [ ! -f "$tfile" ]; then
        return 1
    fi

    cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;
CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';
GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

    # Run the temp file
    /usr/sbin/mysqld --user=mysql --bootstrap < $tfile
    rm -f $tfile
fi

# Execute the main daemon in the foreground (PID 1)
exec /usr/sbin/mysqld --user=mysql --console