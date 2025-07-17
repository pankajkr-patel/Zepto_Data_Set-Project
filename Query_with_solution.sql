DROP TABLE IF EXISTS Zepto_Set_Project;
CREATE TABLE Zepto_Set_Project(
	product_id SERIAL PRIMARY KEY,
	Category VARCHAR(100) NOT NULL,
	name VARCHAR(100) NOT NULL,
	mrp NUMERIC(10,2),
	discountPercent NUMERIC(10,2),
	availableQuantity INT,
	discountedSellingPrice NUMERIC(10,2),
	weightInGms INT,
	outOfStock BOOLEAN,
	quantity INT
);
SELECT * FROM Zepto_Set_Project;

-- ******************* QUERIES *******************
-- 1	count of rows:
	SELECT COUNT(*) FROM Zepto_Set_Project;

-- 2	Sample 10 data from Zepto_set_Project:
	SELECT * FROM Zepto_Set_Project
	LIMIT 10;

-- 3	find null values in every column:
	SELECT * FROM Zepto_Set_Project
	WHERE  product_id IS NULL 
	OR
	Category IS NULL 
	OR
	name IS NULL
	OR
	mrp IS NULL
	OR
	discountPercent IS NULL
	OR
	availableQuantity IS NULL
	OR
	discountedSellingPrice IS NULL
	OR
	weightInGms IS NULL
	OR
	outOfStock IS NULL
	OR
	quantity IS NULL;

-- 4	find different product categories:
	SELECT DISTINCT category FROM Zepto_Set_Project;

-- 5	find total stock and out of stock using group by:
	SELECT DISTINCT outofstock, COUNT(product_id) AS total
	FROM Zepto_Set_Project
	GROUP BY outofstock;
	
-- 6	total count product name which is present multiple times:
	SELECT DISTINCT name, COUNT(product_id) AS total_count
	FROM Zepto_Set_Project
	GROUP BY name;
	
	                    -- *********** Data Cleaning ***************


-- ⦁	find the product with zero(0) prize:
	SELECT name, mrp , discountedSellingPrice FROM Zepto_Set_Project
	WHERE mrp = 0 AND discountedSellingPrice = 0;

-- ⦁	convert price into ruppes:
	UPDATE Zepto_Set_Project
	SET mrp = mrp/100.0,
	discountedSellingPrice = discountedSellingPrice/100.0;
	
-- ⦁	Find the top 10 best-value products based on the discount percentage.
	SELECT name, mrp, discountedSellingPrice 
	FROM Zepto_Set_Project
	ORDER BY discountedSellingPrice DESC
	LIMIT 10;

	-- ⦁	What are the Products with High MRP but Out of Stock:
	SELECT DISTINCT name, mrp FROM Zepto_Set_Project
	WHERE outofstock = 'true' AND mrp>3
	ORDER BY mrp DESC;

	-- ⦁	Find all products where MRP is greater than 5 and discount is less than 10%.
	SELECT DISTINCT name, mrp, discountpercent  FROM Zepto_Set_Project
	WHERE mrp > 5 AND discountpercent < 10
	ORDER BY mrp DESC;

	-- ⦁	Identify the top 5 categories offering the highest average discount percentage.
	SELECT DISTINCT category , ROUND(AVG(discountpercent),2) AS Avg_discount
	FROM Zepto_Set_Project
	GROUP BY category
	ORDER BY Avg_discount DESC
	LIMIT 5;

	-- ⦁	Find the price per gram for products above 100g and sort by best value.
	SELECT DISTINCT name, weightingms, discountedsellingprice, ROUND(discountedsellingprice/weightingms , 2) 
	AS price_per_gram
	FROM Zepto_Set_Project
	WHERE weightingms >= 100
	ORDER BY price_per_gram;
	
	-- 	⦁	Group the products into categories like Low, Medium, Bulk.
	SELECT DISTINCT name , category, weightingms, 
	CASE
		WHEN weightingms < 1000 THEN 'LOW'
		WHEN weightingms < 5000 THEN 'MIDEUM' 
		ELSE 'BULK'
		END AS weight_category
	FROM Zepto_Set_Project
	ORDER BY weightingms DESC;
		
	-- ⦁	What is the Total Inventory Weight Per Category.
	SELECT DISTINCT category, 
	SUM(weightingms * availablequantity) 
	AS total_weight
	FROM Zepto_Set_Project
	GROUP BY category;
	
SELECT * FROM Zepto_Set_Project;

