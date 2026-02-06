{{ codegen.generate_model_yaml(
    model_names=['stg__call_center', 'stg__store_returns', 'stg__inventory', 'stg__income_band', 'stg__ship_mode', 'stg__time_dim', 'stg__store_sales', 'stg__catalog_sales', 'stg__warehouse', 'stg__catalog_returns', 'stg__promotion', 'stg__catalog_page', 'stg__date_dim', 'stg__customer_address', 'stg__web_page', 'stg__customer', 'stg__web_site', 'stg__web_sales', 'stg__store', 'stg__web_returns', 'stg__customer_demographics', 'stg__household_demographics', 'stg__item', 'stg__reason'],
    upstream_descriptions=True, 
    include_data_types=True,
) }}