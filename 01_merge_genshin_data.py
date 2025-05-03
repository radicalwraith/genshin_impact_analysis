import pandas as pd
import re

# Load datasets
banner_df = pd.read_csv("data/raw_data/Genshin charac rev (by banner).csv")
metadata_df = pd.read_csv("data/raw_data/genshin.csv", encoding="ISO-8859-1")

# Step 1: Normalize character names in banner dataset
def clean_char_name(name):
    # Split characters on '&' and clean each one
    names = name.split('&')
    cleaned = []
    for n in names:
        n = n.strip()
        # Remove rerun info like (2Nd Rerun), extra spaces
        n = re.sub(r"\(.*?\)", "", n)
        n = n.replace("  ", " ").strip()
        cleaned.append(n)
    return cleaned

# Explode banner dataset
rows = []

for idx, row in banner_df.iterrows():
    banner = row["version_name"]
    revenue = row["revenue"]
    raw_char_string = row["5_star_characters"]
    
    try:
        revenue = float(str(revenue).replace(",", ""))
    except:
        continue  # Skip if revenue is missing or corrupted

    for character in clean_char_name(raw_char_string):
        rows.append({
            "character": character,
            "banner": banner,
            "revenue": revenue
        })

exploded_df = pd.DataFrame(rows)

# Step 2: Aggregate total revenue and banners per character
agg_df = exploded_df.groupby("character").agg(
    total_revenue_usd=pd.NamedAgg(column="revenue", aggfunc="sum"),
    banners_appeared_on=pd.NamedAgg(column="banner", aggfunc=lambda x: list(set(x)))
).reset_index()

# Step 3: Prepare metadata
metadata_df["character_cleaned"] = metadata_df["character_name"].str.strip()

# Step 4: Merge with metadata
final_df = pd.merge(
    agg_df,
    metadata_df,
    left_on="character",
    right_on="character_cleaned",
    how="left"
)

# Step 5: Select only relevant columns
final_df = final_df[[
    "character",
    "rarity",
    "vision",
    "region",
    "total_revenue_usd",
    "banners_appeared_on"
]]

# Optional: sort by revenue
final_df = final_df.sort_values(by="total_revenue_usd", ascending=False)

# Step 6: Export cleaned data
final_df.to_csv("data/clean_data/merged_character_data.csv", index=False)
print("Cleaned data exported successfully.")
