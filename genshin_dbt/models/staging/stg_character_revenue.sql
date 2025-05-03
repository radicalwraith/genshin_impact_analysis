{{ config(
    materialized = 'view'
) }}

WITH base AS (
    SELECT
        character,
        revenue_usd,
        banner_name
    FROM {{ source('genshin_analytics', 'character_revenue') }}
),

aggregated AS (
    SELECT
        character,
        SUM(revenue_usd) AS total_revenue_usd,
        ARRAY_AGG(banner_name) AS banners_appeared_on
    FROM base
    GROUP BY character
)

SELECT * FROM aggregated
