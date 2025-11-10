#!/bin/bash
# Script para ejecutar Ansible desde Docker
# Uso: ./ansible.sh ansible -i inventory-docker.ini all -m ping
# Uso: ./ansible.sh ansible-playbook -i inventory-docker.ini playbook.yml

IMAGE_NAME="practica-ansible-web-ansible"

# Construir imagen si no existe
if ! docker images -q $IMAGE_NAME | grep -q .; then
    echo "Construyendo imagen de Ansible con sshpass..."
    docker build -f Dockerfile.ansible -t $IMAGE_NAME .
fi

docker run --rm -it \
    --network practica-ansible-web_default \
    -v "$(pwd):/ansible" \
    -w /ansible \
    $IMAGE_NAME \
    "$@"
