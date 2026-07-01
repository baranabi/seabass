# seabass

Topology-driven iRODS test environment. Define any iRODS architecture as a YAML topology file; `seabass` generates the Docker Compose project and manages the lifecycle.

## Requirements

- Docker Engine 24+ with Compose v2 plugin
- Python 3.11+ with `pyyaml` (`pip install pyyaml`)

## Quick start

```bash
# start the default topology (database + 1 provider + 1 client)
./seabass up

# open an iCommands shell
./seabass shell icom

# tear it down
./seabass down
```

`seabass up` generates `docker-compose.yml` and `_initdb.sql` in the current directory, then runs `docker compose up --build -d`. Default topology is `topologies/default.yaml`.

## Project structure

```
icat/               PostgreSQL init SQL (referenced by generated compose)
irods-server/       Generic iRODS server image (provider or consumer via env var)
  ├── Dockerfile
  ├── start.sh              Entrypoint — detects first boot vs restart
  ├── generate_config.py    Builds unattended JSON from env vars
  └── wait-for-it.sh
icom/               iCommands client image
  ├── Dockerfile
  ├── start.sh              Reads env vars, runs iinit
  └── wait-for-it.sh
topologies/         Pre-built topology files
  ├── default.yaml
  └── multi-resource.yaml
seabass             CLI tool (Python)
```

## CLI reference

| Command | Description |
|---------|-------------|
| `seabass up [topology]` | Build & start the topology (default: `topologies/default.yaml`) |
| `seabass down` | `docker compose down -v` — destroys containers + volumes |
| `seabass shell [service]` | `docker exec -it <service> bash` (default: `icom`) |
| `seabass test <topology> <script>` | Stand up, run a bash script, tear down |
| `seabass generate [topology]` | Generate `docker-compose.yml` without starting |

## Topology reference

### Minimal (`topologies/default.yaml`)

```yaml
zone_name: tempZone
admin_password: password

database:
  hostname: icat

provider:
  hostname: ies
  resources:
    - name: demoResc
      type: unixfilesystem
      path: /var/lib/irods/Vault

consumers: []

clients:
  - hostname: icom
    mount: "."
```

### Multi-resource (`topologies/multi-resource.yaml`)

```yaml
zone_name: tempZone
admin_password: password

database:
  hostname: icat

provider:
  hostname: ies
  resources:
    - name: demoResc
      type: unixfilesystem
      path: /var/lib/irods/Vault

consumers:
  - hostname: irs1
    resources:
      - name: SBRS_1
        type: unixfilesystem
        path: /var/lib/irods/Vault
  - hostname: irs2
    resources:
      - name: SBRS_2
        type: unixfilesystem
        path: /var/lib/irods/Vault

clients:
  - hostname: icom
    mount: "."
```

The generator creates one Docker Compose service per topology entry. Each consumer gets its own service with unique resource name and vault — no `--scale`, no post-start renaming.

### Custom topologies

```yaml
zone_name: myZone
admin_password: s3cret
zone_key: MY_ZONE_KEY
negotiation_key: 12345678901234567890123456789012  # exactly 32 bytes

database:
  hostname: postgres
  image: postgres:17        # any supported version
  user: mydbuser
  password: mydbpass
  db_name: MY_CATALOG

provider:
  hostname: provider1
  port: 1247
  resources:
    - name: fast_resc
      type: unixfilesystem
      path: /vault/fast

consumers:
  - hostname: resc01
    port: 1247
    resources:
      - name: resc01_vault
        type: unixfilesystem
        path: /vault/resc01

clients:
  - hostname: admin
    mount: /data/set
  - hostname: analyst
```

## Architecture

### Images

| Image | Role | Starts as |
|-------|------|-----------|
| `icat` (postgres:16) | Database | Listens on 5432 |
| `irods-server` | Catalog provider or consumer | Wait for DB/provider, then `setup_irods.py` or `irodsctl start` |
| `icom` | iCommands client | Wait for provider, then `iinit` |

### How configuration flows

```
topology.yaml
    │
    ▼
seabass (generates)
    │
    ├── docker-compose.yml      ──► docker compose up --build
    ├── _initdb.sql              ──► postgres init scripts
    │
    ▼
container starts
    │
    ├── start.sh reads env vars
    │
    ├── [/etc/irods/server_config.json exists?]
    │   ├── yes → irodsctl start (restart path)
    │   └── no  → generate_config.py → setup_irods.py (first boot)
    │
    ▼
    iRODS ready
```

### Environment variables

#### iRODS server (`irods-server/start.sh`)

| Variable | Default | Description |
|----------|---------|-------------|
| `IRODS_SERVER_ROLE` | `provider` | `provider` or `consumer` |
| `IRODS_ZONE_NAME` | `tempZone` | iRODS zone name |
| `IRODS_ADMIN_PASSWORD` | `password` | rodsadmin password |
| `IRODS_HOST` | container hostname | This server's hostname |
| `IRODS_PORT` | `1247` | iRODS port |
| `IRODS_RESOURCE_NAME` | `demoResc` | Default resource name |
| `IRODS_VAULT_DIR` | `/var/lib/irods/Vault` | Vault directory |
| `IRODS_DB_HOST` | `icat` | Database hostname (provider only) |
| `IRODS_DB_PORT` | `5432` | Database port |
| `IRODS_DB_NAME` | `ICAT` | Database name |
| `IRODS_DB_USER` | `irods` | Database user |
| `IRODS_DB_PASSWORD` | `password` | Database password |
| `IRODS_ODBC_DRIVER` | `PostgreSQL ANSI` | ODBC driver name |
| `IRODS_CATALOG_PROVIDER` | — | Provider hostname (required for consumers) |
| `IRODS_ZONE_KEY` | `TEMPORARY_ZONE_KEY` | Zone authentication key |
| `IRODS_NEGOTIATION_KEY` | `32_byte_server_negotiation_key__` | Must be exactly 32 bytes |
| `IRODS_CONTROL_PLANE_KEY` | `32_byte_server_control_plane_key` | Control plane key |
| `IRODS_CONTROL_PLANE_PORT` | `1248` | Control plane port |

#### iCommands client (`icom/start.sh`)

| Variable | Default | Description |
|----------|---------|-------------|
| `IRODS_PROVIDER_HOST` | `ies` | Provider hostname to connect to |
| `IRODS_PROVIDER_PORT` | `1247` | Provider port |
| `IRODS_ZONE_NAME` | `tempZone` | Zone name |
| `IRODS_ADMIN_USER` | `rods` | rodsadmin username |
| `IRODS_ADMIN_PASSWORD` | `password` | rodsadmin password |

### First boot vs restart

When a server container starts, `start.sh` checks for `/etc/irods/server_config.json`:

- **Not present** (first boot / fresh container): runs `generate_config.py` to build the unattended JSON from environment variables, then runs `setup_irods.py`. The setup script creates the service account, database tables (if provider), and starts iRODS.
- **Present** (container restart): runs `irodsctl start` to restart the iRODS server process.

This means you can `docker compose stop` / `docker compose start` without re-running setup.

### Lifecycle management

| Action | Command | iRODS state |
|--------|---------|-------------|
| First start | `seabass up` | Fresh install |
| Stop | `docker compose stop` | Stopped, config preserved |
| Restart | `docker compose start` | Resumes via `irodsctl start` |
| Full reset | `seabass down` | Containers + volumes destroyed |

## Testing

```bash
# run a test script against a custom topology
./seabass test topologies/multi-resource.yaml ./my-test.sh
```

The `test` command stands up the topology, executes the script, captures its exit code, then tears down. The test script runs on the host and can use `docker exec` to run iCommands inside the icom container.

Example test script (`my-test.sh`):

```bash
#!/bin/bash
set -e

# wait for iRODS to be ready
sleep 5

# run commands via the icom container
docker exec icom iinit <<< "password"
docker exec icom imkdir test-coll
docker exec icom iput -r /some/data /test-coll
docker exec icom ils -r /test-coll

echo "PASS"
```

## Extending

### Custom iRODS version

Edit `irods-server/Dockerfile` to pin a version:

```dockerfile
RUN apt-get install -y irods-server=4.3.5-0~ubuntu24.04 irods-database-plugin-postgres
```

Or replace the apt install with your own package source (local mirror, volume-mounted `.deb` files).

### Multi-zone federation

Federation requires multiple Compose projects. Create one topology per zone and stand them up separately:

```bash
seabass generate zone-a.yaml -o /tmp/zone-a
seabass generate zone-b.yaml -o /tmp/zone-b
docker compose -p zone-a -f /tmp/zone-a/docker-compose.yml up -d
docker compose -p zone-b -f /tmp/zone-b/docker-compose.yml up -d
```

Then exchange zone keys manually via `iadmin modzone` and `docker exec`.
