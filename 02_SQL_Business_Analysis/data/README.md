# Dataset

## File
`SQL_Sales_Source.csv`

## Dataset Overview
This dataset contains cleaned online store sales records for the year 2025.

- **Total Records:** 1,000
- **Total Columns:** 18
- **Time Period:** January–December 2025
- **Format:** CSV (Comma-Separated Values)

## Data Contents
The dataset includes information about:
- Order IDs and dates
- Customer IDs
- Regions
- Product categories and product names
- Quantities
- Unit prices and costs
- Discounts
- Revenue and gross profit
- Payment methods

## Data Quality Notes
- One record has a missing Quantity value.
- Two records have missing payment methods, represented as `Unknown`.
- The original data quality flag contains inconsistencies; SQL analysis checks missing Quantity values directly.

## Usage
Import this CSV file into SQLite using DB Browser for SQLite. Use `sales` as the table name to run the queries in the `sql` folder.
