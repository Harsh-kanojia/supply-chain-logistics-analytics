# Supply Chain & Logistics Performance Analytics

An end-to-end data analytics portfolio project exploring order volume, delivery performance, shipping costs, warehouse operations, customer experience, and product returns using **Excel, Python, MySQL, and Power BI**. ChatGPT was used as an AI assistant to help speed up parts of the workflow, troubleshoot questions, and support documentation.

## Project Overview

This project analyzes a sample supply chain and logistics dataset containing **50,000 orders and 37 columns after feature engineering**. The workflow combines spreadsheet-based exploration, Python feature engineering, SQL-based business analysis, and an interactive Power BI dashboard.

The aim is to turn order-level data into understandable performance measures and practical questions that a logistics or operations team could investigate.

> **Data note:** This is a sample dataset covering January–December 2026. The date range describes the sample data; it should not be interpreted as verified real-world transactions.

## Business Objectives

- Measure overall order volume and delivery performance.
- Compare late-delivery rates across shipping methods, carriers, warehouses, distance bands, and weather conditions.
- Understand shipping costs across delivery methods, distance categories, and product categories.
- Explore the relationship between delays and customer ratings.
- Review return reasons and identify areas for further operational investigation.
- Present findings in a clear, interactive dashboard.

## Dataset

- **Source resource:** [Kaggle — E-commerce Logistics Analytics](https://www.kaggle.com/code/datascikhan/e-commerce-logistics-analytics)
- **Domain:** Supply chain and logistics
- **Rows:** 50,000
- **Columns:** 37 after feature engineering
- **Format:** CSV
- **Raw source file:** `data/E-commerce_Delivery_Shipping_Data_2026.csv`
- **Feature-engineered output:** `data/Supply_Chain_Feature_Engineered.csv`

The dataset includes order dates and IDs, customer segments, warehouse and city information, product categories, shipping methods, carriers, distances, promised and actual delivery durations, delivery status, shipping costs, order values, weather conditions, ratings, delivery attempts, and return information.

The linked Kaggle resource is a notebook page and states that the notebook is released under the Apache 2.0 license. That does not automatically establish the separate license or redistribution terms for its input dataset. Confirm the dataset asset's terms before publishing either the raw CSV or a derivative copy publicly. If redistribution is not permitted, keep the data out of the public repository and explain how to obtain it from the source.

## Technologies and Tools

| Technology | Role in this project |
|---|---|
| **Microsoft Excel** | Initial data understanding and spreadsheet-based exploration; Power Query was used for interface-based data exploration and transformation. |
| **Python (Pandas, NumPy)** | Feature engineering on the dataset. The data had already been cleaned for this project, so Python's documented role is feature creation rather than claiming a separate cleaning stage. |
| **MySQL** | 24 SQL challenges covering delivery performance, shipping costs, customers, products, warehouses, weather, delivery attempts, and returns. |
| **Power BI** | DAX measures and a three-page interactive dashboard with 17 visuals. |
| **ChatGPT (AI assistant)** | Helped accelerate problem-solving, explain concepts, support query and dashboard troubleshooting, and improve project documentation. AI assistance was used alongside the tools; it is not a substitute for the underlying analysis. |

## Project Workflow

1. **Excel / Power Query:** Explore the data and understand the available fields.
2. **Python feature engineering:** Use Pandas and NumPy to derive order month and weekday, classify delay severity, calculate shipping-cost percentage fields, and create distance and warehouse-processing bands.
3. **MySQL analysis:** Use SQL aggregations, conditional calculations, grouping, common table expressions (CTEs), and window functions to answer 24 business questions.
4. **Power BI dashboard:** Build DAX measures and interactive visuals to summarize delivery operations, costs, customers, and returns.
5. **Interpretation and recommendations:** Compare results, identify patterns worth investigating, and communicate them without treating correlation as proof of causation.

## Python Feature Engineering

The raw source CSV has **30 columns**. The feature-engineering notebook produces a **50,000-row, 37-column** output with these seven additional fields:

- `order_month`
- `order_day_of_week`
- `delay_severity`
- `shipping_cost_pct`
- `shipping_cost_per`
- `distance_band`
- `warehouse_processing_band`

The source data already contains `delivery_delay_days`; the notebook uses it to assign the categories **On Time / Early**, **Minor Delay**, **Moderate Delay**, and **Severe Delay**. The distance and warehouse-processing bands make comparisons easier in SQL and Power BI.

The notebook uses project-relative paths. From the `python/` folder, it reads `../data/E-commerce_Delivery_Shipping_Data_2026.csv` and writes `../data/Supply_Chain_Feature_Engineered.csv`. Ensure the raw CSV is in that location before running the notebook.

## SQL Analysis: 24 Business Challenges

The SQL script at [`sql/Codes.sql`](sql/Codes.sql) contains 24 numbered challenges. They cover:

1. Count orders by delivery status.
2. Compare late and non-late orders and their percentages.
3. Compare late-delivery rates by shipping method.
4. Compare late-delivery rates by distance band.
5. Compare late-delivery rates by warehouse processing band.
6. Summarize average, minimum, and maximum shipping costs by shipping method.
7. Summarize shipping costs by distance band.
8. Analyze monthly order volume and shipping costs.
9. Compare order volume and shipping costs by day of the week.
10. Compare order volume, costs, and late deliveries by customer segment.
11. Rank recorded return reasons by frequency and percentage.
12. Compare order volume, order value, shipping costs, and late deliveries by product category.
13. Compare carrier late-delivery rates, average delivery duration, and customer ratings.
14. Compare delivery performance and shipping costs by order priority.
15. Compare delays, late-delivery rates, and shipping costs by customer rating.
16. Compare warehouse order volume, processing hours, delays, late deliveries, and ratings.
17. Compare delivery performance across weather conditions.
18. Explore delivery attempts against late-delivery rates, delivery duration, and ratings.
19. Find the most common return reason within each product category using CTEs and `RANK()`.
20. Rank warehouses by late-delivery percentage.
21. Measure order distribution across delay-severity categories using a window function.
22. Compare average shipping costs with average order values by product category.
23. Compare actual delivery duration, delay days, and late-delivery rates by order priority.
24. Compare average shipping cost per kilometre by shipping method.

The SQL file is the technical record of the queries. The findings below are calculated from the uploaded CSV using the corresponding groupings and conditions, so the reader can see the result as well as the query topic. They are not presented as screenshots or as proof that every query was executed in MySQL during this documentation step.

## Selected SQL Findings

The following values were calculated from the uploaded 50,000-row CSV and are included to demonstrate the kind of business questions answered. Percentages are rounded to two decimal places.

| Area | Finding from the sample data | Potential business implication |
|---|---|---|
| Overall delivery performance | **28,162 of 50,000 orders were late (56.32%).** | Late delivery is a major performance area to investigate. |
| Distance | The late-delivery rate was **80.89%** for Very Long Distance orders and **38.48%** for Short Distance orders. | Review long-distance routes, transit planning, and delivery promises. |
| Warehouse processing | The late-delivery rate was **72.27%** for the Very Slow processing band and **40.93%** for the Fast band. | Investigate process bottlenecks and whether faster processing is associated with improved delivery performance. |
| Carriers | GlobalExpress had a **65.75%** late-delivery rate; SwiftShip had **47.34%**. | Compare carrier service levels, route mix, and order characteristics before making carrier decisions. |
| Weather | Late-delivery rates were **93.51%** for Snow, **91.00%** for Storm, and **34.97%** for Clear conditions. | Consider weather-aware scheduling and realistic delivery estimates. |
| Shipping methods | International orders had a **67.67%** late-delivery rate and an average shipping cost of **$204.40**; Same Day orders had a **24.50%** late-delivery rate and an average shipping cost of **$136.58**. | Compare delivery speed, cost, distance, and service expectations together; the methods serve different use cases. |
| Order priority | Low-priority orders had an **81.70%** late-delivery rate; Urgent orders had a **25.69%** late-delivery rate. | Check whether prioritization rules and the mix of orders help explain the difference. |
| Returns | Product Defect was the most frequent recorded return reason (**2,184**), followed by Damaged Package (**1,511**). | Investigate product quality and packaging processes. |
| Shipping cost vs. order value | In the SQL-style comparison, Books had an average shipping-cost-to-average-order-value ratio of **277.68%**, while Electronics had **21.93%**. | Review low-value orders and shipping economics by category; this ratio compares averages and is not the same as the average of each order's individual ratio. |

**Interpretation caution:** These are patterns in a sample dataset. They do not establish that any one factor caused a delay or return. Before acting on a result, a business should check sample definitions, route and order mix, data quality, and operational context.

## Power BI Dashboard

The completed Power BI report contains **three pages and 17 visuals**. It uses DAX measures and interactive charts to make key metrics easier to explore. SQL analysis and Power BI complement one another: SQL demonstrates query-based investigation, while the dashboard provides a visual, interactive summary. Not every SQL query is represented as an individual Power BI visual.

### Page 1 — Executive Overview

**Four KPI cards**
- Total Orders
- Late Orders
- Late Delivery Rate
- On-Time Delivery Rate

**Three charts**
- Monthly Order Trend
- Order Distribution by Delivery Status
- Late Delivery Rate by Shipping Method

The report's core delivery measures are **50,000 total orders**, **28,162 late orders**, a **56.32% late-delivery rate**, and a **43.68% on-time rate**. Additional DAX measures created for the project include total shipping cost, average shipping cost, average delivery days, average delay days, total order value, total returns, and return rate.

### Page 2 — Delivery Operations

Five charts:
- Late Delivery Rate by Carrier
- Late Delivery Rate by Warehouse City
- Order Count by Delay Severity
- Average Delivery Days by Shipping Method
- Late Delivery Rate by Weather Condition

This page compares delivery performance across operational dimensions and helps highlight areas for further investigation.

### Page 3 — Costs, Customers & Returns

Five charts:
- Average Shipping Cost by Shipping Method
- Average Shipping Cost by Distance Band
- Average Customer Rating by Delay Severity
- Total Order Value by Product Category
- Return Reasons by Number of Orders

The return-reasons visual is filtered to records where `return_requested = Yes`, excluding blank return reasons.

## Combined Business Insights and Recommendations

Based on the sample data and the completed analyses, the following are **investigation recommendations**, not causal conclusions:

1. **Investigate long-distance deliveries.** Review routes, carrier allocation, transit-time assumptions, and promised delivery windows for long-distance orders.
2. **Review warehouse processing.** Compare processing steps and operational conditions across processing bands and warehouses to locate possible bottlenecks.
3. **Monitor carrier and weather patterns.** Review service performance in context, including route mix, weather exposure, order volume, and service type.
4. **Evaluate shipping economics.** Compare shipping cost with order value and distance, particularly for product categories where average shipping cost is high relative to average order value.
5. **Investigate product returns.** Examine product defects and damaged packages to identify whether product information, quality control, or packaging practices could be improved.
6. **Use the dashboard for ongoing review.** Monitor delivery performance, shipping cost, customer ratings, and returns together rather than optimizing a single metric in isolation.

## Repository Structure

The project is organized as follows. Use the exact filenames shown when adding the binary files to GitHub.

```text
supply-chain-logistics-analytics/
├── data/
│   ├── E-commerce_Delivery_Shipping_Data_2026.csv
│   └── Supply_Chain_Feature_Engineered.csv
├── python/
│   └── Project_1_Ecom.ipynb
├── sql/
│   └── Codes.sql
├── powerbi/
│   └── Supply_Chain_Feature_Engineered.pbix
├── screenshots/
│   ├── executive_overview.png
│   ├── delivery_operations.png
│   ├── costs_customers_returns.png
│   └── sql_analysis/
└── README.md
```

**Dataset publishing note:** The raw CSV and feature-engineered CSV are not substitutes for checking the source data's license. Publish them only if the dataset's terms permit redistribution. The Power BI report may require the data file at the same relative location to refresh successfully.

## How to Explore the Project

1. Read this README for the project context and key findings.
2. Open [`sql/Codes.sql`](sql/Codes.sql) to inspect the 24 business questions and query logic.
3. Review [`python/Project_1_Ecom.ipynb`](python/Project_1_Ecom.ipynb) to understand the feature-engineering steps.
4. Open `powerbi/Supply_Chain_Feature_Engineered.pbix` in Power BI Desktop to explore the three dashboard pages and interact with the visuals.
5. Check the `screenshots/` folder for dashboard and selected SQL-result images, when available.

Before running the notebook, place the raw CSV in `data/E-commerce_Delivery_Shipping_Data_2026.csv`. When opening the Power BI report on another computer, confirm its data source path and update the connection if needed.

## Skills Demonstrated

- Data understanding and spreadsheet analysis
- Excel and Power Query
- Python feature engineering with Pandas and NumPy
- SQL aggregation, conditional logic, CTEs, ranking, and window functions
- DAX measures and Power BI dashboard design
- KPI interpretation and exploratory business analysis
- Translating findings into operational questions and recommendations
- Using ChatGPT as an AI assistant to accelerate learning, troubleshooting, and documentation

## Conclusion

This project demonstrates an end-to-end analytics workflow across **Excel, Python, MySQL, and Power BI**. Python feature engineering prepares additional analytical fields, SQL answers 24 business questions, and Power BI presents the key performance measures through an interactive three-page dashboard. Together, these components show the ability to work with a structured dataset, investigate operational patterns, and communicate findings in a business-oriented way.
