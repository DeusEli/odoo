#!/bin/bash

# Crear variable de entorno para utilzar en el docker-compose.yml
export CUSTOMER=$1
export ODOO_VERSION=$2
export PORT=$3
export NGINX_SERVER_NAME=$4

# Levantar los contenedores
if docker compose up -d; then
    echo "Contenedores levantados exitosamente"
else
    echo "Error al levantar los contenedores. Detalles del error: $?"
    exit 1  # Termina el script con un código de salida no exitoso
fi

# Cambiar los permisos de la carpeta /var/lib/odoo
if exec_result=$(docker exec -u root odoo16 chown -R odoo:odoo /var/lib/odoo 2>&1); then
    echo "Cambio de permisos exitoso"
else
    echo "Error al cambiar los permisos. Detalles del error: $exec_result"
fi
