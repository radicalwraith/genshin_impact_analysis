{{ config(
    materialized = 'view'
) }}

WITH renamed AS (
    SELECT
        Name AS character_name,
        `Place by # of Votes` AS vote_rank,
        Votes AS vote_count
    FROM {{ source('genshin_analytics', 'character_popularity') }}
)

SELECT * FROM renamed
