DROP TABLE IF EXISTS FACTORIES;

CREATE TABLE Factories(
	factoryid int primary key,
	factory varchar(50) not null,
	latitude decimal(20, 6),
	longitude decimal(20, 6)
	
);

insert into factories values
(1,'Lot''s O''Nuts',32.881893,-111.768036),						
(2,'Wicked Choccy''s',32.076176,-81.088371),			
(3,'Sugar Shack',48.11914,-96.18115),			
(4,'Secret Factory',41.446333,-90.565487),			
(5,'The Other Factory',35.1175,-89.971107);		


