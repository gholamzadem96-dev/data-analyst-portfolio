# Database Setup

This project uses SQLite for SQL-based business analysis.

## Database Information
- **Database Engine:** SQLite
- **Database Name:** Online_Store_Analysis.db
- **Table Name:** sales
- **Source Dataset:** `../data/SQL_Sales_Source.csv`

## How to Create the Database
1. Open DB Browser for SQLite.
2. Create a new SQLite database named `Online_Store_Analysis.db`.
3. Select **File → Import → Table from CSV file**.
4. Choose `SQL_Sales_Source.csv`.
5. Set the table name to `sales`.
6. Enable **First row contains column names**.
7. Complete the import and save the database.

## Important
The SQLite database file is not included in this repository. It can be recreated using the CSV dataset and the instructions above.

The SQL analysis queries are available in the `../sql/sales_analysis.sql` file.
