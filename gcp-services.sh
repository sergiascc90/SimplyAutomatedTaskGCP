!/bin/bash

PROJECT_ID=() #Rellenar con el Project ID entre comillas simples
#Para obtenerlos, ejecutar el siguiente comando gcloud projects list --filter="gcp1"

for project in "${PROJECT_ID[@]}"
do
    gcloud config set project $project #Configurar un proyecto determinado
    echo 'Proyecto '$project' configurado'
    echo ''
    
    echo 'Habilitar servicios de Compute Engine'
    gcloud services enable compute.googleapis.com #Habilitar los servicios de la API de Compute Engine
    echo ''

    echo 'Borrando reglas de firewall del proyecto' $project
    gcloud compute firewall-rules delete default-allow-ssh default-allow-rdp default-allow-internal default-allow-icmp --quiet #Borrar reglas de firewall que vienen con la VPC default
    echo ''

    echo 'Borrando la red VPC del proyecto' $project
    gcloud compute networks delete default --quiet #Eliminar la red VPC del proyecto configurado en el primer comando
    
done