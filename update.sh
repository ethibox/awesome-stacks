#!/bin/bash

get_pattern() {
  local current="$1"
  local major
  major=$(echo "$current" | grep -oE '^[vV]?[0-9]+')
  
  if [[ "$current" =~ ^stable ]]; then
    echo "^stable-[0-9]+$"
  elif [[ "$current" =~ alpine ]]; then
    echo "^$major\.[0-9.]+(-fpm)?-alpine$"
  else
    echo "^$major\.[0-9.]+(-[0-9]+)?$"
  fi
}

get_latest_version() {
  local image="$1"
  local pattern="$2"
  local api_path="${image#ghcr.io/}"
  [[ "$api_path" != */* ]] && api_path="library/$api_path"

  if [[ "$image" =~ ghcr.io ]]; then
    curl -s "https://api.github.com/repos/$api_path/tags" | jq -r '.[].name' 2>/dev/null | grep -E "$pattern" | sort -V | tail -n 1
  else
    curl -s "https://registry.hub.docker.com/v2/repositories/$api_path/tags?page_size=100" | jq -r '.results[].name' 2>/dev/null | grep -E "$pattern" | sort -V | tail -n 1
  fi
}

update_app() {
  local app="$1"
  local file="stacks/$app.yml"
  [ ! -f "$file" ] && return

  grep -E 'image: .*\$\{VERSION:-' "$file" | while read -r line; do
    [[ "$line" =~ \$\{VERSION:-([^}]+)\} ]] && current="${BASH_REMATCH[1]}" || continue
    
    local image
    image=$(echo "$line" | sed -E 's/.*image: (&[^ ]+ )?(.*):\$\{VERSION.*/\2/' | sed -E 's/\$\{.*:-(.*)\}/\1/' | tr -d "'\" ")
    
    local pattern
    pattern=$(get_pattern "$current")
    
    local latest
    latest=$(get_latest_version "$image" "$pattern")
    
    if [[ -n "$latest" && "$latest" != "$current" ]]; then
      sed -i "s/:-$current}/:-$latest}/g" "$file"
      echo "Updated $app ($image): $current -> $latest"
    fi
  done
}

main() {
  local apps=(${@:-nextcloud discourse rocketchat n8n mastodon mattermost metabase jitsi kanboard matomo mediawiki grist zammad wordpress nocobase wekan mautic calendso})
  for app in "${apps[@]}"; do
    update_app "$app"
  done
}

main "$@"
