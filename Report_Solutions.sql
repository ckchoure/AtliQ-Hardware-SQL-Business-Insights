-- Q1. Provide the list of markets in which customer  "Atliq  Exclusive"  operates its business in the  APAC  region.
select *
from dim_customer
where customer =  "Atliq Exclusive" 
	and region = "APAC";
    
    
    
-- Q2. What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields, 
-- unique_products_2020 
-- unique_products_2021 
-- percentage_chg 

SELECT COUNT(DISTINCT CASE 
        WHEN fiscal_year = 2020 THEN product_code 
    END) AS unique_products_2020,

    COUNT(DISTINCT CASE 
        WHEN fiscal_year = 2021 THEN product_code 
    END) AS unique_products_2021,

    ROUND(
        (
            COUNT(DISTINCT CASE WHEN fiscal_year = 2021 THEN product_code END)
            -
            COUNT(DISTINCT CASE WHEN fiscal_year = 2020 THEN product_code END)
        ) 
        / COUNT(DISTINCT CASE WHEN fiscal_year = 2020 THEN product_code END) * 100,
        2
    ) AS percentage_chg

FROM fact_sales_monthly;



-- Q3. Provide a report with all the unique product counts for each  segment  and 
-- sort them in descending order of product counts. The final output contains 2 fields, 
-- segment 
-- product_count

select segment,
	count(distinct product_code) as product_count
from dim_product
group by segment
order by product_count desc;



-- Q4.    Follow-up: Which segment had the most increase in unique products in 
-- 2021 vs 2020? The final output contains these fields, 

WITH cte AS (
    SELECT
        d.segment,
        COUNT(DISTINCT CASE
            WHEN f.fiscal_year = 2020 THEN d.product_code
        END) AS product_count_2020,
        COUNT(DISTINCT CASE
            WHEN f.fiscal_year = 2021 THEN d.product_code
        END) AS product_count_2021
    FROM dim_product d
    JOIN fact_sales_monthly f
        ON d.product_code = f.product_code
    GROUP BY d.segment
)
SELECT
    segment,
    product_count_2020,
    product_count_2021,
    product_count_2021 - product_count_2020 AS difference
FROM cte
ORDER BY difference DESC;



-- Q5.  Get the products that have the highest and lowest manufacturing costs. 
-- The final output should contain these fields, 
-- 	product_code 
-- 	product 
-- 	manufacturing_cost 

select p.product_code,
	p.product,
    c.manufacturing_cost
from dim_product p
join fact_manufacturing_cost c
	on p.product_code = c.product_code
where c.manufacturing_cost = (
	select max(manufacturing_cost)
    from fact_manufacturing_cost
    )
    or
    c.manufacturing_cost = (
    select min(manufacturing_cost)
    from fact_manufacturing_cost
    )
order by c.manufacturing_cost desc;



-- Q6.  Generate a report which contains the top 5 customers who received an 
-- average high  pre_invoice_discount_pct  for the  fiscal  year 2021  and in the 
-- Indian  market. The final output contains these fields, 
	-- customer_code 
	-- customer 
	-- average_discount_percentage
    
select c.customer_code,
	c.customer,
    round(avg(f.pre_invoice_discount_pct), 4) as average_discount_percentage
from fact_pre_invoice_deductions f
join dim_customer c
	on c.customer_code = f.customer_code
where f.fiscal_year = 2021
    and
    c.market = "India"
group by c.customer_code, 
	c.customer
order by average_discount_percentage  desc
limit 5;



-- Q7.  Get the complete report of the Gross sales amount for the customer  “Atliq 
-- Exclusive”  for each month  .  This analysis helps to  get an idea of low and 
-- high-performing months and take strategic decisions. 
-- The final report contains these columns: 
	-- Month 
	-- Year 
	-- Gross sales Amount
    
select monthname(fs.date) as month,
	year(fs.date),
    round(sum(fs.sold_quantity * fg.gross_price),2) as Gross_sales_Amount
from fact_sales_monthly fs
join fact_gross_price fg
	on fg.product_code = fs.product_code
join dim_customer c
	on c.customer_code = fs.customer_code
where c.customer = "Atliq Exclusive"
group by fs.date, 
	fs.fiscal_year
ORDER BY YEAR(fs.date),
    MONTH(fs.date);
    
    
    
-- Q8.   In which quarter of 2020, got the maximum total_sold_quantity? The final 
-- output contains these fields sorted by the total_sold_quantity, 
	-- Quarter 
    -- total_sold_quantity
    
select  CASE
        WHEN MONTH(date) IN (9, 10, 11) THEN 'Q1'
        WHEN MONTH(date) IN (12, 1, 2) THEN 'Q2'
        WHEN MONTH(date) IN (3, 4, 5) THEN 'Q3'
        WHEN MONTH(date) IN (6, 7, 8) THEN 'Q4'
    END AS Quarter,
	sum(sold_quantity) as total_sold_quantity
from fact_sales_monthly
where fiscal_year = 2020
group by Quarter
order by total_sold_quantity desc;



-- Q9.  Which channel helped to bring more gross sales in the fiscal year 2021 
-- and the percentage of contribution?  The final output  contains these fields, 
	-- channel 
	-- gross_sales_mln 
	-- percentage 
    
WITH cte AS (
    SELECT
        c.channel,
        SUM(f.sold_quantity * g.gross_price) / 1000000 AS gross_sales_mln
    FROM fact_sales_monthly f
    JOIN fact_gross_price g
        ON f.product_code = g.product_code
    JOIN dim_customer c
        ON f.customer_code = c.customer_code
    WHERE f.fiscal_year = 2021
    GROUP BY c.channel
)
SELECT
    channel,
    ROUND(gross_sales_mln, 2) AS gross_sales_mln,
    ROUND(
        gross_sales_mln * 100 /
        (SELECT SUM(gross_sales_mln) FROM cte),
        2
    ) AS percentage
FROM cte
ORDER BY gross_sales_mln DESC;



-- Q10.  Get the Top 3 products in each division that have a high 
-- total_sold_quantity in the fiscal_year 2021? The final output contains these fields, 
	-- division 
	-- product_code

with cte as (
select p.division,
	p.product_code,
    p.product,
    sum(s.sold_quantity) as total_sold_quantity,
    rank() 
		over( partition by p.division order by sum(s.sold_quantity) desc) as rank_order 
from fact_sales_monthly s
join dim_product p
	on p.product_code = s.product_code
where  s.fiscal_year = 2021
group by p.division, 
	p.product_code, 
    p.product)
    
select *
from cte
where rank_order <= 3
order by division, rank_order;