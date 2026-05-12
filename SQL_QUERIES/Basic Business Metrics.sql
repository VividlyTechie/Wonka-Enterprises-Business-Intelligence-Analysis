--Total sales and profit by year
SELECT 
	EXTRACT(YEAR FROM order_date) AS year,
	SUM(s.units * p.unit_price)  AS Total_sales,
	SUM(s.units * (p.unit_price - p.unit_cost)) AS Total_profit
FROM sales_data AS s
LEFT JOIN products AS p
ON s.Product_id = p.Product_id
GROUP BY 1	
ORDER BY 1 ASC


--Monthly sales trends
SELECT
	EXTRACT(YEAR FROM s.order_date) AS year,
	TO_CHAR(s.order_date, 'MM') as month,
	SUM(s.units * p.unit_price)  AS Total_sales
FROM sales_data AS s
LEFT JOIN products AS p
ON s.Product_id = p.Product_id
GROUP BY 1,2	
ORDER BY 1,CAST(TO_CHAR(order_date,'MM') AS INT) ASC

---Sales distribution by division (Chocolate, Sugar, Other)
SELECT
	p.division as Division,
	SUM(s.units * p.unit_price)  AS Total_sales
FROM sales_data AS s
LEFT JOIN products AS p
ON s.Product_id = p.Product_id
GROUP BY 1	
ORDER BY 1 ASC

--Top 10 products by revenue and profit
SELECT
	p.product_id as Product_id,
	p.product_name as Product_name,
	SUM(s.units * p.unit_price)  AS Total_sales,
	SUM(s.units * (p.unit_price - p.unit_cost)) AS Total_profit
FROM sales_data AS s
LEFT JOIN products AS p
ON s.Product_id = p.Product_id
GROUP BY 1,2	
ORDER BY 3 DESC
LIMIT 10


select * from products
	
Order_id,	
Order_date,	
Ship_date,	
Ship_mode,	
Customer_id,
Country,
City,	
State_Province,
Region,
Product_id,
sum(quantity_ordered)