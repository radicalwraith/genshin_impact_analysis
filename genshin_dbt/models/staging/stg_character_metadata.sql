WITH renamed AS (
    SELECT
        character_name,
        rarity,
        vision,
        region,
        weapon_type,
        -- Split model into two columns
        SPLIT(model, ' ')[OFFSET(0)] AS height_class,
        SPLIT(model, ' ')[OFFSET(1)] AS gender
    FROM {{ source('genshin_analytics', 'character_metadata') }}
)
SELECT * FROM renamed
