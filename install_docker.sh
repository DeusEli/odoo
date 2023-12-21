#!/bin/bash



# Actualizar e instalar paquetes necesarios
sudo apt update
sudo apt install -y ca-certificates curl gnupg

# Crear directorio para las claves GPG si no existe
sudo install -m 0755 -d /etc/apt/keyrings

# Descargar el archivo GPG de Docker solo si no existe
GPG_FILE="/etc/apt/keyrings/docker.gpg"
if [ ! -f "$GPG_FILE" ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o "$GPG_FILE"
    sudo chmod a+r "$GPG_FILE"
else
    echo "El archivo $GPG_FILE ya existe. Saltando la descarga."
fi

# Agregar el repositorio de Docker al archivo sources.list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualizar e instalar Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verificar la instalación exitosa
if [ $? -eq 0 ]; then
  echo "Docker se ha instalado correctamente."
else
  echo "Hubo un problema durante la instalación de Docker. Por favor, verifica y corrige los errores."
fi
