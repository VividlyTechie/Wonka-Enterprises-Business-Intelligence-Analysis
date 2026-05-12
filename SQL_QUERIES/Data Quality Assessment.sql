--Total sales records 
SELECT 
	COUNT(*) 
FROM sales_data;

--Date range of the Data
SELECT 
	Min(order_date) AS MIN_DATE,
	Max(ship_date) AS MAX_DATE
FROM sales_data;

/*Checking for Missing critical Value(although i
 put constraints during table creation) */

SELECT
	*
FROM sales_data
WHERE customer_id IS NULL OR order_id IS NULL OR product_id  IS NULL;


--Distinct customers  
SELECT 
	COUNT(DISTINCT(customer_id))
FROM sales_data;
	
