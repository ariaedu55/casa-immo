#!/usr/bin/env bash
# Archive pour cPanel — plus légère que zip manuel (sans .git, images HD inutiles).
#
# Usage :
#   ./scripts/build-deploy-zip.sh          → ../casa-immo-deploy.zip (~7 Mo, avec vendor)
#   ./scripts/build-deploy-zip.sh --lite   → ../casa-immo-deploy-lite.zip (~3 Mo, sans vendor)
#
# Sur le serveur sans vendor : composer install --no-dev --optimize-autoloader

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LITE=0

for arg in "$@"; do
    case "$arg" in
        --lite) LITE=1 ;;
    esac
done

if [[ "$LITE" -eq 1 ]]; then
    OUT="$(dirname "$ROOT")/casa-immo-deploy-lite.zip"
else
    OUT="$(dirname "$ROOT")/casa-immo-deploy.zip"
fi

cd "$ROOT"

EXCLUDES=(
    -x '*.git/*'
    -x '*/.git/*'
    -x '*__MACOSX*'
    -x '*.DS_Store'
    -x '.env'
    -x 'config/database.php'
    -x 'storage/logs/*'
    -x 'storage/cache/*'
    -x 'database/backups/*.sql'
    -x 'storage/scheduler/*'
    -x '*.zip'
    -x 'assets/images/brand/*.bak*'
    # Versions HD non utilisées (le site utilise les *-800.jpg)
    -x 'assets/images/destinations/bignona.jpg'
    -x 'assets/images/destinations/oussouye.jpg'
    -x 'assets/images/destinations/cap-skirring.jpg'
    -x 'assets/images/destinations/ziguinchor.jpg'
    -x 'assets/images/destinations/sedhiou.jpg'
)

if [[ "$LITE" -eq 1 ]]; then
    EXCLUDES+=(-x 'vendor/*')
fi

zip -r -9 "$OUT" . "${EXCLUDES[@]}"

echo "Archive créée : $OUT"
ls -lh "$OUT"

if [[ "$LITE" -eq 1 ]]; then
    echo ""
    echo "Mode --lite : exécutez sur l'hébergeur (SSH ou Terminal cPanel) :"
    echo "  composer install --no-dev --optimize-autoloader"
fi
