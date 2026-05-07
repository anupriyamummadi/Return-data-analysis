/*
===========================================================
Project: Return Data Analysis
Module: Sustainability Impact Analysis
Objective: Measure environmental impact of product returns
including CO2 emissions and packaging waste.
===========================================================
*/

-- =========================================================
-- 1. CO2 EMISSIONS IMPACT OF RETURNS
-- =========================================================

-- Analyze total CO2 emissions vs CO2 savings for returned orders
SELECT 
    SUM(co2_emissions) AS total_co2_emissions,
    SUM(co2_saved) AS total_co2_savings
FROM returns_data
WHERE return_status = 'Returned';


-- =========================================================
-- 2. PACKAGING WASTE IMPACT
-- =========================================================

-- Measure packaging waste generated vs waste avoided due to returns
SELECT 
    SUM(packaging_waste) AS total_packaging_waste,
    SUM(waste_avoided) AS total_waste_avoided
FROM returns_data
WHERE return_status = 'Returned';
