---CREATE TABLE---
create table retail_sales(
transactions_id INT Primary key,
sale_date	date,
sale_time	time,
customer_id int,
gender	varchar(15),
age	int,
category varchar(15),	
quantiy	int,
price_per_unit	float,
cogs	float,
total_sale float

);
-- display the table---
select * from retail_sales;

--COUNT THE ROWS--
select count(*) from retail_sales;


-------DATA CLEANING-----
---display null values--
select * from retail_sales
WHERE transactions_id is null
or
sale_date is NUll 
or 
sale_time is null
or 
customer_id is null
or 
gender is null
or 
age is null
or 
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null


----delete null values---
DELETE From retail_sales
WHERE transactions_id is null
or
sale_date is NUll 
or 
sale_time is null
or 
customer_id is null
or 
gender is null
or 
age is null
or 
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null

------DATA EXPLORATION----
--HOW MANY SALES WE HAVE?--
SELECT COUNT(*) AS total_sale From retail_sales

--how many unique customers we have?--

SELECT COUNT(distinct customer_id) AS total_sale From retail_sales


SELECT distinct category From retail_sales


----Data analysis and business key problems and answers--

--1Q Write a SQL query to retrieve all columns for sales made on '2022-11-05:--
select * from retail_sales 
Where sale_date ='2022-11-05';


--2QWrite a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:--
SELECT *FROM retail_sales
where
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
WHERE 
    quantiy >= 4
--3QWrite a SQL query to calculate the total sales (total_sale) for each category.:--

select 
category,
sum(total_sale)as net_sale,
count(*)as total_orders
from retail_sales
Group by 1

--4QWrite a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:--

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'


--5OWrite a SQL query to find all transactions where the total_sale is greater than 1000.:--
select * from retail_sales
where total_sale >1000

--6QWrite a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:--
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER by 1

--7QWrite a SQL query to calculate the average sale for each month. Find out best selling month in each year:--   
SELECT 
     year,
	 month,
	 avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

--8Q**Write a SQL query to find the top 5 customers based on the highest total sales **:--
select
customer_id,
sum(total_sale)as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

--9QWrite a SQL query to find the number of unique customers who purchased items from each category.:--

select
category,
COUNT(DISTINCT customer_id) as cnt_unique_cs
from retail_sales
group by category

--10QWrite a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):--
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
GROUP BY shift
--END PROJECT--