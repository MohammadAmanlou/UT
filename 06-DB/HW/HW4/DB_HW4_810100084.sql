use company;

/*q1*/

SELECT COUNT(*)
FROM customers c 
WHERE NOT EXISTS (
	SELECT *
	FROM orders o 
	WHERE o.customer_id = c.customer_id
);

/*q2*/
SELECT s.first_name AS firstName ,s.last_name AS lastName
FROM orders o , staffs s 
WHERE o.staff_id = s.staff_id 
GROUP BY o.staff_id 
ORDER BY COUNT(firstName)  DESC
LIMIT 3;

/*q3*/
SELECT o.*
FROM orders o
WHERE o.order_status = 2 

UNION 

SELECT o.*
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.first_name LIKE 'A%';

/*q4*/
SELECT p.product_id , p.product_name , p.list_price 
FROM products p
WHERE p.list_price >
	(SELECT AVG(p.list_price) FROM products p );
    
/*q5*/
SELECT DISTINCT store_id
FROM stores
WHERE store_id IN (
    SELECT stores.store_id
	FROM stores 
	INNER JOIN staffs  ON staffs.store_id = stores.store_id 
	WHERE LENGTH(first_name) = 5
	GROUP BY store_id 
	HAVING COUNT(staff_id) > 0
) AND store_id IN (
    SELECT stores.store_id
	FROM stores 
	INNER JOIN staffs  ON staffs.store_id = stores.store_id
	GROUP BY store_id 
	HAVING COUNT(staff_id) > 1
);

/*q6*/
SELECT stores.store_id
FROM stores 
INNER JOIN staffs  ON staffs.store_id = stores.store_id 
WHERE staffs.first_name LIKE '_____'
GROUP BY store_id 
HAVING COUNT(staff_id) > 1;

/*q7*/
SELECT c.customer_id , c.first_name , c.last_name
FROM customers c , orders o, order_items oi 
WHERE c.customer_id = o.customer_id 
	AND	c.customer_id IN(
		SELECT c1.customer_id  
		FROM customers c1 , orders o1 
		WHERE c1.customer_id = o1.customer_id 
		GROUP BY o1.customer_id 
		HAVING COUNT(*)> 8 );
        
  /*second solution*/
  SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    AVG(oi.total_quantity) AS avg_bought
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    (
        SELECT 
            order_id,
            SUM(quantity) AS total_quantity
        FROM 
            order_items
        GROUP BY 
            order_id
    ) AS oi ON o.order_id = oi.order_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
HAVING 
    COUNT(DISTINCT o.order_id) > 8;
    
/*q8*/
SELECT products.product_id, products.product_name, SUM(s1.quantity)
FROM stocks s1
JOIN products  ON s1.product_id = products.product_id
WHERE s1.product_id IN (
    SELECT s2.product_id
    FROM stocks s2
    WHERE s2.quantity > 0
    GROUP BY s2.product_id
    HAVING COUNT(*) = (SELECT COUNT(*) FROM stores s3)
)
GROUP BY products.product_id, products.product_name;


/*q9*/
SELECT brands.brand_name, products.product_id, products.product_name, products.list_price
FROM brands 
JOIN products ON brands.brand_id = products.brand_id
JOIN order_items oi ON products.product_id = oi.product_id
GROUP BY brands.brand_name, products.product_id;

/* q10 */

SELECT 
    product_id, 
    number_of_orderers
FROM (
    SELECT 
        products.product_id, 
        COUNT(DISTINCT orders.customer_id) AS number_of_orderers
    FROM 
        products 
        JOIN order_items i ON products.product_id = i.product_id
        JOIN orders  ON i.order_id = orders.order_id
    GROUP BY 
        products.product_id
) AS tmp
WHERE 
    number_of_orderers > 40
ORDER BY 
    number_of_orderers DESC;


/* q11 */

SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    stores s ON o.store_id = s.store_id
WHERE 
    c.city <> s.city
GROUP BY 
    c.customer_id, 
    c.first_name, 
    c.last_name;

/*q12*/

CREATE VIEW q12 AS
SELECT 
    c.category_name,
    o.order_date,
    SUM(i.list_price) AS total_list_price
FROM 
    order_items i
JOIN 
    orders o ON i.order_id = o.order_id
JOIN 
    products p ON p.product_id = i.product_id
JOIN 
    categories c ON c.category_id = p.category_id
GROUP BY 
    c.category_name,
    o.order_date;

/*q13*/

CREATE VIEW q13 AS
SELECT 
    p.product_name, 
    o.order_status, 
    o.order_id
FROM 
    order_items i
JOIN 
    orders o ON o.order_id = i.order_id
JOIN 
    products p ON p.product_id = i.product_id;

/*q14*/
CREATE view q14 as 
	SELECT zz.store_id, zz.brand_id
	FROM (
	    SELECT s.store_id, brands.brand_id, SUM(s.quantity) AS stocks_total /*sum_of_stocks*/
	    FROM brands 
	    JOIN products  ON brands.brand_id = products.brand_id
	    JOIN stocks s ON products.product_id = s.product_id
	    GROUP BY s.store_id, brands.brand_id
	) AS zz
	JOIN (
	    SELECT store_id, MIN(stocks_total) AS min_stocks_total /*min_sum_of_stocks*/
	    FROM (
	        SELECT s.store_id, brands.brand_id, SUM(s.quantity) AS stocks_total
	        FROM brands 
	        JOIN products  ON brands.brand_id = products.brand_id
	        JOIN stocks s ON products.product_id = s.product_id
	        GROUP BY s.store_id, brands.brand_id
	    ) AS sub_temp
	    GROUP BY store_id
	) AS min_temp ON zz.store_id = min_temp.store_id AND zz.stocks_total = min_temp.min_stocks_total
	ORDER BY zz.store_id;
	;
    

--
/*q15*/
DELIMITER //
CREATE TRIGGER q15 AFTER DELETE ON order_items
FOR EACH ROW
BEGIN   
    DECLARE product_id INT;
    DECLARE store_id INT;
    SELECT stocks.store_id stock_id, p.product_id INTO  store_id, product_id
    FROM orders o, products p, stocks 
    WHERE stocks.store_id = o.store_id AND
		  o.product_id = p.product_id AND
		  o.order_id = OLD.order_id ;
  UPDATE stocks 
    SET stocks.quantity = stocks.quantity + OLD.quantity
    WHERE stocks.product_id = product_id AND stocks.store_id = store_id;

END;

//

DELIMITER ;
/*q16*/

DELIMITER //
CREATE TRIGGER q16
BEFORE UPDATE ON staffs
FOR EACH ROW
IF (( SELECT COUNT(*) FROM staffs st WHERE st.manager_id = NEW.manager_id) > 1) 
THEN
  BEGIN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Error: Specified manager is full!";
  END ;  
END IF; //
DELIMITER ;


/*q17*/
DELIMITER //
CREATE TRIGGER q17
BEFORE INSERT ON customers
FOR EACH ROW BEGIN
	IF  (LENGTH(NEW.phone) < 7) OR (LENGTH(NEW.phone) > 15) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Phone number must have between 7 AND 15 digits!';
	END IF;
END;
	
      
      //

DELIMITER ;