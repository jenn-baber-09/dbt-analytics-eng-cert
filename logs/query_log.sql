-- created_at: 2026-01-31T06:04:59.313308500+00:00
-- finished_at: 2026-01-31T06:04:59.433492900+00:00
-- elapsed: 120ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c217ec-0004-684e-0000-000b44827bc1
-- desc: list_relations_in_parallel
SHOW OBJECTS IN SCHEMA "DBT_ANALYTICS_ENG_CERT"."PUBLIC_STAGING" LIMIT 10000;
-- created_at: 2026-01-31T06:05:00.193934100+00:00
-- finished_at: 2026-01-31T06:05:00.286523100+00:00
-- elapsed: 92ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c217ed-0004-684c-0000-000b4482ab3d
-- desc: execute adapter call
show terse schemas in database DBT_ANALYTICS_ENG_CERT
    limit 10000
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "default", "target_name": "dev"} */;
