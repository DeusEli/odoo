#!/bin/bash

# Crear variable de entorno para utilzar en la configuración de NginX
export NGINX_SERVER_NAME=$1

# Levantar los contenedores
docker compose up -d

# Esperar a que los contenedores estén en funcionamiento
echo "Esperando a que los contenedores estén en funcionamiento..."
while [ "$(docker inspect -f '{{.State.Status}}' odoo16 2>/dev/null)" != "running" ]; do
    sleep 1
done
echo "Los contenedores están en funcionamiento."

# Cambiar los permisos de la carpeta /var/lib/odoo
if docker exec -ti -u root odoo16 chown -R odoo:odoo /var/lib/odoo; then
    echo "Cambio de permisos exitoso"
else
    echo "Error al cambiar los permisos"
fi
