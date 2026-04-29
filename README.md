🛒 Retail Sales Analysis (SQL Project)

📌 Project Overview

This project focuses on analyzing retail sales data using SQL (MySQL). It demonstrates the complete workflow of a data analyst:

* Database creation
* Data cleaning
* Exploratory Data Analysis (EDA)
* Business problem solving using SQL

The objective is to extract meaningful insights from transactional sales data to support business decisions.

🧰 Tools & Technologies

* **SQL (MySQL)**
Database: `sql_project_p2`

🗂️ Database Schema

**Table: retail_sales**

| Column Name     | Data Type | Description             |
| --------------- | --------- | ----------------------- |
| transactions_id | INT (PK)  | Unique transaction ID   |
| sale_date       | DATE      | Date of sale            |
| sale_time       | TIME      | Time of sale            |
| customer_id     | INT       | Customer ID             |
| gender          | VARCHAR   | Customer gender         |
| age             | INT       | Customer age            |
| category        | VARCHAR   | Product category        |
| quantity        | INT       | Quantity sold           |
| price_per_unit  | FLOAT     | Price per unit          |
| cogs            | FLOAT     | Cost of goods sold      |
| total_sales     | FLOAT     | Total transaction value |

🧹 Data Cleaning

* Checked for null values across all columns
* Removed incomplete records using `DELETE`
* Validated dataset integrity before analysis

🔍 Exploratory Data Analysis (EDA)

Performed initial analysis to understand dataset:

* Total number of transactions
* Unique customers
* Unique categories
* Data validation checks

📊 Business Questions & My Analysis

1. Sales on a Specific Date

```sql
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

**My Analysis:**
This query helps identify all transactions that occurred on a specific date. It is useful for analyzing daily sales performance and detecting any unusual spikes or drops in sales activity.

---

2. Clothing Transactions in November 2022

```sql
SELECT *
FROM retail_sales
WHERE 
    LOWER(category) = 'clothing'
    AND sale_date >= '2022-11-01'
    AND sale_date < '2022-12-01'
    AND quantity >= 4;
```

**My Analysis:**
This analysis focuses on high-volume clothing sales during November. It helps identify bulk purchases and understand demand trends for clothing products during that period.

3. Total Revenue by Category

```sql
SELECT 
    category,
    SUM(total_sales) AS total_revenue
FROM retail_sales
GROUP BY category;
```

**My Analysis:**
This query shows how much revenue each category generates. It helps identify top-performing categories and supports decisions related to inventory and marketing strategies.

4. Average Age of Beauty Customers

```sql
SELECT AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

**My Analysis:**
This helps understand the average age group of customers purchasing beauty products. It is useful for targeted marketing and customer segmentation.

5. High-Value Transactions

```sql
SELECT *
FROM retail_sales
WHERE total_sales > 1000;
```

**My Analysis:**
This identifies premium transactions where customers spend more than 1000. It helps in recognizing high-value customers and opportunities for upselling.

6. Transactions by Gender & Category

```sql
SELECT 
    gender,
    category,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY gender, category;
```

**My Analysis:**
This analysis shows purchasing patterns across genders for different categories. It helps businesses understand customer preferences and tailor marketing campaigns accordingly.

7. Best Selling Month per Year

```sql
SELECT *
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sales) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sales) DESC
        ) AS rnk
    FROM retail_sales
    GROUP BY year, month
) t
WHERE rnk = 1;
```

**My Analysis:**
This identifies the best-performing month in each year based on average sales. It helps detect seasonal trends and plan promotions during peak periods.

8. Top 5 Customers by Revenue

```sql
SELECT 
    customer_id,
    SUM(total_sales) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;
```

**My Analysis:**
This highlights the top 5 customers contributing the most revenue. It helps identify loyal or high-value customers for retention strategies.

9. Unique Customers per Category

```sql
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

**My Analysis:**
This shows how many unique customers are purchasing from each category. It helps measure category popularity and customer reach.

10. Sales by Time of Day (Shift Analysis)

```sql
SELECT 
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift;
```

**My Analysis:**
This analysis divides sales into time-based shifts to identify peak shopping hours. It helps optimize staffing and promotional timing.

11. Total Revenue

```sql
SELECT SUM(total_sales) AS total_revenue
FROM retail_sales;
```

**My Analysis:**
This provides the overall revenue generated by the business. It is a key metric for evaluating overall performance.

12. Total Orders

```sql
SELECT COUNT(*) AS total_orders
FROM retail_sales;
```

**My Analysis:**
This shows the total number of transactions, helping measure business activity and customer engagement.

13. Min & Max Sales

```sql
SELECT 
    MIN(total_sales) AS min_sale,
    MAX(total_sales) AS max_sale
FROM retail_sales;
```

**My Analysis:**
This identifies the smallest and largest transaction values. It helps understand the range of customer spending behavior.

14. Orders per Category

```sql
SELECT 
    category,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category
ORDER BY total_orders DESC;
```

**My Analysis:**
This shows which categories receive the most orders. It helps identify high-demand products and supports inventory planning.

📊 Business Insights

* Clothing category contributes significantly to overall revenue
* Evening time shows the highest number of transactions
* A small group of customers generates a large portion of revenue
* High-value transactions (>1000) indicate premium purchasing behavior
* Sales patterns vary across months, suggesting seasonal demand

📌 Conclusion

This project demonstrates how SQL can be effectively used to:

* Clean and prepare data
* Perform exploratory analysis
* Solve business problems
* Generate actionable insights

🚀 Future Improvements

* Build dashboard using Power BI / Tableau
* Perform customer segmentation
* Add trend forecasting
* Optimize queries using indexing

👤 Author

RAKSHITHA G
Aspiring Data Analyst  
**Retail Sales SQL Project**
Built as part of my data analytics learning journey.
