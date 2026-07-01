#!/bin/bash
set -e

ROLE="${IRODS_SERVER_ROLE:-provider}"
DB_HOST="${IRODS_DB_HOST:-icat}"
CATALOG_PROVIDER="${IRODS_CATALOG_PROVIDER:-}"

if [ "$ROLE" = "provider" ]; then
  echo "=== Waiting for database ($DB_HOST:5432) ==="
  /wait-for-it.sh "$DB_HOST:5432" --timeout=60
else
  echo "=== Waiting for catalog provider ($CATALOG_PROVIDER:1247) ==="
  /wait-for-it.sh "$CATALOG_PROVIDER:1247" --timeout=120
fi

if [ ! -f /etc/irods/server_config.json ]; then
  echo "=== First boot: configuring iRODS $ROLE ==="
  python3 /generate_config.py
  python3 /var/lib/irods/scripts/setup_irods.py \
    --json_configuration_file /tmp/unattended.json
  echo "=== Setup complete ==="
else
  echo "=== Restart: starting iRODS $ROLE ==="
  su - irods -c '/var/lib/irods/irodsctl start' || true
fi

echo "=== iRODS $ROLE ready ==="
tail -f /dev/null
