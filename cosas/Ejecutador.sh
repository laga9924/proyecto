#!/bin/bash

# Función para ejecutar un playbook de Ansible
run_playbook() {
    playbook=$1
    echo "Ejecutando playbook: $playbook"
    sudo ansible-playbook $playbook
    echo "-------------------------------------"
}

# Menú principal
while true; do
    clear
    echo "***** Menú de Ejecución de Playbooks *****"
    echo "Seleccione el playbook que desea ejecutar:"
    echo "1. Crear archivo"
    echo "2. Borrar archivo"
    echo "3. Apache"
    echo "4. Nginx web.yml"
    echo "5. Crear archivo plus"
    echo "6. Salir"
    read -p "Ingrese su opción: " choice
    case $choice in
        1) 
            read -p "Ingrese el nombre del archivo: " file_name
            read -p "Ingrese el contenido del archivo: " file_content
            sudo sed -i "s|path: \".*\"|path: \"/home/{{ current_user.stdout }}/$file_name\"|" creararchivo.yml
            sudo sed -i "s|line: .*|line: \"$file_content\"|" creararchivo.yml
            run_playbook creararchivo.yml ;;
        2) run_playbook borrararchivo.yml ;;
        3) run_playbook apache.yml ;;
        4) run_playbook nginxweb.yml ;;
        5) 

            read -p "Ingrese la ruta completa donde desea crear el archivo: " file_path
            # Asegurar que la ruta tenga el formato correcto
            file_path=$(echo "$file_path" | sed 's:/*$::')  # Eliminar la barra al final si existe
            read -p "Ingrese el nombre del archivo: " file_name
            read -p "Ingrese el contenido del archivo: " file_content
            sudo sed -i "s|path: \".*\"|path: \"$file_path/$file_name\"|" creararchivo.yml
            sudo sed -i "s|line: .*|line: \"$file_content\"|" creararchivo.yml
            run_playbook creararchivo.yml ;;
        6) echo "Saliendo del menú. ¡Adiós!"; exit ;;
        *) echo "Opción no válida. Por favor, seleccione un número del 1 al 6." ;;
    esac
    read -p "Presione Enter para continuar..."
done