#!/usr/bin/env python3
import json
import os
import platform


def get_config():
    role = os.environ.get("IRODS_SERVER_ROLE", "provider")
    zone_name = os.environ.get("IRODS_ZONE_NAME", "tempZone")
    admin_password = os.environ.get("IRODS_ADMIN_PASSWORD", "password")
    host = os.environ.get("IRODS_HOST", platform.node().split(".")[0])
    port = int(os.environ.get("IRODS_PORT", "1247"))

    resource_name = os.environ.get("IRODS_RESOURCE_NAME", "demoResc")
    vault_dir = os.environ.get("IRODS_VAULT_DIR", "/var/lib/irods/Vault")

    zone_key = os.environ.get(
        "IRODS_ZONE_KEY", "TEMPORARY_ZONE_KEY"
    )
    negotiation_key = os.environ.get(
        "IRODS_NEGOTIATION_KEY", "32_byte_server_negotiation_key__"
    )
    control_key = os.environ.get(
        "IRODS_CONTROL_PLANE_KEY", "32_byte_server_control_plane_key"
    )
    control_port = int(os.environ.get("IRODS_CONTROL_PLANE_PORT", "1248"))

    db_host = os.environ.get("IRODS_DB_HOST", "icat")
    db_port = int(os.environ.get("IRODS_DB_PORT", "5432"))
    db_name = os.environ.get("IRODS_DB_NAME", "ICAT")
    db_user = os.environ.get("IRODS_DB_USER", "irods")
    db_password = os.environ.get("IRODS_DB_PASSWORD", "password")
    db_odbc = os.environ.get(
        "IRODS_ODBC_DRIVER", "PostgreSQL ANSI"
    )

    catalog_provider = os.environ.get("IRODS_CATALOG_PROVIDER", "")
    provider_hosts = (
        [catalog_provider] if catalog_provider else [host]
    )

    cfg = {
        "admin_password": admin_password,
        "default_resource_directory": vault_dir,
        "default_resource_name": resource_name,
        "host_system_information": {
            "service_account_user_name": "irods",
            "service_account_group_name": "irods",
        },
        "service_account_environment": {
            "irods_client_server_negotiation": "request_server_negotiation",
            "irods_client_server_policy": "CS_NEG_REFUSE",
            "irods_connection_pool_refresh_time_in_seconds": 300,
            "irods_cwd": f"/{zone_name}/home/rods",
            "irods_default_hash_scheme": "SHA256",
            "irods_default_number_of_transfer_threads": 4,
            "irods_default_resource": resource_name,
            "irods_encryption_algorithm": "AES-256-CBC",
            "irods_encryption_key_size": 32,
            "irods_encryption_num_hash_rounds": 16,
            "irods_encryption_salt_size": 8,
            "irods_home": f"/{zone_name}/home/rods",
            "irods_host": host,
            "irods_match_hash_policy": "compatible",
            "irods_maximum_size_for_single_buffer_in_megabytes": 32,
            "irods_port": port,
            "irods_server_control_plane_encryption_algorithm": "AES-256-CBC",
            "irods_server_control_plane_encryption_num_hash_rounds": 16,
            "irods_server_control_plane_key": control_key,
            "irods_server_control_plane_port": control_port,
            "irods_transfer_buffer_size_for_parallel_transfer_in_megabytes": 4,
            "irods_user_name": "rods",
            "irods_zone_name": zone_name,
            "schema_name": "service_account_environment",
            "schema_version": "v4",
        },
        "server_config": {
            "advanced_settings": {
                "agent_factory_watcher_sleep_time_in_seconds": 5,
                "default_number_of_transfer_threads": 4,
                "default_temporary_password_lifetime_in_seconds": 120,
                "delay_server_sleep_time_in_seconds": 30,
                "maximum_size_for_single_buffer_in_megabytes": 32,
                "maximum_size_of_delay_queue_in_bytes": 0,
                "maximum_temporary_password_lifetime_in_seconds": 1000,
                "migrate_delay_server_sleep_time_in_seconds": 5,
                "number_of_concurrent_delay_rule_executors": 4,
                "stacktrace_file_processor_sleep_time_in_seconds": 10,
                "transfer_buffer_size_for_parallel_transfer_in_megabytes": 4,
                "transfer_chunk_size_for_parallel_transfer_in_megabytes": 40,
            },
            "catalog_provider_hosts": provider_hosts,
            "catalog_service_role": role,
            "default_hash_scheme": "SHA256",
            "default_resource_name": resource_name,
            "host_resolution": {"host_entries": []},
            "match_hash_policy": "compatible",
            "negotiation_key": negotiation_key,
            "plugin_configuration": {
                "authentication": {},
                "network": {},
                "resource": {},
                "rule_engines": [
                    {
                        "instance_name": "irods_rule_engine_plugin-irods_rule_language-instance",
                        "plugin_name": "irods_rule_engine_plugin-irods_rule_language",
                        "plugin_specific_configuration": {
                            "re_data_variable_mapping_set": ["core"],
                            "re_function_name_mapping_set": ["core"],
                            "re_rulebase_set": ["core"],
                            "regexes_for_supported_peps": [
                                "ac[^ ]*",
                                "msi[^ ]*",
                                "[^ ]*pep_[^ ]*_(pre|post|except|finally)",
                            ],
                        },
                        "shared_memory_instance": "irods_rule_language_rule_engine",
                    },
                    {
                        "instance_name": "irods_rule_engine_plugin-cpp_default_policy-instance",
                        "plugin_name": "irods_rule_engine_plugin-cpp_default_policy",
                        "plugin_specific_configuration": {},
                    },
                ],
            },
            "schema_validation_base_uri": "file:///var/lib/irods/configuration_schemas",
            "server_control_plane_encryption_algorithm": "AES-256-CBC",
            "server_control_plane_encryption_num_hash_rounds": 16,
            "server_control_plane_key": control_key,
            "server_control_plane_port": control_port,
            "server_control_plane_timeout_milliseconds": 10000,
            "server_port_range_end": 20199,
            "server_port_range_start": 20000,
            "zone_auth_scheme": "native",
            "zone_key": zone_key,
            "zone_name": zone_name,
            "zone_port": port,
            "zone_user": "rods",
        },
    }

    if role == "provider":
        cfg["server_config"]["plugin_configuration"]["database"] = {
            "postgres": {
                "db_host": db_host,
                "db_name": db_name,
                "db_odbc_driver": db_odbc,
                "db_password": db_password,
                "db_port": db_port,
                "db_username": db_user,
            }
        }

    return cfg


if __name__ == "__main__":
    config = get_config()
    out = os.environ.get("IRODS_CONFIG_OUTPUT", "/tmp/unattended.json")
    with open(out, "w") as f:
        json.dump(config, f, indent=4)
    print(f"Config written to {out}")
