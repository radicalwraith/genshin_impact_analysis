**Genshin Impact Data Analytics Project**

🌟 **Overview**

This project is a full-stack data analytics solution designed around Genshin Impact, a game I genuinely enjoy and connect with. The goal was not only to build an engaging portfolio project but also to demonstrate end-to-end data engineering and analytics capabilities using modern tools. From raw CSV files to a fully functional, interactive Looker Studio dashboard, this project walks through the complete data lifecycle.

🌐 **Tech Stack**
	•	Data Ingestion: Python (Pandas)
	•	Cloud Data Warehouse: Google BigQuery
	•	Data Modeling & Transformation: dbt Core (Staging → Intermediate → Mart)
	•	Visualization: Looker Studio
	•	Version Control: Git & GitHub

⚖️ **Architecture**

CSV Files (Raw Data)
   └️ Python Script (Cleaning & Merging)
        └️ BigQuery (Cloud Data Warehouse)
              └️ dbt Core
                    ├️ Staging Models
                    ├️ Intermediate Model (int_character_profile)
                    ├️ Fact Table (fct_character_performance)
                    ├️ Dimension Table (dim_characters)
                    └️ Mart Table (mart_character_summary)
                          └️ Looker Studio (Interactive Dashboard)

📅 **Why Genshin Impact?**

I’ve always been passionate about this game, and it has a large, constantly evolving cast of characters and events, which makes it an ideal candidate for a rich data project. The datasets include banner revenues, popularity votes, and detailed metadata on every 4-star and 5-star character, which allowed me to:
	•	Practice data cleaning and transformation on semi-structured datasets
	•	Implement solid dimensional modeling principles (star schema)
	•	Create a compelling, visually rich dashboard

📊 **Features**
	•	Cleaned and enriched character metadata from multiple sources
	•	Normalized revenue data grouped by character across all banners
	•	Popularity rankings with dynamic re-ranking via SQL window functions
	•	Mart table joining fact + dim tables for reporting
	•	Looker Studio dashboard with 5 key visualizations

🔍 **Key Visualizations**
	1.	Top 10 Revenue Generating Characters (Bar Chart)
	2.	Vision Type Distribution (Pie Chart)
	3.	Character Revenue by Region (Stacked Bar)
	4.	Top 10 Popular Characters as of v5.4
	5.	Total Characters as of v5.4

🖋️ **How to Reproduce**
	1.	Clone the repo
	2.	Run the Python script to clean raw data
	3.	Upload to BigQuery
	4.	Initialize dbt & run all models
	5.	Connect Looker Studio to BigQuery and start visualizing

✨ **What I Learned**
	•	Managing messy datasets and aligning different schemas
	•	How to modularize SQL transformations with dbt
	•	Data storytelling through interactive dashboards
	•	Setting up shareable BI solutions with minimal cost

⸻

This project reflects not just my technical skills, but also my curiosity and creativity. Genshin Impact gave me the narrative, but this pipeline gave me the stage to show what I can do as an aspiring analytics engineer.
I am still not done with this project yet as I am exploring more datasets online. Just wanted to explore the what I could build with everything that is available as of now.

⸻

Want to explore the dashboard? [[Live Looker Studio Link](https://lookerstudio.google.com/reporting/990b0ccd-d8a5-417f-ad85-6fb075ef77b6)]

⸻

Made with ❤️ by a Genshin fan who loves data.
