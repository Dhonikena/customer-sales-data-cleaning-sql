# Customer Sales Data Cleaning & Analysis (SQL)

## 📌 Overview
This project cleans a messy retail customer dataset (`dirty_data`) using **MySQL** and runs business questions on it. It demonstrates end-to-end SQL data cleaning — standardization, type correction, missing-value handling — followed by aggregation-based analysis.

## 🗂 Dataset
**Table:** 'dirty_customer_sales.csv' or `dirty_data`
**Key columns:**
- `Gender` — inconsistent casing (e.g., MALE, female, Male)
- `AmountSpent` — stored as text with `$` symbols
- `JoinDate`, `LastPurchaseDate` — inconsistent date formats
- `Phone`, `City` — missing/blank values
- `State`, `ProductCategory`, `Rating`, `TotalPurchases` — used for analysis

## 🧹 Data Cleaning Steps
1. **Standardized Gender** — converted to uppercase, then formatted to proper case (`Male`, `Female`)
2. **Cleaned AmountSpent** — removed `$` symbol and cast column to `DECIMAL(10,2)`
3. **Fixed data types** — converted `JoinDate` and `LastPurchaseDate` to `DATE`
4. **Handled missing values:**
   - `Phone` → `"Unknown"`
   - `Gender` → `"Unknown"`
   - `City` → `"Unknown"`
   - `AmountSpent` → filled with dataset average (₹13,834.14)

## 💡 Business Questions & Insights
| # | Question | Key Insight |
|---|----------|-------------|
| 1 | Revenue by Gender | Male ₹7,91,202.82 vs Female ₹5,51,729.21 |
| 2 | Revenue by Product Category | Electronics leads (₹7,54,007.25); Books lowest (₹61,154.50) |
| 3 | Total Revenue by State | Maharashtra tops at ₹3,12,843.82, then Uttar Pradesh ₹2,54,943.82 |
| 4 | Total Revenue from Books | ₹61,154.50 |
| 5 | Electronics Revenue by State | Maharashtra ₹1,98,302.00, then Uttar Pradesh ₹1,52,101.50 |
| 6 | Avg Rating by Category | Electronics lowest (2.83) despite highest revenue — satisfaction gap |
| 7 | Top 5 Customers by Spend | Rachel Evans tops at ₹45,000 |
| 8 | Overall Avg Order Value | ₹1,251.51 per purchase |
| 9 | Top 5 Cities by Revenue | Nashik leads with ₹77,000 |
| 10 | Customer Count by State | Maharashtra has the most customers (23) |
| 11 | Revenue by Last Purchase Year | 2024 revenue (₹6,25,626.53) nearly double 2023 |
| 12 | % Customers Above Avg Spend | 36% of customers spend above the ₹13,539.32 average |
| 13 | Duplicate Records Check | 5 duplicate customer pairs found (10 rows) — flagged for cleanup |
| 14 | Revenue Contribution % by Category | Electronics alone = 55.69% of total revenue |

## 🛠 Tools Used
- MySQL (DDL, DML, aggregate functions, string functions, subqueries)

## ▶️ How to Run
```sql
CREATE DATABASE data_extraction;
USE data_extraction;
-- Import dirty_data table here
-- Run data_cleaning_and_analysis.sql sequentially
```

## 📁 Repository Structure
```
├── data_cleaning_and_analysis.sql   -- Full cleaning + business questions
└── README.md
```

## 🔑 Key Learnings
- Practical use of `UPDATE`, `REPLACE`, `SUBSTRING`, `CONCAT` for text standardization
- Safe handling of `sql_safe_updates` for bulk updates
- Type casting with `ALTER TABLE ... MODIFY COLUMN`
- Business-driven aggregation using `GROUP BY`, subqueries, and window-style filtering
- Identifying data quality issues (duplicates) via `GROUP BY ... HAVING`

## 👤 Author
**Rajasri**
Data Analyst | SQL · Python · Power BI · Tableau
