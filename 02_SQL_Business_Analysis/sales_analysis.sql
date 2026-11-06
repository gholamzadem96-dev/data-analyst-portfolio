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
