#!/bin/bash

# Descargar los archivos desde el repositorio
git clone https://github.com/AlambrezFE/lab02_AEA_6to.git
cd lab02_AEA_6to

# Construir la API en C#
docker build -t gifapi -f Dockerfile.api .

# Pausar la ejecución por 5 segundos
sleep 10

# Construir el frontend en PHP
docker build -t giffrontend -f Dockerfile.frontend .

# Pausar la ejecución por 5 segundos
sleep 10

# Ejecutar los contenedores
docker run -d --name gifapi -p 5000:80 gifapi

# Pausar la ejecución por 10 segundos para asegurarse de que el contenedor de la API esté completamente iniciado
sleep 10

# Obtener la IP del contenedor de la API
container_id=$(docker ps -qf "name=gifapi")
container_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container_id)

# Exportar la IP como una variable de entorno
export API_URL="http://$container_ip:80/api/"

# Ejecutar el contenedor del frontend con la variable de entorno
docker run -d -p 5001:80 -e API_URL=$API_URL giffrontend
