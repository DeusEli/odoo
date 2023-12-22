#!/bin/bash

# Crear variable de entorno para utilzar en la configuración de NginX
export NGINX_SERVER_NAME=$1

# Levantar los contenedores
docker compose up -d

# Cambiar los permisos de la carpeta /var/lib/odoo
docker exec -ti -u root odoo16 chown -R odoo:odoo /var/lib/odoo
