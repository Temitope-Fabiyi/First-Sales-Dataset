`sales`basketproducts
ALTER TABLE basketproducts
DROP COLUMN data;
ALTER TABLE basketproducts
DROP COLUMN None;
SELECT *
FROM basketproducts
SELECT *
FROM products;
SELECT *
FROM baskets;
SELECT count(distinct user_id)
FROM baskets;