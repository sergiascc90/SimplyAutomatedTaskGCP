#!/bin/bash

#Menú
while :
do
    clear
    echo '*********** Menú operaciones GCP ***********'
    echo '1 - Realizar instantánea'
    echo '2 - Realizar imagen de disco'
    echo '3 - Realizar imagen de maquina'
    echo '4 - Crear disco desde instantánea'
    echo '5 - Crear instancia de Compute Engine'
    echo 's - Salir'
    echo ''
    echo ''
    echo -n 'Seleccionar opción: ' #Escoger una opción del menú
    read option
    echo ''
    clear

    case $option in
    
    #Realizar instantánea
    1) echo '*********** Realizar instantánea ***********'
    while :
        do
        echo 'Información adicional: '
        echo '1 - ¿Instantánea de SO Linux o Windows Server anterior a 2016?'
        echo '2 - ¿Instantánea de SO Windows Server 2016 o posterior?'
        echo 's - Volver al menú principal'
        echo -n 'Selecciona una opción: '
        read opt2
        echo ''

        clear

        case $opt2 in
        #Instantánea tradicional
        1) echo 'Se realizará una instantánea normal. Por favor, responda a las siguientes preguntas: '
            echo  -n 'Introduce el proyecto que estas usando: '
            read PROJECT_ID
            echo ''

            echo 'Multi-region hint: eu, us, asia'
            echo -n 'Introduce la región o multi-región: '
            read REGION
            echo ''

            echo -n 'Introduce una zona válida: '
            read ZONE
            echo ''

            echo -n 'Introduce el nombre para la instantánea: '
            read SNAP_NAME
            echo ''

            echo -n 'Introduce el nombre del disco: '
            read DISK_NAME
            gcloud compute snapshots create $SNAP_NAME --project=$PROJECT_ID --source-disk=$DISK_NAME --source-disk-zone=$ZONE --storage-location=$REGION
            ;;
        
        #Instantánea con VSS habilitado (SO Windows)    
        2) echo 'Se realizará una instantánea con VSS habilitado. Por favor, responda a las siguientes preguntas:'
            echo  -n 'Introduce el proyecto que estas usando: '
            read PROJECT_ID
            echo ''
            
            echo 'Multi-region hint: eu, us, asia'
            echo -n 'Introduce la región o multi-región: '
            read REGION
            echo ''

            echo -n 'Introduce una zona válida: '
            read ZONE
            echo ''

            echo -n 'Introduce el nombre para la instantánea: '
            read SNAP_NAME
            echo ''

            echo -n 'Introduce el nombre del disco: '
            read DISK_NAME
            echo ''

            gcloud compute snapshots create $SNAP_NAME --project=$PROJECT_ID --source-disk=$DISK_NAME --source-disk-zone=$ZONE --guest-flush --storage-location=$REGION
            ;;
        s) break
        esac
        done
    ;;

    #Crear imagen de máquina
    3) echo '*********** Crear imagen de máquina ***********'
        
    ;;

    #Crear disco desde una instantánea
    4) echo '*********** Crear disco desde instantánea ***********'
    echo  -n 'Introduce el proyecto que estas usando: '
    read PROJECT_ID
    echo ''

    echo -n 'Introduce una zona válida: '
    read ZONE
    echo ''
    
    echo -n 'Introduce el nombre de la instantánea: '
    read SNAP_NAME
    echo ''

    echo -n 'Introduce el nombre del disco: '
    read DISK_NAME
    echo ''

    echo 'Hint: pd-balanced, pd-extreme, pd-ssd, pd-standard'
    echo -n 'Introduce el tipo de disco: '
    read DISK_TYPE
    echo ''

    echo -n 'Introduce el tamaño del disco (en GB): '
    read DISK_SIZE
    echo ''

    gcloud compute disks create $DISK_NAME --project=$PROJECT_ID --type=$DISK_TYPE --size=$DISK_SIZE --zone=$ZONE --source-snapshot=$SNAP_NAME
    ;;

    #Creación de instancias de Compute Engine
    5) echo '*********** Crear instancia de Compute Engine ***********'
    while :
        do
        echo '¿Qué deseas hacer?'
        echo '1 - Crear una instancia desde un disco'
        echo '2 - Crear una instancia nueva'
        echo 's - Volver al menú principal'
        echo -n 'Selecciona una opción: '
        read opt3

        clear

        case $opt3 in
            1) echo 'Crear instancia desde un disco'
            echo  -n 'Introduce el proyecto que estas usando: '
            read PROJECT_ID  
            echo ''

            echo -n 'Introduce una región válida: '
            read REGION
            echo ''

            echo -n 'Introduce una zona válida: '
            read ZONE
            echo ''

            echo -n 'Introduce el nombre del disco: '
            read DISK_NAME
            echo ''
            
            echo -n 'Introduce el nombre de la instancia: '
            read INSTANCE_NAME
            echo ''

            echo 'Hint: utiliza el siguiente comando para ver los tipos de máquina disponibles en la región/zona:'
            echo "gcloud compute machine-types list --filter=\"zone:( $ZONE )\""
            echo -n 'Introduce el tipo de máquina: '
            read MACHINE_TYPE
            echo ''

            echo -n 'Introduce el nombre de la red subred: '
            read SUBRED
            echo ''

            echo -n 'Introduce la dirección IP estática de la máquina: '
            read IP_ADDRESS
            echo ''

            gcloud compute instances create $INSTANCE_NAME --zone=$ZONE --subnet=projects/$PROJECT_ID/regions/$REGION/subnetworks/$SUBRED --private-network-ip=$IP_ADDRESS --no-address --machine-type=$MACHINE_TYPE --disk=name=$DISK_NAME,device-name=$DISK_NAME,mode=rw,boot=yes,auto-delete=no --project=$PROJECT_ID
            ;;
            
            s) break
            ;;
        esac
        done
    ;;
    s) exit 0;;
    esac
done