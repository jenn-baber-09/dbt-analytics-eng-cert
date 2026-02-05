{{ 
    codegen.generate_source(
        database_name= 'snowflake_sample_data', 
        schema_name= 'TPCDS_SF100TCL',
        generate_columns= true,
        include_descriptions= true,
        include_data_types= true,
        include_database= false,
        include_schema= false,
        case_sensitive_databases= false,
        case_sensitive_schemas= false,
        case_sensitive_tables= false,
        case_sensitive_cols= false

    ) 
}}