#!/usr/bin/env bash
# Export SQL de la base locale (XAMPP). Usage :
#   ./scripts/export-database.sh              → toute la base
#   ./scripts/export-database.sh users        → une table
#   ./scripts/export-database.sh users bookings

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT_DIR="$ROOT/database/backups"
DB_NAME="ariaqqrw_casa_immo"
MYSQLDUMP="/Applications/XAMPP/xamppfiles/bin/mysqldump"

if [[ ! -x "$MYSQLDUMP" ]]; then
    echo "mysqldump XAMPP introuvable : $MYSQLDUMP" >&2
    exit 1
fi

mkdir -p "$OUT_DIR"

TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
TABLES=("$@")

if [[ ${#TABLES[@]} -eq 0 ]]; then
    FILE="$OUT_DIR/${DB_NAME}-${TIMESTAMP}.sql"
    "$MYSQLDUMP" -u root --no-tablespaces "$DB_NAME" > "$FILE"
else
    SAFE="$(printf '%s' "${TABLES[*]}" | tr ' ' '-')"
    FILE="$OUT_DIR/${DB_NAME}-${SAFE}-${TIMESTAMP}.sql"
    "$MYSQLDUMP" -u root --no-tablespaces "$DB_NAME" "${TABLES[@]}" > "$FILE"
fi

echo "Export OK : $FILE"
ls -lh "$FILE"
