#!/usr/bin/env bash
# Create any missing GitHub repos, then push every integration and this collection.
# Needs the GitHub CLI signed in: gh auth login --web --scopes repo,workflow
set -euo pipefail
GH=$(command -v gh || echo ~/.local/bin/gh)
OWNER=Marshy-Madness
ROOT=$(cd "$(dirname "$0")/.." && pwd)

"$GH" auth status >/dev/null
"$GH" auth setup-git

ensure_repo() { # name description dir
  if ! "$GH" repo view "$OWNER/$1" >/dev/null 2>&1; then
    "$GH" repo create "$OWNER/$1" --public --description "$2"
  fi
  git -C "$3" remote get-url origin >/dev/null 2>&1 \
    || git -C "$3" remote add origin "https://github.com/$OWNER/$1.git"
  git -C "$3" push -u origin main
}

declare -A DESC=(
  [ha-homebox-plus]="Homebox inventory integration for Home Assistant"
  [ha-memos]="Memos integration for Home Assistant"
  [ha-olivetin]="OliveTin integration for Home Assistant"
  [ha-vikunja]="Vikunja integration for Home Assistant"
  [ha-wolf]="Wolf (Games on Whales) integration for Home Assistant"
)
for dir in "$ROOT"/integrations/*/; do
  name=$(basename "$dir")
  ensure_repo "$name" "${DESC[$name]:-Home Assistant integration}" "$dir"
  "$GH" repo edit "$OWNER/$name" --add-topic home-assistant,hacs,hacs-integration,homeassistant-integration >/dev/null
done
ensure_repo HomeAssistant-Integrations "Custom Home Assistant integrations (submodules)" "$ROOT"
echo "Done: https://github.com/$OWNER/HomeAssistant-Integrations"
