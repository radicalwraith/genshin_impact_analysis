{{ config(
    materialized = 'view'
) }}

WITH base AS (
    SELECT
        character,
        total_revenue_usd,
        banners_appeared_on
    FROM {{ source('genshin_analytics', 'character_revenue') }}
),

aggregated AS (
    SELECT
        character,
        SUM(total_revenue_usd) AS total_revenue_usd,
        ARRAY_AGG(banners_appeared_on) AS banners_appeared_on
    FROM base
    GROUP BY character
)

SELECT * FROM aggregated
