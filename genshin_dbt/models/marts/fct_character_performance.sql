{{ config(materialized = 'view') }}

WITH base AS (
    SELECT * FROM {{ ref('int_character_profile') }}
),

filtered AS (
    SELECT
        character_name,
        COALESCE(total_revenue_usd, 0) AS total_revenue_usd,
        vote_count
    FROM base
    WHERE vote_count IS NOT NULL
),

ranked AS (
    SELECT
        character_name,
        total_revenue_usd,
        vote_count,
        ROW_NUMBER() OVER (ORDER BY vote_count DESC) AS vote_rank
    FROM filtered
)

SELECT * FROM ranked