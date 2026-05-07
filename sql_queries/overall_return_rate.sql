/*
===========================================================
Project: Return Data Analysis
Description: Exploratory analysis of returns dataset to
understand return behavior, speed, and financial impact.
===========================================================
*/

-- =========================================================
-- 1. DATA UNDERSTANDING
-- =========================================================

-- Load dataset
SELECT * 
FROM returns_data;

-- Preview sample records
SELECT TOP 10 * 
FROM returns_data;


-- =========================================================
-- 2. DATA QUALITY CHECKS
-- =========================================================

-- Check missing values in key column (Waste_Avoided)
SELECT *
FROM returns_data
WHERE Waste_Avoided IS NULL;


-- =========================================================
-- 3. FEATURE ENGINEERING
-- =========================================================

-- Categorize return speed based on return duration
SELECT *,
    CASE 
        WHEN Days_to_Return <= 15 THEN 'Fast Return'
        WHEN Days_to_Return BETWEEN 16 AND 31 THEN 'Normal Return'
        ELSE 'Late Return'
    END AS return_speed
FROM returns_data;


-- =========================================================
-- 4. RETURN RATE ANALYSIS
-- =========================================================

-- Calculate overall return rate
WITH cte_overall_return AS (
    SELECT 
        SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,
        COUNT(*) AS total_orders
    FROM returns_data
)
SELECT 
    ROUND(returned_orders * 100.0 / total_orders, 2) AS return_rate_percentage
FROM cte_overall_return;


-- =========================================================
-- 5. FINANCIAL IMPACT ANALYSIS
-- =========================================================

-- Total revenue impact from returned orders
SELECT 
    ROUND(SUM(profit_loss), 2) AS total_profit_impact
FROM returns_data
WHERE Return_Status = 'Returned';


-- =========================================================
-- 6. RETURN COST ANALYSIS
-- =========================================================

-- Total and average return cost
SELECT 
    ROUND(SUM(return_cost), 2) AS total_return_cost,
    ROUND(AVG(return_cost), 2) AS avg_return_cost
FROM returns_data
WHERE Return_Status = 'Returned';
