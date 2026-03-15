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
