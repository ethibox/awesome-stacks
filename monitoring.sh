#!/bin/bash

if [[ -z "$1" || -z "$2" || -z "$3" || -z "$4" || -z "$5" ]]; then
    echo "usage: monitoring [portainer_username] [portainer_password] [portainer_url] [prometheus_file] [prometheus_service]"
    exit 1
fi

PORTAINER_USERNAME="$1"
PORTAINER_PASSWORD="$2"
PORTAINER_URL="$3"
PROMETHEUS_FILE="$4"
PROMETHEUS_SERVICE="$5"

while :
do
    sed -i -e '/#domain/d' "$PROMETHEUS_FILE"

    PORTAINER_TOKEN=$(curl -s -X POST "${PORTAINER_URL}/api/auth" -d '{"username":"'$PORTAINER_USERNAME'","password":"'$PORTAINER_PASSWORD'"}' -H "Content-Type: application/json" | jq -r '.jwt')

    DOMAINS=$(curl -s "$PORTAINER_URL/api/stacks" -H "Authorization: Bearer $PORTAINER_TOKEN" | jq -r '.[].Env[0].value' | uniq)

    for DOMAIN in ${DOMAINS}; do
        sed -i -e "s+#targets+#targets\n        - https://$DOMAIN #domain+g" "$PROMETHEUS_FILE";
    done

    docker service update --force "$PROMETHEUS_SERVICE"

    sleep 3600
done
