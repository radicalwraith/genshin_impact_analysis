import pandas as pd

# Load datasets
charac_df = pd.read_csv("data/raw_data/Genshin charac rev (by charac).csv")
genshin_df = pd.read_csv("data/raw_data/genshin.csv", encoding="ISO-8859-1")
banner_df = pd.read_csv("data/raw_data/Genshin charac rev (by banner).csv")

# Preview shapes
print("Character Revenue Data:", charac_df.shape)
print("Character Metadata:", genshin_df.shape)
print("Banner Revenue Data:", banner_df.shape)

# Clean character names for merging
charac_df["char_name_cleaned"] = charac_df["5_star_characters"].str.lower().str.strip()
genshin_df["char_name_cleaned"] = genshin_df["character_name"].str.lower().str.strip()

# Preview cleaned names
print("\nSample cleaned names:")
print(charac_df[["5_star_characters", "char_name_cleaned"]].head(3))
print(genshin_df[["character_name", "char_name_cleaned"]].head(3))

# Merge metadata and revenue based on cleaned names
merged_char_df = pd.merge(
    charac_df,
    genshin_df,
    on="char_name_cleaned",
    how="left",
    suffixes=("_rev", "_meta")
)

# Preview merged data
print("\nMerged character dataset preview:")
print(merged_char_df[[
    "char_name_cleaned", "5_star_characters", "revenue", "rarity", "vision", "region"
]].head(5))

# Clean character names in banner_df
banner_df["char_name_cleaned"] = banner_df["5_star_characters"].str.lower().str.strip()

# Group by character and collect list of banners they appeared on
banner_lists = banner_df.groupby("char_name_cleaned")["version_name"].apply(list).reset_index()
banner_lists.rename(columns={"version_name": "banners_appeared_on"}, inplace=True)

# Merge banner list into final character dataset
final_df = pd.merge(
    merged_char_df,
    banner_lists,
    on="char_name_cleaned",
    how="left"
)

# Drop unnecessary columns from final_df
columns_to_remove = [
    "char_name_cleaned",
    "character_name", "character_url", "portrait_url",
    "vision_url", "weapon_url", "rarity_url", "region_url",
    "weapon_type", "constellation", "title", "description"
]

final_df.drop(columns=[col for col in columns_to_remove if col in final_df.columns], inplace=True)

# Rename and reorder final columns
final_df.rename(columns={
    "5_star_characters": "character",
    "revenue": "total_revenue_usd"
}, inplace=True)

final_df = final_df[[
    "character", "rarity", "vision", "region", "total_revenue_usd", "banners_appeared_on"
]]

# Save cleaned 5-star character data
final_df.to_csv("data/clean_data/merged_character_data.csv", index=False)
print("Cleaned data exported.")

