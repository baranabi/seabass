FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && apt-get install -y \
    gnupg2 \
    odbc-postgresql \
    python3 \
    python3-jsonschema \
    python3-psutil \
    python3-pyodbc \
    python3-requests \
    unixodbc \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | \
    gpg --no-options --no-default-keyring --no-auto-check-trustdb \
        --homedir /dev/null --no-keyring \
        --import-options import-export \
        --output /etc/apt/keyrings/renci-irods-archive-keyring.pgp --import \
    && echo "deb [signed-by=/etc/apt/keyrings/renci-irods-archive-keyring.pgp arch=amd64] https://packages.irods.org/apt/ noble main" \
        > /etc/apt/sources.list.d/renci-irods.list \
    && apt-get update \
    && apt-get install -y irods-server irods-database-plugin-postgres \
    && rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh
COPY generate_config.py /generate_config.py
COPY wait-for-it.sh /wait-for-it.sh

RUN chmod +x /start.sh /generate_config.py

EXPOSE 1247

ENTRYPOINT ["/start.sh"]
