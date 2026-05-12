DROP TABLE IF EXISTS targets;

CREATE TABLE targets(
	Division VARCHAR,
	Year INTEGER NOT NULL,
	Target INT,
	PRIMARY KEY (Division, Year)
);

INSERT into targets(Division,Year,Target) values	
	-- 2022 Targets 
	('Chocolate', 2022, 22000),
	('Sugar', 2022, 12000),
	('Other', 2022, 2500),
	
	-- 2023 Targets
	('Chocolate', 2023, 25000),
	('Sugar', 2023, 14000),
	('Other', 2023, 2800),
	
	-- 2024 Targets
	('Chocolate', 2024, 27000),
	('Sugar', 2024, 15000),
	('Other', 2024, 3000),

	-- 2025 Targets(future projection)
	('Chocolate', 2025, 30000),
	('Sugar', 2025, 17000),
	('Other', 2025, 3500);