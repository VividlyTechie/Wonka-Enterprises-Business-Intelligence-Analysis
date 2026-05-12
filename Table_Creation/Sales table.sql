Drop Table If Exists Sales_data;
CREATE TABLE sales_data(
	Order_id VARCHAR(28) primary key,	
	Order_date DATE NOT NULL,	
	Ship_date DATE NOT NULL,	
	Ship_mode VARCHAR(50),	
	Customer_id	INT,
	Country VARCHAR NOT NULL,
	City VARCHAR(50) NOT NULL,	
	State_Province VARCHAR,
	Region VARCHAR(50),
	Product_id VARCHAR(13),
	Units INT,
	foreign key(product_id) references products(product_id)
);
Insert into sales_data 
	select 
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
	from dirty_sales_data
	Group by 1,2,3,4,5,6,7,8,9,10;
