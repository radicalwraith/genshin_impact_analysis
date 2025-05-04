{{ config(materialized = 'view') }}

SELECT
    Name AS name,
    COALESCE(Element, 'Unknown') AS vision,
    COALESCE(Region, 'Unknown') AS region,
    COALESCE(Weapon, 'Unknown') AS weapon_type,
    COALESCE(Gender, 'Unknown') AS gender,
    COALESCE(CAST(`Update Playable` AS STRING), 'Unknown') AS update_version,
    COALESCE(Origin, 'Unknown') AS origin

FROM {{ source('genshin_analytics', 'character_popularity') }}
WHERE Name IS NOT NULL