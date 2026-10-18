#!/bin/bash

version_at() {
  git show "$1:$2" 2>/dev/null | grep -oPm1 '\$\{VERSION:-\K[^}]+'
}

clean() {
  grep -oP '^[vV]?\K[0-9]+(\.[0-9]+)*' <<< "$1" || echo "$1"
}

versions() {
  jq -r '.templates[].repository | [.stackfile, .commit] | @tsv' templates.json |
    while IFS=$'\t' read -r stackfile commit; do
      version=$(version_at "$commit" "$stackfile")
      [ -n "$version" ] && jq -n --arg file "$stackfile" --arg version "$(clean "$version")" '{($file): $version}'
    done | jq -s add
}

JSON=$(jq --argjson versions "$(versions)" \
  '.templates[] |= ($versions[.repository.stackfile] as $version | if $version then {type, title, $version} + del(.version) else . end)' \
  templates.json) && echo "$JSON" > templates.json
