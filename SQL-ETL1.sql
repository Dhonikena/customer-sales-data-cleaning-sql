CREATE DATABASE data_extraction;
USE data_extraction;

SELECT * FROM dirty_data;
SELECT COUNT(*) FROM dirty_data;


-- Gender column not satandardized, - Convert all entries in capital

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
WHERE AmountSpent IS NULL ;

SELECT * FROM dirty_data;


-- Total Revenue by State

SELECT State, SUM(AmountSpent) Revenue
FROM dirty_data
GROUP BY State
ORDER BY Revenue DESC;

-- Total Revenue from Books

SELECT SUM(AmountSpent) AS Book_Revenue
FROM dirty_data
WHERE ProductCategory = "Books";

-- Total Revenue from Electronics by Each State

SELECT State, SUM(AmountSpent) AS Electronics_Revenue
FROM dirty_data
WHERE ProductCategory = "Electronics"
GROUP BY State
ORDER BY Electronics_Revenue DESC;





