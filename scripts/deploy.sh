#!/bin/bash

# Mostramos los comandos y paramos si hay error
set -ex

# 1. Cargamos las variables de nuestro archivo .env
source .env

# 2. Creamos la base de datos usando las variables
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# 3. Creamos el usuario y le asignamos la contraseña
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"

# 4. Le damos a ese usuario todos los permisos sobre la nueva base de datos
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"

# 5. Aplicamos los cambios de permisos
mysql -u root -e "FLUSH PRIVILEGES;"

# 6. Importamos las tablas de la base de datos
mysql -u root $DB_NAME < ../db/database.sql