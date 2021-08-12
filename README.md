# Awesome Stacks

Deploy 120+ open-source web apps with one Docker command.

## Prerequisites

- Docker Swarm

## Get started

```bash
# 1. Deploy traefik
docker network create --driver=overlay traefik-net
docker stack deploy -c traefik.yml traefik

# 2. Deploy a stack
docker stack deploy -c <stack.yml> <name>
```

## License

This project is licensed under the GNU GPL v3.0 - see the [LICENSE.txt](https://raw.githubusercontent.com/ethibox/awesome-stacks/master/LICENSE.txt) file for details

**Free Software, Hell Yeah!**
