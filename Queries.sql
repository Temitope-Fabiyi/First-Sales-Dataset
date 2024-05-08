#How many users are in the database?
SELECT count(distinct user_id)
FROM baskets;

#How many baskets are in the database?
SELECT COUNT(distinct basket_id) 
FROM baskets;

#What is the percentage of baskets that were abandoned?
SELECT (SUM(abandond) /COUNT(abandond))*100 as percentage_abandoned 
FROM baskets;

#What is the percentage of baskets sold with discounts?
SELECT ((SELECT COUNT(*) from baskets
WHERE discount > 0)/ COUNT(*)) * 100
AS discounted_basket_orders 
FROM baskets;

#What are the discounts?
SELECT DISTINCT discount 
FROM baskets;

#How many baskets are in each discount group?
SELECT discount, Count(basket_id) AS no_of_baskets 
FROM baskets
GROUP BY 1;

Select abandond
FROM baskets;

#The highest revenue was recorded on which day of the week?
SELECT DAYNAME(baskets.event_time) AS day_of_week, SUM(p.price - p.cost) AS revenue
FROM baskets 
JOIN basketproducts bp ON baskets.basket_id = bp.basket_id
JOIN products p ON bp.product_id = p.product_id
WHERE baskets.abandond = 0 -- Assuming 'abandond' is a flag indicating whether the basket was abandoned
GROUP BY day_of_week 
ORDER BY revenue DESC
LIMIT 1;

#The highest revenue was recorded on which day?
SELECT DATE (baskets.event_time) AS date, SUM(p.price - p.cost) AS revenue
FROM baskets 
JOIN basketproducts bp ON baskets.basket_id = bp.basket_id
JOIN products p ON bp.product_id = p.product_id
WHERE baskets.abandond = 0 -- Assuming 'abandond' is a flag indicating whether the basket was abandoned
GROUP BY DATE(baskets.event_time)
ORDER BY revenue DESC
LIMIT 1;

#Top 10 most profitable products and their brands
SELECT products.product_id, products.brand, SUM(products.price - products.cost) AS profit
FROM products 
JOIN basketproducts bp ON products.product_id = bp.product_id
JOIN baskets b ON bp.basket_id = b.basket_id
WHERE b.abandond = 0 -- Assuming 'abandond' is a flag indicating whether the basket was abandoned
GROUP BY products.product_id, products.brand
ORDER BY profit DESC
LIMIT 10;

#Top 5 most profitable brands
SELECT products.brand, SUM(products.price - products.cost) AS profit
FROM products 
JOIN basketproducts ON products.product_id = basketproducts.product_id
JOIN baskets b ON basketproducts.basket_id = b.basket_id
WHERE b.abandond = 0 -- Assuming 'abandond' is a flag indicating whether the basket was abandoned
GROUP BY products.brand
ORDER BY profit DESC
LIMIT 5;

