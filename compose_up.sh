#!/bin/bash

# Crear variable de entorno para utilzar en la configuración de NginX
export NGINX_SERVER_NAME=$1

# Levantar los contenedores
docker compose up -d

# Cambiar los permisos de la carpeta /var/lib/odoo
if docker exec -ti -u root odoo16 chown -R odoo:odoo /var/lib/odoo; then
    echo "Cambio de permisos exitoso"
else
    echo "Error al cambiar los permisos"
fi
