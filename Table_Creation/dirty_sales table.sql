DROP TABLE IF EXISTS dirty_sales_data;
CREATE TABLE dirty_sales_data(
	Order_id VARCHAR(28),	
	Order_date DATE NOT NULL,	
	Ship_date DATE NOT NULL,	
	Ship_mode VARCHAR(50),	
	Customer_id	INT,
	Country VARCHAR NOT NULL,
	City VARCHAR(50) NOT NULL,	
	State_Province VARCHAR,
	Region VARCHAR(50),
	Product_id VARCHAR(13),
	Quantity_Ordered INT
);



