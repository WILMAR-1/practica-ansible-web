# Práctica Ansible - Automatización de Servidor Web

Proyecto de práctica para automatizar la implementación de un servidor web usando Ansible con contenedores Docker simulando múltiples servidores.

## Objetivo

Automatizar la instalación de nginx en múltiples "servidores" simulados con Docker y desplegar una página web personalizada usando Ansible.

## Requisitos

- Docker
- Docker Compose
- Ansible
- Git

## Estructura del Proyecto

```
practica-ansible-web/
├── Dockerfile              # Imagen base para los contenedores
├── docker-compose.yml      # Define los servicios node1 y node2
├── inventory.ini           # Inventario de Ansible con los hosts
├── playbook.yml            # Playbook de Ansible para configurar nginx
└── site/
    └── index.html          # Página web personalizada
```

## Instrucciones de Uso

### 1. Construir y levantar los contenedores

```bash
docker compose up --build -d
```

Esto creará y levantará dos contenedores (node1 y node2) que simulan servidores con SSH habilitado.

### 2. Verificar conexión con Ansible

```bash
ansible -i inventory.ini all -m ping
```

Deberías ver una respuesta exitosa de ambos nodos.

### 3. Ejecutar el playbook

```bash
ansible-playbook -i inventory.ini playbook.yml
```

Este playbook realizará las siguientes tareas:
- Instalar nginx en ambos servidores
- Copiar la página web personalizada
- Asegurar que nginx esté corriendo

### 4. Verificar la instalación

Puedes verificar que nginx está funcionando correctamente en ambos nodos:

```bash
curl http://localhost:2222
curl http://localhost:2223
```

O abrir en tu navegador:
- http://localhost:2222
- http://localhost:2223

### 5. Detener los contenedores

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
- **node1**: accesible en localhost:2222
- **node2**: accesible en localhost:2223

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
