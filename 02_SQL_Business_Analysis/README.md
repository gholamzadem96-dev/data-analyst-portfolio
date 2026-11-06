# SQL Business Analysis Project
### Online Store Sales, Profitability & Customer Analytics

## 1. Project Overview

This project presents an end-to-end business analysis of an online store's sales data using SQL and SQLite.

The objective is to transform raw sales records into meaningful business insights by examining revenue performance, product profitability, regional trends, customer purchasing behavior, discount patterns, and quarterly performance.

The project demonstrates practical SQL skills, analytical thinking, data quality assessment, and the ability to translate data into actionable business findings.

## 2. Business Objectives

The analysis addresses the following business questions:

- What is the overall financial performance of the business?
- Which regions and product categories generate the most revenue?
- Which products contribute the most to gross profit?
- How does profitability vary across products and discount levels?
- Which customers contribute most to total revenue?
- How significant are repeat customers?
- How does business performance change across months and quarters?
- Which products and customers should receive greater management attention?

## 3. Dataset Description

The dataset represents one year of online store transactions.

| Attribute | Description |
|---|---|
| Total records | 1,000 orders |
| Total columns | 18 |
| Period | January–December 2025 |
| Format | CSV |
| Database | SQLite |
| Main table | sales |

The dataset includes order information, customer IDs, regions, product categories, product names, quantities, unit prices, costs, discounts, revenue, gross profit, and payment methods.

## 4. Tools and Technologies

- **SQL:** Data querying and business analysis
- **SQLite:** Relational database management
- **DB Browser for SQLite:** Query execution and database inspection
- **GitHub:** Version control and portfolio presentation
- **Excel:** Initial data preparation and validation

## 5. Data Quality Assessment

Data quality was examined before interpreting the results.

Key observations:

- One record contains a missing Quantity value.
- Two records contain missing payment methods, categorized as `Unknown`.
- The original `Data_Quality_Flag` column contains inconsistencies.
- Missing Quantity values were identified directly through SQL rather than relying on the original quality flag.

The dataset contains 1,000 records: 999 with a populated Quantity field and one with a missing Quantity value.

## 6. SQL Analysis Areas

The project includes 15 analytical sections covering the following areas:

### A. Business Performance
- Total orders and revenue
- Total cost and gross profit
- Average order value
- Overall gross profit margin

### B. Regional and Category Analysis
- Revenue and profitability by region
- Category-level sales performance
- Regional product performance
- Regional payment patterns

### C. Product Analysis
- Product revenue and gross profit
- Product profitability ranking
- Product margin comparison
- Product Pareto analysis
- Product ABC classification

### D. Customer Analytics
- Customer revenue ranking
- Repeat customer analysis
- Customer value segmentation
- Customer ABC classification
- Customer purchasing patterns

### E. Discount Analysis
- Revenue and margin by discount level
- Product-level discount performance
- Category and discount comparisons
- Regional discount performance

### F. Time-Based Analysis
- Monthly sales trends
- Quarterly sales performance
- Quarterly category performance
- Quarterly product performance

## 7. Key Business Findings

### Overall Financial Performance

| KPI | Result |
|---|---:|
| Total Orders | 1,000 |
| Total Revenue | $149,501.95 |
| Total Cost | $81,669.00 |
| Gross Profit | $67,832.95 |
| Average Order Value | $149.50 |
| Gross Profit Margin | 45.37% |

### Product and Category Performance

- The Home category generated **$90,825.80**, approximately 60.8% of total revenue.
- Office Chair was the leading product, generating **$72,231.75** in revenue.
- Office Chair contributed approximately 48.3% of revenue but only 37.86% of gross profit.
- Pen Set recorded the highest product gross profit margin at **70.45%**.
- The Office Chair margin was 35.55%, below the overall business margin.

### Regional Performance

- North was the leading region, generating **$57,174.55** in revenue and **$25,361.05** in gross profit.
- East had the highest regional gross profit margin at 49.45%, but the lowest revenue.
- North accounted for approximately 38.24% of total revenue.

### Customer Analysis

- The dataset contains 255 distinct customers.
- 236 customers made repeat purchases during the observed period.
- Repeat customers accounted for approximately 97.6% of total revenue.
- Customer ABC analysis identified 124 A-class customers, contributing approximately 80.12% of revenue.

### Discount Analysis

- Orders with no discount had an average gross profit margin of 47.91%.
- Orders with a 15% discount had an average margin of 39.88%.
- Higher discount levels were associated with lower gross profit margins.
- This is an observed association and does not establish a causal relationship.

### Quarterly Performance

- Q3 recorded the highest quarterly revenue: **$40,879.30**.
- Q3 also generated the highest gross profit: **$18,251.80**.
- Q4 recorded the highest quarterly gross profit margin at 47.22%.

### Product ABC Analysis

Six products generated approximately 82.40% of total gross profit, highlighting the concentration of profitability across the product portfolio.

## 8. Business Recommendations

Based on the observed results:

1. **Review the Office Chair pricing strategy:** Its high revenue contribution and comparatively low margin justify a closer review of costs, pricing, and discount policies.
2. **Protect high-margin products:** Products such as Pen Set, Notebook Pack, and Printer Paper have strong margins and deserve further commercial evaluation.
3. **Investigate regional opportunities:** East has a relatively high margin but low revenue, suggesting an opportunity for further market investigation.
4. **Monitor discount policies:** Evaluate discount levels against product margins rather than relying solely on revenue or order volume.
5. **Prioritize key products:** Use the Pareto findings to support inventory and product-management decisions.
6. **Maintain customer analysis:** Further periods of data would help evaluate customer retention and purchasing trends over time.

These recommendations are based on descriptive analysis and should be validated with additional business information before implementation.

## 9. SQL Skills Demonstrated

The project applies practical SQL techniques, including:

- SELECT, WHERE, GROUP BY, ORDER BY
- Aggregate functions: SUM, COUNT, AVG
- CASE WHEN conditional logic
- Common Table Expressions (CTEs)
- Window functions: RANK and cumulative SUM
- Date and string functions
- CAST and REPLACE
- Data quality checks
- Revenue and profitability calculations
- Pareto and ABC analysis
- Customer segmentation

## 10. Project Structure

```text
02_SQL_Business_Analysis/
│
├── README.md
│
├── data/
│   ├── README.md
│   └── SQL_Sales_Source.csv
│
├── database/
│   └── README.md
│
└── sql/
    ├── README.md
    └── sales_analysis.sql
```

## 11. How to Run the Project

1. Download `SQL_Sales_Source.csv` from the `data` folder.
2. Open DB Browser for SQLite.
3. Create a new SQLite database.
4. Import the CSV file as a table named `sales`.
5. Open `sql/sales_analysis.sql`.
6. Execute the SQL queries to reproduce the analysis.

The SQLite database file is not included in this repository; it can be recreated using the provided CSV file.

## 12. Limitations

- The dataset covers only one calendar year.
- The analysis is based on the available transaction-level fields.
- Historical customer revenue should not be interpreted as true Customer Lifetime Value (CLV).
- Observed relationships between discounts and profitability do not establish causation.
- Additional periods and operational data would improve forecasting and strategic analysis.

## 13. Author

**Mohammad Gholamzadeh**

Aspiring Data Analyst | SQL | Excel | Business Analysis

GitHub Portfolio:  
https://github.com/gholamzadem96-dev/data-analyst-portfolio
