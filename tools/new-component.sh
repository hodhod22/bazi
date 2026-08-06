#!/usr/bin/env bash
# Create a new Bazi component stub.
# Usage: ./tools/new-component.sh extras myDash
#        ./tools/new-component.sh ai myHunt
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KIND="${1:-}"
NAME="${2:-}"
if [[ -z "$KIND" || -z "$NAME" ]]; then
  echo "Usage: $0 <extras|ai|core> <ComponentName>" >&2
  exit 1
fi
if [[ ! "$NAME" =~ ^[A-Za-z][A-Za-z0-9_]*$ ]]; then
  echo "Invalid component name: $NAME" >&2
  exit 1
fi
DIR="$ROOT/lib/bazi/$KIND"
if [[ "$KIND" == "core" ]]; then
  echo "Add to lib/bazi/core.kab manually (shared essentials file)." >&2
  exit 1
fi
mkdir -p "$DIR"
FILE="$DIR/${NAME}.kab"
if [[ -f "$FILE" ]]; then
  echo "Already exists: $FILE" >&2
  exit 1
fi
PASCAL="$NAME"
cat > "$FILE" <<EOF
@version "1.0.0"

// import "bazi/${KIND}/${NAME}"

pub fn create${PASCAL}() {
    return { "kind": "${PASCAL}" }
}

pub fn step${PASCAL}(c, dt) {
    if dt == null || dt == undefined { dt = 0.016 }
    return c
}
EOF
AGG="$ROOT/lib/bazi/${KIND}.kab"
LINE="pub import \"bazi/${KIND}/${NAME}\""
if [[ -f "$AGG" ]] && ! grep -qF "$LINE" "$AGG"; then
  printf '%s\n' "$LINE" >> "$AGG"
fi
echo "Created $FILE"
echo "Import with: import \"bazi/${KIND}/${NAME}\""
