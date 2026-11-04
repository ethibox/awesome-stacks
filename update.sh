#!/bin/bash

get_pattern() {
  local current="$1"
  local prefix='^([^0-9]*[0-9]+\.[0-9]+-)?[vV]?'
  local major suffix

  [[ "$current" =~ ^stable ]] && { echo "^stable-[0-9]+$"; return; }

  major=$(echo "$current" | grep -oE "${prefix}[0-9]+" | sed 's/\./\\./g')
  grep -q -- --major /proc/$$/cmdline && major=$(echo "$major" | sed -E 's/[0-9]+$/[0-9]+/')
  suffix=$(echo "$current" | sed -E -e "s/${prefix}[0-9][0-9.]*(-[0-9]+)?//" -e 's/\./\\./g; s/[0-9]+/[0-9]+/g')

  echo "^$major\.[0-9.]+(-[0-9]+)?$suffix$"
}

get_latest_version() {
  local image="$1" pattern="$2"

  { skopeo list-tags --no-creds "docker://$image" || echo "Failed to list tags: $image" >&2; } |
    jq -r '.Tags[]' | grep -E "$pattern" | grep -vE '[0-9]{8}' | sort -V | tail -n 1
}

update_app() {
  local app="$1"
  local file="stacks/$app.yml"
  [ ! -f "$file" ] && return

  grep -E 'image: .*\$\{VERSION:-' "$file" | while read -r line; do
    [[ "$line" =~ \$\{VERSION:-([^}]+)\} ]] || continue
    local current="${BASH_REMATCH[1]}"
    local image latest

    image=$(echo "$line" | sed -E 's/.*image: (&[^ ]+ )?(.*):\$\{VERSION.*/\2/; s/\$\{.*:-(.*)\}/\1/')
    latest=$(get_latest_version "$image" "$(get_pattern "$current")")

    if [[ -n "$latest" && "$latest" != "$current" ]]; then
      sed -i "\|$image}*:|s/:-$current}/:-$latest}/" "$file"
      echo "Updated $app ($image): $current -> $latest"
    fi
  done
}

main() {
  command -v skopeo >/dev/null || { echo "skopeo is required: https://github.com/containers/skopeo/blob/main/install.md" >&2; exit 1; }

  for app in ${@:-$(basename -s .yml stacks/*.yml)}; do
    update_app "$app"
  done
}

main ${@//--major/}
