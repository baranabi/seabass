#!/bin/bash
set -e

PROVIDER_HOST="${IRODS_PROVIDER_HOST:-ies}"
PROVIDER_PORT="${IRODS_PROVIDER_PORT:-1247}"
ZONE_NAME="${IRODS_ZONE_NAME:-tempZone}"
ADMIN_USER="${IRODS_ADMIN_USER:-rods}"
ADMIN_PASSWORD="${IRODS_ADMIN_PASSWORD:-password}"

echo "=== ICOM: waiting for provider ($PROVIDER_HOST:$PROVIDER_PORT) ==="
/wait-for-it.sh "$PROVIDER_HOST:$PROVIDER_PORT" --timeout=120

if [ ! -f /root/.irods/irods_environment.json ]; then
    echo "=== ICOM: configuring environment ==="
    mkdir -p /root/.irods
    cat > /root/.irods/irods_environment.json <<EOF
{
    "irods_host": "$PROVIDER_HOST",
    "irods_port": $PROVIDER_PORT,
    "irods_user_name": "$ADMIN_USER",
    "irods_zone_name": "$ZONE_NAME"
}
EOF
    echo "$ADMIN_PASSWORD" | iinit
    echo "=== ICOM: iinit complete ==="
fi

echo "=== ICOM: ready ==="
bash
