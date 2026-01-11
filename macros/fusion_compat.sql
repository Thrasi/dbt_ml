{% macro config_meta_get(key, default=none) %}
    {# First try meta config (version-specific), then fall back to direct config, then default #}
    
    {# Check meta config - dbt 1.11+ has config.meta_get(), older versions need config.get("meta") #}
    {%- if config.meta_get is defined -%}
        {%- set meta_value = config.meta_get(key, none) -%}
    {%- else -%}
        {%- set meta = config.get("meta", {}) -%}
        {%- set meta_value = meta.get(key, none) if meta is mapping else none -%}
    {%- endif -%}
    
    {%- if meta_value != none -%}
        {{ return(meta_value) }}
    {%- elif config.get(key, none) != none -%}
        {{ return(config.get(key)) }}
    {%- else -%}
        {{ return(default) }}
    {%- endif -%}
{% endmacro %}
