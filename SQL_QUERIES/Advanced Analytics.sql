--Customer Lifetime Value analysis (top 20 customers)
SELECT
	s.customer_id as Customers,
	SUM(s.units * p.unit_price)  AS Amount_spent,
	COUNT(DISTINCT s.order_id) AS total_orders,
    MIN(s.order_date) AS first_order_date,
    MAX(s.order_date) AS last_order_date
FROM sales_data AS s
LEFT JOIN products AS p
	ON s.Product_id = p.Product_id
GROUP BY 1	
ORDER BY 2 DESC
LIMIT 20

--Product profitability ranking with margins
SELECT
	p.product_id as Product_id,
	p.product_name as Product_name,
	SUM(s.units * p.unit_price)  AS Total_sales,
	SUM(s.units * p.unit_cost)  AS Total_cost,
	SUM(s.units * (p.unit_price - p.unit_cost)) AS Total_profit,
	TO_CHAR(CAST(
	(SUM(s.units * (p.unit_price - p.unit_cost))
	/SUM(s.units * p.unit_price) * 100) as DECIMAL(4,2)), 'fm99D00%')AS profit_margin
FROM sales_data AS s
LEFT JOIN products AS p
	ON s.Product_id = p.Product_id
GROUP BY 1	
ORDER BY (SUM(s.units * (p.unit_price - p.unit_cost))
	/SUM(s.units * p.unit_price) * 100) DESC

--Factory performance comparison(using CTE)
WITH factory_base_data AS(
	SELECT
		f.factory,
		p.factory_id,
		p.product_id,
		s.order_date,
		EXTRACT(YEAR FROM s.order_date) AS year,
		TO_CHAR(s.order_date, 'MM') as month,
		p.product_name,
		s.units as Units,
		(s.units * p.unit_price)  AS Total_sales,
		(s.units * p.unit_cost)  AS Total_cost,
		(s.units * (p.unit_price - p.unit_cost)) AS Total_profit
	FROM sales_data AS s
	LEFT JOIN products AS p 
		ON s.Product_id = p.Product_id
	LEFT JOIN factories AS f 
		ON f.factoryid = p.factory_id)

--Profitability Analysis
SELECT 
	factory, 
	factory_id, 
	SUM(units) AS Total_units, 
	SUM(total_sales) AS total_sales, 
	SUM(total_profit) AS total_profit,
	TO_CHAR(
			CAST(
				(SUM(Total_profit)/NULLIF(SUM(total_sales), 0) * 100) AS DECIMAL(4,2)
					), 'fm99D00%') AS profit_margin,
	RANK() OVER (ORDER BY SUM(total_profit) DESC) AS profit_rank
FROM factory_base_data
GROUP BY 1,2

-- Which factory produces the most revenue per product?
SELECT
	factory_id,
	factory,
	product_id,
	product_name,
	SUM(Total_sales) as Revenue_per_product
FROM factory_base_data
GROUP BY 1,2,3,4
ORDER BY 5 DESC


---Factory sales trends over years
SELECT
	factory_id,
	factory,
	year,
	month,
	SUM(units) as Total_Units_sold,
	SUM(Total_sales) as Total_sales,
	SUM(Total_profit) AS Total_profit
FROM factory_base_data
GROUP BY 1,2,3,4
ORDER BY 3 ASC, CAST((month) AS INT) ASC


--Total_sales by state
SELECT
	s.state_province,
	SUM(s.units * p.unit_price) as Total_Sales_by_state
FROM sales_data AS s
LEFT JOIN products AS p 
	ON s.Product_id = p.Product_id
GROUP BY 1
ORDER BY 2 DESC


--Year_on_Year_Growth:

WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM s.order_date)AS year,
        SUM(s.units*p.unit_price) AS total_sales
    FROM sales_data as s
	LEFT JOIN products as p
	on s.product_id = p.product_id
    GROUP BY EXTRACT(YEAR FROM s.order_date)
),

current_previous AS (
    SELECT
        y1.year AS current_year,
        y1.total_sales AS current_sales,
        y2.total_sales AS previous_sales
    FROM yearly_sales y1
    LEFT JOIN yearly_sales y2 
        ON y2.year = y1.year - 1
)

SELECT
    current_year,
    ((current_sales - previous_sales) / previous_sales) * 100 AS yoy_growth
FROM current_previous
ORDER BY current_year;



