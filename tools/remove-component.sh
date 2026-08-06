#!/usr/bin/env bash
# Remove a Bazi component from this kit (file + aggregator line).
# Usage: ./tools/remove-component.sh extras myDash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KIND="${1:-}"
NAME="${2:-}"
if [[ -z "$KIND" || -z "$NAME" ]]; then
  echo "Usage: $0 <extras|ai> <ComponentName>" >&2
  exit 1
fi
FILE="$ROOT/lib/bazi/$KIND/${NAME}.kab"
AGG="$ROOT/lib/bazi/${KIND}.kab"
LINE="pub import \"bazi/${KIND}/${NAME}\""
if [[ -f "$FILE" ]]; then
  rm -f "$FILE"
  echo "Removed $FILE"
else
  echo "No file: $FILE" >&2
fi
if [[ -f "$AGG" ]]; then
  tmp="$(mktemp)"
  grep -vF "$LINE" "$AGG" > "$tmp" || true
  mv "$tmp" "$AGG"
  echo "Updated $AGG"
fi
