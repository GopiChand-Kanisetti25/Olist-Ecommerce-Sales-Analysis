USE olist_ecommerce;

-- 1. Total orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders_correct;

-- 2. Monthly revenue
SELECT
    DATE_FORMAT(
        STR_TO_DATE(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'),
        '%Y-%m'
    ) AS month,
    ROUND(SUM(CAST(oi.price AS DECIMAL(10,2))), 2) AS monthly_revenue
FROM orders_correct o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE order_purchase_timestamp IS NOT NULL
GROUP BY month
ORDER BY month;

-- 3. Top 10 product categories
SELECT
    pt.product_category_name_english AS category,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation pt
    ON p.product_category_name = pt.product_category_name
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 10;

-- 4. Top 10 states by revenue
SELECT
    c.customer_state,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN orders_correct o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;