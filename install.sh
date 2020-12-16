#!/bin/bash

do_install() {
echo "Executing docker install script..."
curl -fsSL https://get.docker.com | sh > /dev/null 2>&1
echo "Initialize docker swarm..."
docker swarm init > /dev/null 2>&1
echo "Deploy traefik reverse-proxy..."
docker network create --driver=overlay traefik-net >/dev/null 2>&1
docker stack deploy -c <(curl -so - https://ethibox.github.io/stacks/traefik.yml) traefik > /dev/null 2>&1
echo "Installation completed"
}

# run the script upon successful download
do_install
