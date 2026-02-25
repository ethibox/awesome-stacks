# Awesome Stacks

Deploy 150+ open-source web apps with one Docker command.

## ✨ Features

- 🚀 **Easy to use**: Deploy your favorite apps with one command
- ⚡ **Zero config** : No need to configure anything, just deploy
- 🔒 **Secure**: Use Traefik and Let's Encrypt to secure your apps
- 🔧 **Customizable**: Change the domain, the volume path, the version, etc.
- 🛳️ **Portainer support**: Use `templates.json` to deploy apps with Portainer

## 📋 Requirements

- Docker Swarm
- Traefik

## 🚀 Installation

1. Install Docker

```bash
apt install -y docker.io
```

2. Initialize Docker Swarm

```bash
docker swarm init
```

3. Deploy Traefik

```bash
docker network create -d overlay traefik-net
docker stack deploy -c stacks/traefik.yml traefik
```

## 📦 Usage

Deploy your apps with one command!

Here an example with [Nextcloud](./stacks/nextcloud.yml):

```bash
docker stack deploy -c stacks/nextcloud.yml nextcloud
```

Go to https://nextcloud.localhost and enjoy your app!

## 🔧 Customization

You can customize the domain, the volume path or the version of your apps with environment variables.

Here an example with [Ghost](./stacks/ghost.yml):

```bash
DOMAIN=example.com VERSION=5 VOLUME_PATH=/mnt/ docker stack deploy -c stacks/ghost.yml ghost
```

Go to https://example.com and enjoy your app!

Refer to the `.yml` files in the [stacks](./stacks) directory to explore all available environment variables and customization options for each app if needed.

## 🎁 Support me

I'd love to work on this project, but my time on this earth is limited, support my work to give me more time!

Please support me with a one-time or a monthly donation and help me continue my activities.

[![Github sponsor](https://img.shields.io/badge/sponsor-30363D?style=for-the-badge&logo=GitHub-Sponsors)](https://github.com/sponsors/johackim/)

## 📜 License

This project is licensed under the GNU GPL v3.0 - see the [LICENSE.txt](https://raw.githubusercontent.com/ethibox/awesome-stacks/master/LICENSE.txt) file for details

**Free Software, Hell Yeah!**
