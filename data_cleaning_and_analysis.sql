CREATE DATABASE data_extraction;
USE data_extraction;
SELECT * FROM dirty_data;
SELECT COUNT(*) FROM dirty_data;

-- Gender column not standardized - Convert all entries to capital
SET sql_safe_updates = 0;
UPDATE dirty_data
SET gender = upper(gender);
SELECT * FROM dirty_data;

-- Update as - Male, Female
UPDATE dirty_data
SET gender = concat(upper(substring(gender,1,1)), lower(substring(gender,2)));
SELECT * FROM dirty_data;

-- Remove the dollar sign and convert into decimal
UPDATE dirty_data
SET AmountSpent = REPLACE(AmountSpent, '$', '');
SELECT * FROM dirty_data;

ALTER TABLE dirty_data
MODIFY COLUMN AmountSpent DECIMAL(10,2);

-- Modify Column DataTypes
SELECT * FROM dirty_data;
ALTER TABLE dirty_data
MODIFY COLUMN JoinDate DATE;
ALTER TABLE dirty_data
MODIFY COLUMN LastPurchaseDate DATE;
SELECT * FROM dirty_data;

-- Handle missing values
UPDATE dirty_data
SET Phone = "Unknown"
WHERE Phone = '' OR Phone IS NULL;
SELECT * FROM dirty_data;

UPDATE dirty_data
SET Gender = "Unknown"
WHERE Gender = '' OR Gender IS NULL;

UPDATE dirty_data
SET City = "Unknown"
WHERE City = ' ' OR City IS NULL;
SELECT * FROM dirty_data;

SELECT round(AVG(AmountSpent), 2)
FROM dirty_data;

UPDATE dirty_data
SET AmountSpent = 13834.14
WHERE AmountSpent IS NULL;
SELECT * FROM dirty_data;

-- ============================================
-- Business Questions & Analysis
-- ============================================

-- 1. Revenue by Gender
SELECT Gender, SUM(AmountSpent) AS Revenue
FROM dirty_data
GROUP BY Gender
ORDER BY Revenue DESC;

-- 2. Revenue by Product Category (Overall)
SELECT ProductCategory, SUM(AmountSpent) AS Revenue
FROM dirty_data
GROUP BY ProductCategory
ORDER BY Revenue DESC;

-- 3. Total Revenue by State — ranked highest to lowest
SELECT State, SUM(AmountSpent) Revenue
FROM dirty_data
GROUP BY State
ORDER BY Revenue DESC;

-- 4. Total Revenue from Books category
SELECT SUM(AmountSpent) AS Book_Revenue
FROM dirty_data
WHERE ProductCategory = "Books";

-- 5. Total Revenue from Electronics, broken down by State
SELECT State, SUM(AmountSpent) AS Electronics_Revenue
FROM dirty_data
WHERE ProductCategory = "Electronics"
GROUP BY State
ORDER BY Electronics_Revenue DESC;

-- 6. Average Customer Rating by Category
SELECT ProductCategory, ROUND(AVG(Rating),2) AS AvgRating
FROM dirty_data
GROUP BY ProductCategory
ORDER BY AvgRating DESC;

-- 7. Top 5 Customers by Spend
SELECT Name, State, AmountSpent
FROM dirty_data
ORDER BY AmountSpent DESC
LIMIT 5;

-- 8. Overall Average Order Value
SELECT ROUND(AVG(AmountSpent / TotalPurchases), 2) AS AvgOrderValue
FROM dirty_data;

-- 9. Top 5 Cities by Revenue
SELECT City, SUM(AmountSpent) AS Revenue
FROM dirty_data
GROUP BY City
ORDER BY Revenue DESC
LIMIT 5;

-- 10. Customer Count by State
SELECT State, COUNT(*) AS Customers
FROM dirty_data
GROUP BY State
ORDER BY Customers DESC;

-- 11. Revenue by Last Purchase Year
SELECT YEAR(LastPurchaseDate) AS PurchaseYear, SUM(AmountSpent) AS Revenue
FROM dirty_data
GROUP BY PurchaseYear
ORDER BY PurchaseYear;

-- 12. Customers Spending Above Average
SELECT COUNT(*) AS HighSpenders
FROM dirty_data
WHERE AmountSpent > (SELECT AVG(AmountSpent) FROM dirty_data);

-- 13. Duplicate Customer Records (data quality check)
SELECT Name, Phone, JoinDate, COUNT(*) AS Occurrences
FROM dirty_data
GROUP BY Name, Phone, JoinDate
HAVING COUNT(*) > 1;

-- 14. Revenue Contribution % by Category
SELECT ProductCategory,
       ROUND(SUM(AmountSpent)*100 / (SELECT SUM(AmountSpent) FROM dirty_data), 2) AS RevenuePct
FROM dirty_data
GROUP BY ProductCategory
ORDER BY RevenuePct DESC;
