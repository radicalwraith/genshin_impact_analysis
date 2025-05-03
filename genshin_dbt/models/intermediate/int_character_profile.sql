{{ config(
    materialized = 'view'
) }}

WITH metadata AS (
    SELECT *
    FROM {{ ref('stg_character_metadata') }}
),

revenue AS (
    SELECT *
    FROM {{ ref('stg_character_revenue') }}
),

popularity AS (
    SELECT *
    FROM {{ ref('stg_character_popularity') }}
)

SELECT
    m.character_name,

    -- Metadata
    m.rarity,
    m.vision,
    m.region,
    m.weapon_type,
    m.height_class,
    m.gender,

    -- Revenue
    r.total_revenue_usd,
    r.banners_appeared_on,

    -- Popularity
    p.vote_rank,
    p.vote_count,
    p.gender_declared,
    p.origin,
    p.birthday,
    p.update_version

FROM metadata m
LEFT JOIN revenue r ON m.character_name = r.character_name
LEFT JOIN popularity p ON m.character_name = p.character_name
