Stacks
===

[![License](https://img.shields.io/badge/license-GPL%20v3%2B-yellow.svg?style=flat-square&colorA=0d7377&colorB=44c2c7)](https://raw.githubusercontent.com/ethibox/stacks/master/LICENSE.txt)
[![Donate](https://img.shields.io/badge/donate-liberapay-blue.svg?style=flat-square&colorA=0d7377&colorB=44c2c7)](https://liberapay.com/johackim/donate)

## Usage

```bash
# 1. Deploy traefik
docker network create --driver=overlay traefik-net
docker stack deploy -c traefik.yml traefik

# 2. Deploy a stack
docker stack deploy -c <stack.yml> <name>

# Example
DOMAIN=mydomain.com VERSION=5.3-fpm docker stack deploy -c wordpress.yml mywordpress
```

## Support

Support me with a monthly donation and help me continue my activities:

[![liberapay](https://liberapay.com/assets/widgets/donate.svg)](https://liberapay.com/johackim/donate)

Buy me a beer (BTC): [bitcoin:112aZxX9Jiya4TM6Le4foxTq9V8U6aVGbG](bitcoin:112aZxX9Jiya4TM6Le4foxTq9V8U6aVGbG)

## License

This project is licensed under the GNU GPL v3.0 - see the [LICENSE.txt](LICENSE.txt) file for details

**Free Software, Hell Yeah!**
