# Script para ejecutar Ansible desde Docker
# Uso: .\ansible.ps1 -- ansible -i inventory-docker.ini all -m ping
# Uso: .\ansible.ps1 -- ansible-playbook -i inventory-docker.ini playbook.yml

param(
    [Parameter(Position=0, ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

# Construir imagen si no existe
$imageName = "practica-ansible-web-ansible"
$imageExists = docker images -q $imageName
if (-not $imageExists) {
    Write-Host "Construyendo imagen de Ansible con sshpass..." -ForegroundColor Yellow
    docker build -f Dockerfile.ansible -t $imageName .
}

docker run --rm -it `
    --network practica-ansible-web_default `
    -v "${PWD}:/ansible" `
    -w /ansible `
    $imageName `
    @Arguments
