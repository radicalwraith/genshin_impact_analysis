{{ config(
    materialized = 'view'
) }}

WITH metadata AS (
    SELECT * FROM {{ ref('stg_character_metadata') }}
),

revenue AS (
    SELECT * FROM {{ ref('stg_character_revenue') }}
),

popularity AS (
    SELECT * FROM {{ ref('stg_character_popularity') }}
),

joined AS (
    SELECT
        COALESCE(m.name, r.character, p.character_name) AS character_name,

        -- Metadata (prefer metadata)
    
        m.vision AS vision,
        m.region AS region,
        m.weapon_type AS weapon_type,
        m.gender AS gender,

        -- Revenue
        r.total_revenue_usd,
        r.banners_appeared_on,

        -- Popularity
        p.vote_rank,
        p.vote_count,
        m.origin,
        m.update_version

    FROM metadata m
    FULL OUTER JOIN revenue r
        ON lower(m.name) = lower(r.character)
    FULL OUTER JOIN popularity p
        ON lower(COALESCE(m.name, r.character)) = lower(p.character_name)
)

SELECT * FROM joined
