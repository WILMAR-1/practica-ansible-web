# Práctica Ansible - Automatización de Servidor Web

Proyecto de práctica para automatizar la implementación de un servidor web usando Ansible con contenedores Docker simulando múltiples servidores.

## Objetivo

Automatizar la instalación de nginx en múltiples "servidores" simulados con Docker y desplegar una página web personalizada usando Ansible.

## Requisitos

- Docker
- Docker Compose
- Git

**Nota:** No necesitas instalar Ansible localmente. Puedes ejecutarlo desde Docker usando los scripts proporcionados.

## Estructura del Proyecto

```
practica-ansible-web/
├── Dockerfile              # Imagen base para los contenedores
├── docker-compose.yml      # Define los servicios node1 y node2
├── inventory.ini           # Inventario para Ansible instalado localmente
├── inventory-docker.ini    # Inventario para Ansible en Docker
├── playbook.yml            # Playbook de Ansible para configurar nginx
├── ansible.ps1             # Script PowerShell para ejecutar Ansible con Docker
├── ansible.sh              # Script Bash para ejecutar Ansible con Docker
└── site/
    └── index.html          # Página web personalizada
```

## Instrucciones de Uso

### 1. Construir y levantar los contenedores

```bash
docker compose up --build -d
```

Esto creará y levantará dos contenedores (node1 y node2) que simulan servidores con SSH habilitado.

### 2. Ejecutar Ansible

Tienes dos opciones para ejecutar Ansible:

#### Opción A: Usando Docker (Recomendado para Windows)

**En PowerShell:**
```powershell
# Verificar conexión
.\ansible.ps1 -- ansible -i inventory-docker.ini all -m ping

# Ejecutar playbook
.\ansible.ps1 -- ansible-playbook -i inventory-docker.ini playbook.yml
```

**En Git Bash o WSL:**
```bash
# Dar permisos de ejecución (solo primera vez)
chmod +x ansible.sh

# Verificar conexión
./ansible.sh ansible -i inventory-docker.ini all -m ping

# Ejecutar playbook
./ansible.sh ansible-playbook -i inventory-docker.ini playbook.yml
```

#### Opción B: Con Ansible instalado localmente

```bash
# Verificar conexión
ansible -i inventory.ini all -m ping

# Ejecutar playbook
ansible-playbook -i inventory.ini playbook.yml
```

El playbook realizará las siguientes tareas:
- Instalar nginx en ambos servidores
- Copiar la página web personalizada
- Asegurar que nginx esté corriendo

### 3. Verificar la instalación

Puedes verificar que nginx está funcionando correctamente en ambos nodos:

```bash
curl http://localhost:8081
curl http://localhost:8082
```

O abrir en tu navegador:
- http://localhost:8081 (node1)
- http://localhost:8082 (node2)

### 4. Detener los contenedores

```bash
docker compose down
```

## Detalles Técnicos

### Contenedores Docker

Los contenedores están configurados con:
- Sistema operativo: Ubuntu 24.04
- SSH habilitado en el puerto 22
- Usuario: `ansible` (password: `ansible`)
- Permisos de sudo configurados

### Inventario Ansible

El archivo `inventory.ini` define dos hosts:
- **node1**: SSH en localhost:2222, HTTP en localhost:8081
- **node2**: SSH en localhost:2223, HTTP en localhost:8082

Ambos configurados con:
- Usuario SSH: ansible
- Password: ansible
- Opciones SSH para ignorar verificación de host key

### Playbook

El playbook realiza tres tareas principales:
1. Instala nginx usando el módulo `apt`
2. Copia la página HTML personalizada usando el módulo `copy`
3. Asegura que el servicio nginx esté corriendo usando el módulo `service`

## Troubleshooting

### Error de conexión SSH

Si tienes problemas de conexión, verifica que los contenedores estén corriendo:

```bash
docker ps
```

### Error de permisos

Si Ansible no puede ejecutar comandos con privilegios, verifica que el usuario `ansible` tenga permisos de sudo en los contenedores.

### Puerto ya en uso

Si los puertos 2222 o 2223 ya están en uso, puedes modificar el archivo `docker-compose.yml` para usar otros puertos.

## Autor

Práctica creada para la asignatura de automatización de servidores.
