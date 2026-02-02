CREATE DATABASE fast_food_chain;
USE fast_food_chain;

CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    city VARCHAR(50),
    region VARCHAR(20),
    store_type VARCHAR(20)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    order_time TIME,
    store_id INT,
    order_type VARCHAR(20),
    total_amount INT,
    order_hour INT,
    day_ INT,
    month VARCHAR(15),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

SELECT * FROM orders;

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    item_name VARCHAR(50),
    category VARCHAR(20),
    price INT,
    quantity INT,
    item_revenue INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


# BASIC QUERIES

#1. Total revenue

SELECT 
      SUM(item_revenue) as Total_revenue 
FROM order_items;      

#2. Total orders

SELECT 
      COUNT(order_id) as Total_orders
FROM orders;

#3. Average order value

SELECT    
      AVG(order_id) as Average_order_value
FROM orders;      

#4. Orders by order type

SELECT 
      order_type,
      COUNT(order_id) as Total_orders
FROM orders
GROUP BY order_type;      


# MENU PERFORMANCE

#5.Revenue by category

SELECT 
     category,
     SUM(item_revenue) as Total_revenue
FROM order_items
GROUP BY category; 

#6. Top 5 selling items

SELECT 
      item_name,
      SUM(item_revenue) as Total_revenue
FROM order_items
GROUP BY item_name
ORDER BY Total_revenue
DESC LIMIT 5;      
     
#7. Least selling items

SELECT
      item_name,
      SUM(item_revenue) as Total_revenue
FROM order_items
GROUP BY item_name
ORDER BY Total_revenue
ASC LIMIT 5;  
   
#8. Average price per category

SELECT 
	 category,
     AVG(price) as Average_price
FROM order_items
GROUP BY category;     

# TIME-BASED ANALYSIS

#9. Peak order hours

SELECT 
     order_hour,
     MAX(order_id) as Most_orders
FROM orders
GROUP BY order_hour
ORDER BY Most_orders
desc LIMIT 5;    

#10. Orders by day of month

SELECT
    DAY(order_date) AS day_of_month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY day_of_month
ORDER BY day_of_month;

#11. Monthly revenue trend

SELECT
    MONTH(order_date) AS month_number,
    SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY MONTH(order_date)
ORDER BY month_number;

#12. Weekend v Weekdays 

SELECT
    CASE
        WHEN DAYOFWEEK(order_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    SUM(total_amount) AS total_revenue,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY day_type;


#13. City-wise revenue

SELECT
    s.city,
    SUM(o.total_amount) AS city_revenue
FROM orders o
JOIN stores s 
    ON o.store_id = s.store_id
GROUP BY s.city
ORDER BY city_revenue DESC;

#14. Best Performing Store

SELECT 
      s.store_id,
      SUM(o.total_amount) as Total_revenue
FROM orders o
JOIN stores s 
    ON o.store_id = s.store_id
GROUP BY s.store_id
ORDER BY Total_revenue
DESC LIMIT 1;    


