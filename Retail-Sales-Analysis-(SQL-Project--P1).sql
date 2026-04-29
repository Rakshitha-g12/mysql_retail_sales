-- SQL Retail Sales Analysis - P1(Database Creation)
Create Database sql_project_p2;

USE sql_project_p2;

-- Creating Table
create table retail_sales
(
	transactions_id	INT PRIMARY KEY,
    sale_date DATE,
	sale_time TIME,
	customer_id	INT,
    gender VARCHAR(10),
	age INT,
	category VARCHAR(14),
	quantity	INT,
    price_per_unit FLOAT,
	cogs FLOAT,
    total_sales FLOAT
);

select * from retail_sales;

SELECT * FROM retail_sales
LIMIT 10;

-- DATA CLEANING
SELECT 
     count(*)
FROM retail_sales;

SELECT * FROM retail_sales
where transactions_id IS NULL;

SELECT * 
FROM retail_sales
where sale_date IS NULL;

SELECT * FROM retail_sales
where sale_time IS NULL;

SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
      OR 
      sale_date IS NULL
	  OR
      sale_time IS NULL
	  OR
      gender IS NULL
      OR
      category IS NULL
      OR
      quantiy IS NULL
      OR
      cogs IS NULL
      OR
      total_sales IS NULL;
      
DELETE FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR cogs IS NULL
   OR total_sales IS NULL; 
   
--  Data Exploring

-- HOW MANY SALES WE HAVE
SELECT COUNT(*) AS TOTAL_SALES FROM RETAIL_SALES;

-- HOW MANY CUSTOMERS WE HAVE
SELECT COUNT(*) AS customer_id FROM RETAIL_SALES;

-- HOW MANY unique CUSTOMERS WE HAVE
SELECT COUNT(distinct(customer_id)) AS TOTAL_SALES FROM RETAIL_SALES;

-- HOW MANY UNIQUE CATEGORY WE HAVE
SELECT COUNT(DISTINCT category) AS TOTAL_SALES 
FROM retail_sales;
SELECT DISTINCT category
FROM retail_sales;

SELECT * FROM retail_sales;

-- Data Analysis and Business key problems and Answers
-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales
where sale_date =  '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Method 1
SELECT 
      category,
      sum(quantity)
FROM retail_sales
WHERE category ='clothing' 
group by 'clothing'
having  sum(quantity) > 4;
-- Method 2
SELECT *
 FROM retail_sales
 WHERE 
      category ='clothing'
      AND 
      date_format(sale_date,"%Y-%m") = '2022-11'
      AND
      QUANTITY >= 4;
      
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT sum(total_sales) FROM retail_sales;
SELECT category,
sum(total_sales) as total_sales_category
FROM retail_sales
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT avg(age) FROM retail_sales;
SELECT avg(age) 
FROM retail_sales
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
where total_sales > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    gender,
    category,
    COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY gender, category
order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
    year,
    month,
    avg_sale
FROM 
(
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sales) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date) 
            ORDER BY AVG(total_sales) DESC
        ) AS rnk
    FROM retail_sales
    GROUP BY year, month
) AS t1
WHERE rnk = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sales) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;

-- Q.11 Give Total Revenue of the Business
SELECT SUM(total_sales) AS total_revenue
FROM retail_sales;

-- Q.12 Give Total Number of Orders
SELECT COUNT(*) AS total_orders
FROM retail_sales;

-- Q.13 Give minimum and maximum sales
SELECT 
    MIN(total_sales) AS min_sale,
    MAX(total_sales) AS max_sale
FROM retail_sales;

-- Q.14 Number of Orders per Category
SELECT 
    category,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category
ORDER BY total_orders DESC;
-- end of the project