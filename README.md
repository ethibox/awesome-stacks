# Awesome Stacks

Deploy 120+ open-source web apps with one Docker command.

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
docker stack deploy -c stacks/nextcoud.yml nextcloud
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

[![Github sponsor](https://img.shields.io/badge/github-Support%20my%20work-lightgrey?style=social&logo=github)](https://github.com/sponsors/johackim/)
[![ko-fi](https://img.shields.io/badge/ko--fi-Support%20my%20work-lightgrey?style=social&logo=ko-fi)](https://ko-fi.com/johackim)
[![Buy me a coffee](https://img.shields.io/badge/Buy%20me%20a%20coffee-Support%20my%20work-lightgrey?style=social&logo=buy%20me%20a%20coffee&logoColor=%23FFDD00)](https://www.buymeacoffee.com/johackim)
[![liberapay](https://img.shields.io/badge/liberapay-Support%20my%20work-lightgrey?style=social&logo=liberapay&logoColor=%23F6C915)](https://liberapay.com/johackim/donate)
[![Github](https://img.shields.io/github/followers/johackim?label=Follow%20me&style=social)](https://github.com/johackim)
[![Mastodon](https://img.shields.io/mastodon/follow/1631?domain=https%3A%2F%2Fmastodon.ethibox.fr&style=social)](https://mastodon.ethibox.fr/@johackim)
[![Twitter](https://img.shields.io/twitter/follow/_johackim?style=social)](https://twitter.com/_johackim)

## 📜 License

This project is licensed under the GNU GPL v3.0 - see the [LICENSE.txt](https://raw.githubusercontent.com/ethibox/awesome-stacks/master/LICENSE.txt) file for details

**Free Software, Hell Yeah!**
