/*
===========================================================
Project: Return Data Analysis
Module: Product-Level Root Cause Analysis
Objective: Identify return patterns by product category
and analyze key return reasons.
===========================================================
*/

-- =========================================================
-- 1. PRODUCT CATEGORY EXPLORATION
-- =========================================================

-- Identify distinct product categories in dataset
SELECT DISTINCT product_category
FROM returns_data;


-- =========================================================
-- 2. RETURN RATE BY PRODUCT CATEGORY
-- =========================================================

-- Calculate return rate per product category
WITH cte_product_cat_returns AS (
    SELECT 
        product_category,
        SUM(CASE WHEN return_status = 'Returned' THEN 1 ELSE 0 END) AS total_returns,
        COUNT(*) AS total_orders
    FROM returns_data
    GROUP BY product_category
)

SELECT 
    product_category,
    ROUND(total_returns * 100.0 / total_orders, 2) AS return_rate_percentage
FROM cte_product_cat_returns
ORDER BY return_rate_percentage DESC;


-- =========================================================
-- 3. RETURN REASONS ANALYSIS
-- =========================================================

-- Explore distinct return reasons
SELECT DISTINCT return_reason
FROM returns_data;


-- =========================================================
-- 4. TOP RETURN REASONS
-- =========================================================

-- Identify most common reasons for returns
SELECT 
    return_reason,
    COUNT(*) AS total_returns
FROM returns_data
WHERE return_status = 'Returned'
GROUP BY return_reason
ORDER BY total_returns DESC;
