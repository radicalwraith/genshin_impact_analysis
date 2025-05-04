{{ config(materialized = 'view') }}

SELECT
    name AS character_name,
    vision,
    region,
    weapon_type,
    gender,
    update_version,
    origin,
    'Unknown' AS rarity,
    'Unknown' AS height_class
FROM {{ ref('stg_character_metadata') }}
WHERE name IS NOT NULL