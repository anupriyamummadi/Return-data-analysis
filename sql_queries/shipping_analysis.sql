/*
===========================================================
Project: Return Data Analysis
Module: Logistics, Shipping & Customer Behavior Analysis
Objective: Analyze shipping impact and customer-driven
return behavior patterns.
===========================================================
*/

-- =========================================================
-- 1. SHIPPING METHOD EXPLORATION
-- =========================================================

-- Identify distinct shipping methods used
SELECT DISTINCT shipping_method
FROM returns_data;


-- =========================================================
-- 2. SHIPPING METHOD IMPACT ON RETURNS
-- =========================================================

-- Analyze returns by shipping method
SELECT 
    shipping_method,
    SUM(CASE WHEN return_status = 'Returned' THEN 1 ELSE 0 END) AS total_returns
FROM returns_data
GROUP BY shipping_method
ORDER BY total_returns DESC;


-- =========================================================
-- 3. RETURN TIMING BEHAVIOR
-- =========================================================

-- Average return time by return reason
SELECT 
    return_reason,
    AVG(days_to_return) AS avg_return_time
FROM returns_data
WHERE return_status = 'Returned'
GROUP BY return_reason
ORDER BY avg_return_time DESC;


-- =========================================================
-- 4. CUSTOMER BEHAVIOR ANALYSIS (AGE GROUP)
-- =========================================================

-- Define age groups and calculate return rate
WITH cte_age_group AS (
    SELECT 
        CASE 
            WHEN age <= 25 THEN 'Gen Z'
            WHEN age BETWEEN 26 AND 40 THEN 'Young Adult'
            ELSE 'Adult'
        END AS age_group,
        CASE 
            WHEN return_status = 'Returned' THEN 1 
            ELSE 0 
        END AS is_returned
    FROM returns_data
)

SELECT 
    age_group,
    ROUND(SUM(is_returned) * 100.0 / COUNT(*), 2) AS return_rate_percentage
FROM cte_age_group
GROUP BY age_group
ORDER BY return_rate_percentage DESC;


-- =========================================================
-- 5. GENDER-BASED RETURN ANALYSIS
-- =========================================================

-- Analyze return behavior by gender
SELECT 
    gender,
    ROUND(SUM(CASE WHEN return_status = 'Returned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
    AS return_rate_percentage
FROM returns_data
GROUP BY gender
ORDER BY return_rate_percentage DESC;
