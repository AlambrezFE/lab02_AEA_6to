#!/bin/bash

# Ejecutar el contenedor de la API
docker run -d --name gifapi -p 5000:80 gifapi

# Obtener la IP del contenedor de la API
container_id=$(docker ps -qf "name=gifapi")
container_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container_id)

# Exportar la IP como una variable de entorno
export API_URL="http://$container_ip:80/api/gifs"

# Ejecutar el contenedor del frontend con la variable de entorno
docker run -d -p 5001:80 -e API_URL=$API_URL giffrontend

