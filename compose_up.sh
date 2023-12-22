#!/bin/bash

# Crear variable de entorno para utilzar en la configuración de NginX
export NGINX_SERVER_NAME=$1

# Levantar los contenedores
docker compose up -d

# Cambiar los permisos de la carpeta /var/lib/odoo
if exec_result=$(docker exec -ti -u root odoo16 chown -R odoo:odoo /var/lib/odoo 2>&1); then
    echo "Cambio de permisos exitoso"
else
    echo "Error al cambiar los permisos. Detalles del error: $exec_result"
    sleep 5  # Espera 5 segundos antes de volver a intentar
    
    # Segundo intento
    if exec_result=$(docker exec -ti -u root odoo16 chown -R odoo:odoo /var/lib/odoo 2>&1); then
        echo "Cambio de permisos exitoso"
    else
        echo "Error al cambiar los permisos. Detalles del error: $exec_result"
    fi
fi
