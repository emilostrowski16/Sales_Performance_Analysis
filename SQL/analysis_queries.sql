-- Total number of orders
SELECT COUNT(order_id) AS total_orders
FROM olist_orders_dataset
WHERE order_status = 'delivered';


-- Total revenue
SELECT SUM(payment_value) AS total_revenue
FROM olist_order_payments_dataset;

-- Average order value
SELECT SUM(payment_value) / COUNT(DISTINCT order_id) AS average_order_value
FROM olist_order_payments_dataset;

-- Number of orders per month
SELECT 
       STRFTIME('%m', order_purchase_timestamp) AS month,
       COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY month
ORDER BY month;

-- Revenue per month
SELECT 
       STRFTIME('%Y-%m', od.order_purchase_timestamp) AS date,
       SUM(opd.payment_value) AS total_revenue
FROM olist_orders_dataset AS od
JOIN olist_order_payments_dataset AS opd
       ON od.order_id = opd.order_id
GROUP BY date
ORDER BY date;

-- Sales performance by product category
SELECT 
    COALESCE(pcnt.product_category_name_english, 'others') AS category_name,
    COUNT(oid.order_id) AS orders_count,
    ROUND(SUM(oid.price), 2) AS total_revenue
FROM olist_order_items_dataset AS oid
JOIN olist_products_dataset AS opd 
    ON oid.product_id = opd.product_id
LEFT JOIN product_category_name_translation AS pcnt 
    ON opd.product_category_name = pcnt.product_category_name
GROUP BY category_name
ORDER BY orders_count DESC;
