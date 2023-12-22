#!/bin/bash

# Variables
odooVersion=$1
tokenGit=$2

# Detener contenedores
if docker compose down; then
    echo "Contenedores detenidos exitosamente."
else
    echo "Error al detener los contenedores. Por favor, verifica y corrige los errores."
    exit 1
fi

# Clonar módulos enterprise
if git clone --depth 1 --branch "$odooVersion" "https://$tokenGit@github.com/odoo/enterprise" "./16.0/enterprise"; then
    echo "Clonación de módulos enterprise exitosa."
else
    echo "Error durante la clonación de módulos enterprise. Por favor, verifica y corrige los errores."
    exit 1
fi

# Iniciar los contenedores de nuevo
if docker compose up -d; then
    echo "Contenedores iniciados exitosamente."
else
    echo "Error al iniciar los contenedores. Por favor, verifica y corrige los errores."
    exit 1
fi
