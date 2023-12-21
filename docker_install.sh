#!/bin/bash

# Actualizar e instalar paquetes necesarios
sudo apt update
sudo apt install -y ca-certificates curl gnupg

# Crear directorio para las claves GPG
sudo install -m 0755 -d /etc/apt/keyrings

# Descargar el archivo GPG de Docker y colocarlo en el directorio creado
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Agregar el repositorio de Docker al archivo sources.list
yes | echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualizar e instalar Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verificar la instalación exitosa
if [ $? -eq 0 ]; then
  echo "Docker se ha instalado correctamente."
else
  echo "Hubo un problema durante la instalación de Docker. Por favor, verifica y corrige los errores."
fi
