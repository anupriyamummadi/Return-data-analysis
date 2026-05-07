/*
===========================================================
Project: Return Data Analysis
Module: Pricing & Discount Analysis
Objective: Understand how pricing and discount strategies
influence product return behavior.
===========================================================
*/

-- =========================================================
-- 1. IMPACT OF DISCOUNTS ON RETURNS
-- =========================================================

-- Analyze whether discount levels influence return rate
WITH cte_discount_analysis AS (
    SELECT 
        CASE 
            WHEN discount_applied = 0 THEN 'No Discount'
            WHEN discount_applied BETWEEN 10 AND 15 THEN 'Low Discount'
            WHEN discount_applied BETWEEN 16 AND 25 THEN 'Medium Discount'
            ELSE 'High Discount'
        END AS discount_bin,
        
        SUM(CASE WHEN return_status = 'Returned' THEN 1 ELSE 0 END) AS total_returns,
        COUNT(*) AS total_orders

    FROM returns_data
    GROUP BY 
        CASE 
            WHEN discount_applied = 0 THEN 'No Discount'
            WHEN discount_applied BETWEEN 10 AND 15 THEN 'Low Discount'
            WHEN discount_applied BETWEEN 16 AND 25 THEN 'Medium Discount'
            ELSE 'High Discount'
        END
)

SELECT 
    discount_bin,
    ROUND(total_returns * 100.0 / total_orders, 2) AS return_rate_percentage
FROM cte_discount_analysis
ORDER BY return_rate_percentage DESC;


-- =========================================================
-- 2. PRODUCT PRICE VS RETURNS
-- =========================================================

-- Analyze return behavior across product price segments
WITH cte_price_analysis AS (
    SELECT 
        CASE 
            WHEN product_price BETWEEN 300 AND 500 THEN 'Low Price'
            WHEN product_price BETWEEN 501 AND 1000 THEN 'Medium Price'
            ELSE 'High Price'
        END AS price_bin,

        SUM(CASE WHEN return_status = 'Returned' THEN 1 ELSE 0 END) AS total_returns,
        COUNT(*) AS total_orders

    FROM returns_data
    GROUP BY 
        CASE 
            WHEN product_price BETWEEN 300 AND 500 THEN 'Low Price'
            WHEN product_price BETWEEN 501 AND 1000 THEN 'Medium Price'
            ELSE 'High Price'
        END
)

SELECT 
    price_bin,
    ROUND(total_returns * 100.0 / total_orders, 2) AS return_rate_percentage
FROM cte_price_analysis
ORDER BY return_rate_percentage DESC;
