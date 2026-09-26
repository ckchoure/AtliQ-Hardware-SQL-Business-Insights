# AtliQ Hardware SQL Business Insights

## 📌 Project Overview

This project is based on the **AtliQ Hardware Consumer Goods Ad-hoc Insights SQL Challenge**.

The objective is to analyze sales, products, customers, manufacturing costs, discounts, channels, and other business data using **MySQL** and convert raw data into meaningful business insights.

The project focuses on solving **10 real-world business questions** using SQL concepts such as joins, aggregations, CTEs, window functions, ranking, date analysis, and percentage calculations.

## 👨‍💻 Author

**Chain Kumar Choure**

Data Analytics / Data Analyst Aspirant

**Skills:** SQL, Excel, Power BI, Python, Pandas

- GitHub: https://github.com/ckchoure
- Portfolio: https://ckchoure.github.io/My-Resume/

## 🛠️ Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| MySQL | Data analysis and SQL queries |
| MySQL Workbench | Query development and execution |
| SQL | Business analysis |
| Excel | Data review and validation |
| Power BI | Data visualization |
| GitHub | Project documentation |

## 📂 Project Structure

```text
AtliQ-Hardware-SQL-Business-Insights/
│
├── Dataset/
│   └── AtliQ Hardware dataset
│
├── SQL/
│   ├── Report_Solutions.sql
│
├── Report/
│   └── Chain_Kumar_Choure_AtliQ_Hardware_Final_Report.pdf
│
│
└── README.md
```

# 📊 Business Questions

## 1. APAC Markets for AtliQ Exclusive

**Question:** What are the markets in the APAC region where AtliQ Exclusive operates?

**Result:** The analysis identifies **8 APAC markets**.

**SQL concepts:** `DISTINCT`, `JOIN`, filtering.

---

## 2. Unique Product Growth

**Question:** What is the percentage increase in unique products in 2021 compared with 2020?

| Fiscal Year | Unique Products |
|---|---:|
| FY2020 | 245 |
| FY2021 | 334 |

**Increase:** 89 products

**Percentage Increase:** **36.33%**

**SQL concepts:** `COUNT(DISTINCT)`, `CASE`, aggregation, percentage calculation.

---

## 3. Unique Products by Segment

| Segment | Unique Products |
|---|---:|
| Notebook | 129 |
| Accessories | 116 |
| Peripherals | 84 |
| Desktop | 32 |
| Storage | 27 |
| Networking | 9 |

**SQL concepts:** `GROUP BY`, `COUNT(DISTINCT)`, `ORDER BY`.

---

## 4. Segment with the Largest Increase

| Segment | FY2020 | FY2021 | Increase |
|---|---:|---:|---:|
| Accessories | 69 | 103 | 34 |
| Peripherals | 59 | 75 | 16 |
| Notebook | 92 | 108 | 16 |
| Desktop | 7 | 22 | 15 |
| Storage | 12 | 17 | 5 |
| Networking | 6 | 9 | 3 |

**Largest increase:** Accessories, with an increase of **34 products**.

---

## 5. Highest and Lowest Manufacturing Cost

### Highest Manufacturing Cost

| Product | Manufacturing Cost |
|---|---:|
| AQ Home Allin1 Gen2 | 240.54 |

### Lowest Manufacturing Cost

| Product | Manufacturing Cost |
|---|---:|
| AQ Master wired x1 Ms | 0.89 |

**SQL concepts:** `JOIN`, `ORDER BY`, `LIMIT`, `UNION`.

---

## 6. Top 5 Customers by Average Pre-Invoice Discount

**FY2021, India**

| Rank | Customer | Average Discount |
|---:|---|---:|
| 1 | Flipkart | 30.88% |
| 2 | Viveks | 30.38% |
| 3 | Ezone | 30.28% |
| 4 | Croma | 30.25% |
| 5 | Amazon | 29.33% |

**SQL concepts:** `JOIN`, `GROUP BY`, `AVG()`, `ORDER BY`, `LIMIT`.

---

## 7. Monthly Gross Sales of AtliQ Exclusive

Gross sales were calculated using:

```text
Gross Sales = Sold Quantity × Gross Price
```

The analysis covers the available monthly data from **September 2019 to August 2021**.

**SQL concepts:** `YEAR()`, `MONTH()`, `MONTHNAME()`, `SUM()`, `JOIN`, `GROUP BY`.

---

## 8. Fiscal Quarter with the Highest Sales Quantity

AtliQ Hardware's fiscal year starts in **September**.

| Quarter | Total Sold Quantity |
|---|---:|
| Q1 | 7.01M |
| Q2 | 6.65M |
| Q4 | 5.04M |
| Q3 | 2.08M |

Fiscal mapping:

- Q1 = September to November
- Q2 = December to February
- Q3 = March to May
- Q4 = June to August

---

## 9. Gross Sales by Channel

**FY2021**

| Channel | Gross Sales Contribution |
|---|---:|
| Retailer | 73.23% |
| Direct | 15.47% |
| Distributor | 11.30% |

**SQL concepts:** CTE, `SUM()`, `JOIN`, `GROUP BY`, percentage calculation.

---

## 10. Top 3 Products by Division

The analysis ranks products within each division based on total sold quantity in FY2021.

```sql
RANK() OVER (
    PARTITION BY p.division
    ORDER BY SUM(s.sold_quantity) DESC
)
```

**Divisions analyzed:**

- N & S
- P & A
- PC

**SQL concepts:** CTE, `JOIN`, `GROUP BY`, window functions, `RANK()`, `PARTITION BY`.

# 🧠 SQL Concepts Practiced

- SELECT
- WHERE
- DISTINCT
- GROUP BY
- ORDER BY
- HAVING
- LIMIT
- JOIN
- UNION
- CASE WHEN
- SUM()
- COUNT()
- AVG()
- MIN()
- MAX()
- YEAR()
- MONTH()
- MONTHNAME()
- Common Table Expressions (CTEs)
- Window Functions
- RANK()
- PARTITION BY
- Percentage calculations
- Business KPI analysis

# 📈 Key Business Insights

This project provides insights into:

- Regional market presence
- Product portfolio growth
- Segment-level product expansion
- Manufacturing cost variation
- Customer discount patterns
- Monthly sales trends
- Fiscal-quarter sales performance
- Sales channel contribution
- Division-wise product performance

# 📄 Project Report

The `Report/` folder contains the detailed business report with:

- KPI summaries
- SQL output tables
- Charts
- Business insights
- Visual analysis

# 🚀 How to Run

### 1. Install MySQL

Install **MySQL Server** and **MySQL Workbench**.

### 2. Import the database

Import the AtliQ Hardware database into MySQL.

### 3. Select the database

```sql
USE atliq_hardware_db;
```

### 4. Run the SQL files

Open the SQL files from the `SQL/` folder in MySQL Workbench and execute the queries.

### 5. Review the results

Compare the query outputs with the business questions and use the results for further analysis or visualization.

# 🎯 Project Objective

The main objective of this project is to demonstrate how SQL can be used to solve real-world business questions and convert raw transactional data into meaningful business insights.

This project is part of my **Data Analytics learning journey** and demonstrates practical knowledge of SQL and business-oriented data analysis.

---

## ⭐ Thank You

Thank you for visiting this project.
