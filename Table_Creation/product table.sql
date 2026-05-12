DROP TABLE IF EXISTS products;

CREATE TABLE products(
	Product_id varchar(13) primary key,
	Product_name VARCHAR(225) NOT NULL unique,	
	Division VARCHAR,
	Factoryid int,	
	Unit_Price decimal(10,2),	
	Unit_Cost decimal(10,2),
	Factory_id int,
	foreign key(factory_id) REFERENCES factories(factoryid)
	
);
