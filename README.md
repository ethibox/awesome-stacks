# Awesome Stacks

Deploy 80+ open-source web apps with one Docker command.

## Features

- [x] Portainer compatibility
- [x] Traefik compatibility
- [x] You can use the env `VOLUME_PATH` to bind a GlusterFS (or NFS) storage created from the host
- [x] No need to manage configuration files, only `<stack>.yml` files

## Get started

```bash
# 1. Deploy traefik
docker swarm init
docker network create --driver=overlay traefik-net
docker stack deploy -c stacks/traefik.yml traefik

# 2. Check your HTTP and HTTPS ports
curl https://ipv4.am.i.mullvad.net/port/80
curl https://ipv4.am.i.mullvad.net/port/443

# 3. Deploy a stack
DOMAIN=<mydomain.com> docker stack deploy -c <stack.yml> <name>

# Example
DOMAIN=ghost.example.com docker stack deploy -c stacks/ghost.yml ghost
```

## License

This project is licensed under the GNU GPL v3.0 - see the [LICENSE.txt](https://raw.githubusercontent.com/ethibox/awesome-stacks/master/LICENSE.txt) file for details

**Free Software, Hell Yeah!**
