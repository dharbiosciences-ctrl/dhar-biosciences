#!/usr/bin/env bash
# Builds the deployable site into docs/ (served by GitHub Pages from main:/docs).
# index.html is written as a claude.ai artifact page (no <html>/<head> wrapper),
# so this script adds the document skeleton and copies the assets alongside it.
set -euo pipefail
cd "$(dirname "$0")"

OUT=docs
DOMAIN=dharbiosciences.com

rm -rf "$OUT"
mkdir -p "$OUT/assets"

{
  printf '%s\n' \
    '<!doctype html>' \
    '<html lang="en">' \
    '<meta charset="utf-8">' \
    '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">' \
    '<link rel="icon" href="assets/db-logo.jpg">' \
    '<style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%}[hidden]{display:none!important}</style>'
  cat index.html
  printf '%s\n' '</html>'
} > "$OUT/index.html"

cp assets/* "$OUT/assets/"
printf '%s\n' "$DOMAIN" > "$OUT/CNAME"
touch "$OUT/.nojekyll"
echo "Built $OUT/index.html for $DOMAIN"
