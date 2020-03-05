#!/bin/bash

if [[ -z "$1" || -z "$2" || -z "$3" || -z "$4" ]]; then
    echo "usage: monitoring [portainer_token] [portainer_domain] [prometheus_file] [prometheus_service]"
    exit 1
fi

PORTAINER_TOKEN="$1"
PORTAINER_DOMAIN="$2"
PROMETHEUS_FILE="$3"
PROMETHEUS_SERVICE="$4"
while :
do
    sed -i -e '/#domain/d' "$PROMETHEUS_FILE"

    DOMAINS=$(curl -s "https://$PORTAINER_DOMAIN/api/stacks" -H "Authorization: Bearer $PORTAINER_TOKEN" | jq -r '.[].Env[0].value' | uniq)

    for DOMAIN in ${DOMAINS}; do
        sed -i -e "s+#targets+#targets\n        - https://$DOMAIN #domain+g" "$PROMETHEUS_FILE";
    done

    docker service update --force "$PROMETHEUS_SERVICE"

    sleep 3600
done
