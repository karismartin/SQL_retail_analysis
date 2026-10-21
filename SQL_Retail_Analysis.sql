-- create table

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

Select * from retail_sales;

SELECT COUNT(*)
FROM retail_sales;


SELECT * 
FROM retail_sales
where transactions_id is null;


SELECT * 
FROM retail_sales
where sale_date is null;

SELECT * 
FROM retail_sales
where  is null;

Select *
from retail_sales
where transactions_id is null or
sale_date is null or
sale_time is null or
customer_id	is null or 
gender is null or
age is null or
category is null or
quantity is null or
price_per_unit is null or 
cogs is null or 
total_sale is null ;


Delete from retail_sales
where
transactions_id is null or
sale_date is null or
sale_time is null or
customer_id	is null or 
gender is null or
age is null or
category is null or
quantity is null or
price_per_unit is null or 
cogs is null or 
total_sale is null ;


---Data Exploration

Select COUNT(*) from retail_sales;


SELECT COUNT(DISTINCT customer_id)
FROM retail_sales;



-- Data Analysis
Select * from retail_sales;
--Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
Select *
from retail_sales
where sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 
--'Clothing' and the quantity sold is equal or more than 4 in the month of Nov-2022**:

Select *
from retail_sales
where category = 'Clothing' 
AND quantity >=4
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

--Write a SQL query to calculate the total sales (total_sale) for each category
Select category, SUM(total_sale)
FROM retail_sales
GROUP BY category;

--Write a SQL query to find the average age of customers who purchased 
--items from the 'Beauty' category.**:
SELECT Round(AVG(age))
FROM retail_sales
WHERE category = 'Beauty';

--Write a SQL query to find all transactions
-- where the total_sale is greater than 1000

SELECT *
FROM retail_sales
WHERE total_sale > 1000;

--Write a SQL query to find the total number of transactions (transaction_id)
--made by each gender in each category

SELECT category, gender, COUNT(*)
FROM retail_sales
GROUP BY category, gender
ORDER BY category;


--Write a SQL query to calculate the average sale for each month.
--Find out best selling month in each year
SELECT *
FROM
(
SELECT EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1,2
) as T1
WHERE rank = 1;


--Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id, SUM(total_sale) as total
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category, COUNT(DISTINCT customer_id)
from retail_sales
GROUP BY 1;

--Write a SQL query to create each shift and number of orders 
WITH Hourly_sales AS
(
	SELECT *,
	   CASE WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	   		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
	
	   END as shift
	
	FROM retail_sales
)
SELECT shift, COUNT(*) as total_orders
FROM Hourly_sales
GROUP BY shift
ORDER BY total_orders DESC;

--END--