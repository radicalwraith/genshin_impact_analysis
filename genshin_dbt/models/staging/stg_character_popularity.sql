{{ config(
    materialized = 'view'
) }}

WITH renamed AS (
    SELECT
        Name AS character_name,
        `Place by # of Votes` AS vote_rank,
        Votes AS vote_count,
        Element AS vision,
        Weapon AS weapon_type,
        Gender AS gender_declared,
        Region AS region,
        Origin AS origin,
        Birthday AS birthday,
        `Update Playable` AS update_version
    FROM {{ source('genshin_analytics', 'character_popularity') }}
)

SELECT * FROM renamed
