-- =====================================================
-- PROJECT: Online Store Sales Analysis
-- DATABASE: SQLite
-- TABLE: sales
-- PERIOD: 2025
-- PURPOSE: Business Performance Analysis
-- =====================================================


-- 1. BUSINESS PERFORMANCE OVERVIEW

SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(SUM(Total_Cost), 2) AS total_cost,
    ROUND(SUM(Gross_Profit), 2) AS total_gross_profit,
    ROUND(AVG(Revenue), 2) AS average_order_value,
    ROUND(
        SUM(Gross_Profit) * 100.0 / SUM(Revenue),
        2
    ) AS profit_margin
FROM sales;


-- 2. REGIONAL SALES PERFORMANCE

SELECT
    UPPER(TRIM(Region)) AS region,
    COUNT(*) AS total_orders,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(SUM(Gross_Profit), 2) AS gross_profit,
    ROUND(
        SUM(Gross_Profit) * 100.0 / SUM(Revenue),
        2
    ) AS profit_margin
FROM sales
GROUP BY UPPER(TRIM(Region))
ORDER BY total_revenue DESC;


-- 3. CATEGORY PERFORMANCE

SELECT
    Category,
    COUNT(*) AS total_orders,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(SUM(Gross_Profit), 2) AS gross_profit
FROM sales
GROUP BY Category
ORDER BY total_revenue DESC;


-- 4. MONTHLY SALES TREND

SELECT
    strftime('%Y-%m', Order_Date) AS sales_month,
    COUNT(*) AS total_orders,
    ROUND(SUM(Revenue), 2) AS monthly_revenue,
    ROUND(SUM(Gross_Profit), 2) AS gross_profit
FROM sales
GROUP BY strftime('%Y-%m', Order_Date)
ORDER BY sales_month;
-- 5. PRODUCT PROFITABILITY ANALYSIS

SELECT
    Product,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(SUM(Gross_Profit), 2) AS gross_profit,
    ROUND(
        SUM(Gross_Profit) * 100.0 /
        NULLIF(SUM(Revenue), 0),
        2
    ) AS profit_margin
FROM sales
GROUP BY Product
ORDER BY gross_profit DESC;


-- 6. PRODUCT PROFITABILITY RANKING

SELECT
    Product,
    ROUND(
        SUM(Gross_Profit) * 100.0 /
        NULLIF(SUM(Revenue), 0),
        2
    ) AS profit_margin,
    RANK() OVER (
        ORDER BY
            SUM(Gross_Profit) * 1.0 /
            NULLIF(SUM(Revenue), 0) DESC
    ) AS profitability_rank
FROM sales
GROUP BY Product
ORDER BY profitability_rank;
-- 7. CUSTOMER VALUE ANALYSIS

SELECT
    Customer_ID,
    COUNT(*) AS total_orders,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(SUM(Gross_Profit), 2) AS gross_profit
FROM sales
GROUP BY Customer_ID
ORDER BY total_revenue DESC
LIMIT 10;


-- 8. REPEAT CUSTOMER ANALYSIS

WITH customer_orders AS (
    SELECT
        Customer_ID,
        COUNT(*) AS order_count,
        SUM(Revenue) AS customer_revenue
    FROM sales
    GROUP BY Customer_ID
)
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS total_customers,
    ROUND(SUM(customer_revenue), 2) AS total_revenue
FROM customer_orders
GROUP BY customer_type;


-- 9. CUSTOMER SEGMENTATION

WITH customer_value AS (
    SELECT
        Customer_ID,
        SUM(Revenue) AS total_revenue
    FROM sales
    GROUP BY Customer_ID
)
SELECT
    CASE
        WHEN total_revenue >= 1500 THEN 'High Value'
        WHEN total_revenue >= 700 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_revenue), 2) AS total_revenue
FROM customer_value
GROUP BY customer_segment
ORDER BY total_revenue DESC;
