{{ config(materialized = 'view') }}

WITH fact AS (
    SELECT * FROM {{ ref('fct_character_performance') }}
),

dim AS (
    SELECT * FROM {{ ref('dim_characters') }}
)

SELECT
    f.character_name,
    d.vision,
    d.region,
    d.weapon_type,
    d.gender,
    d.update_version,
    d.origin,
    f.total_revenue_usd,
    f.vote_count,
    f.vote_rank
FROM fact f
LEFT JOIN dim d
    ON LOWER(f.character_name) = LOWER(d.character_name)