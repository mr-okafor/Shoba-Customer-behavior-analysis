# Shoba-Customer-behavior-analysis
Business Intelligence analysis of 3,900 retail orders using Python, SQL and Power BI. Explores customer behavior, loyalty, product performance, discounts, demographics, shipping, seasonality, and customer satisfaction to uncover actionable business insights to improve sales performance, customer engagement, and promotional strategy.


# Consumer Shopping Behavior Analysis

## Overview

This project is a **Business Intelligence and Data Analytics case study** focused on understanding consumer shopping behavior and identifying opportunities to improve sales performance, customer engagement, promotional strategy, and customer experience.

The project follows an end-to-end analytics workflow:

**Python → EDA & Data Cleaning → MySQL & SQL Analysis → Power BI Dashboard → Business Report → Gamma Presentation**

---

## Dataset

The dataset contains **3,900 retail transactions** with information about:

* Customer demographics
* Product categories
* Purchase history
* Discounts
* Review ratings
* Shipping methods
* Payment preferences
* Seasons
* Subscription status
* Previous purchases

Each `customer_id` represents a unique transaction in the dataset.

---

## Tools & Technologies

* **Python** – Data loading, exploration, EDA, and cleaning
* **Pandas** – Data manipulation and analysis
* **MySQL** – Data storage and SQL analysis
* **SQL** – Business-focused querying and aggregation
* **Power BI** – Interactive dashboard development
* **DAX** – KPI and measure development
* **Gamma** – Business presentation
* **GitHub** – Project documentation and version control

---

## Project Workflow

### 1. Data Loading with Python

The dataset was loaded into Python using **Pandas** to inspect its structure, columns, data types, missing values, and overall quality.

### 2. Exploratory Data Analysis

EDA was performed to understand:

* Customer and product distributions
* Purchase behavior
* Discount usage
* Category performance
* Demographic patterns
* Shipping behavior
* Seasonal trends
* Customer satisfaction

### 3. Data Cleaning

The data was reviewed and prepared for analysis by:

* Checking for missing values
* Identifying duplicates
* Validating data types
* Reviewing categorical values
* Checking data consistency
* Preparing the dataset for SQL and Power BI

### 4. SQL Analysis with MySQL

The cleaned dataset was loaded into **MySQL** and analyzed using SQL queries.

Queries were used to calculate and investigate:

* Order volume
* Customer segments
* Product performance
* Discount adoption
* Average Order Value (AOV)
* Customer behavior
* Demographic trends
* Shipping performance
* Seasonal patterns

### 5. Power BI Dashboard

The analysis was brought into **Power BI** to create an interactive dashboard.

The dashboard includes:

* KPI cards
* Customer and sales analysis
* Product performance
* Customer segmentation
* Demographic analysis
* Discount analysis
* Shipping analysis
* Customer satisfaction
* Interactive filters and visualizations

### 6. Business Intelligence Report

The dashboard findings were translated into a structured **Business Intelligence Performance Report** covering key findings, business implications, recommendations, limitations, and opportunities for further analysis.

### 7. Gamma Presentation

The final analysis was converted into a professional **PowerPoint presentation using Gamma**, summarizing the business problem, methodology, key insights, and recommendations.

---

## Dashboard

The Power BI dashboard provides an interactive view of consumer shopping behavior and allows users to explore the data across different customer, product, demographic, promotional, and operational dimensions.

### Key KPIs

* **3,900** Total Orders
* **3.76 / 5** Average Review Rating
* **3,116** Loyal Customer Orders
* **1,737** Clothing Orders
* **675** Free Shipping Orders

---

## Key Results

The analysis identified several important business patterns:

* Loyal customers accounted for approximately **80% of total orders**.
* **Clothing** generated the highest transaction volume with 1,737 orders.
* Discount adoption was relatively high across the dataset, but its relationship with AOV varied by product category.
* **Footwear** showed a higher AOV on discounted orders, while discounted Accessories and Outerwear orders had lower AOVs.
* Free Shipping generated 675 orders with an AOV of approximately **$60.41**.
* The overall average review rating was **3.76/5**.
* Customer purchasing behavior varied across demographic and seasonal segments.
* No discounted transactions were recorded for female customers in the dataset, highlighting an area that warrants further investigation.

---

## Recommendations

Based on the analysis, the following actions were identified:

1. **Develop customer-segmented strategies** rather than treating all customers the same.
2. **Review category-level discount strategies**, particularly where discounts are associated with lower AOV.
3. **Test threshold-based promotions**, such as discounts tied to a minimum basket value.
4. **Investigate the gender promotional gap** to understand whether it relates to targeting, product mix, campaign exposure, or other factors.
5. **Monitor shipping incentives**, particularly Free Shipping, alongside AOV and order volume.
6. **Track customer satisfaction alongside commercial KPIs** to understand the relationship between customer experience and purchasing behavior.
7. Consider future analysis of **customer lifetime value, retention, cohort behavior, profitability, and promotional A/B testing**.

---

## Project Structure

```text
Consumer-Shopping-Behavior-Analysis/
│
├── data/
│   └── customer_behaviour_data.csv
│
├── python/
│   └── exploratory_data_analysis.ipynb
│
├── sql/
│   └── analysis_queries.sql
│
├── powerbi/
│   └── consumer_shopping_behavior.pbix
│
├── report/
│   └── business_intelligence_report.pdf
│
├── presentation/
│   └── consumer_shopping_behavior.pptx
│
└── README.md
```

---

## How to Run

### Python

Install the required libraries:

```bash
pip install pandas numpy matplotlib seaborn
```

Open the Jupyter Notebook in the `python/` folder and run the analysis.

### MySQL

1. Create a MySQL database.
2. Import the cleaned dataset.
3. Run the SQL queries in the `sql/` folder.
4. Review the resulting business metrics and insights.

### Power BI

1. Open the `.pbix` file.
2. Connect to the required data source if necessary.
3. Refresh the dataset.
4. Interact with the dashboard using the available filters and visualizations.

---

## Skills Demonstrated

**Python | Pandas | Exploratory Data Analysis | Data Cleaning | SQL | MySQL | Power BI | DAX | Data Visualization | Business Intelligence | Business Analysis | Data Storytelling**
