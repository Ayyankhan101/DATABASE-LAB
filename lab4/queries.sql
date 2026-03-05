-- ============================================================================
-- Database Systems Lab — Week 04: JOINs & Relational Data Modelling
-- Course: Database Systems Lab (Data Science Program)
-- ============================================================================

-- ============================================================================
-- Query 1: Orders with customer names (INNER JOIN)
-- Description: Show order details with customer name and city instead of just customer_id
-- ============================================================================
SELECT o.order_id,
       c.name        AS customer_name,
       c.city,
       o.order_date,
       o.status,
       o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

-- ============================================================================
-- Query 2: Full order receipt (4-table join)
-- Description: Complete order receipt showing customer, order, product details
-- ============================================================================
SELECT c.name         AS customer,
       o.order_id,
       o.order_date,
       o.status,
       p.product_name,
       p.category,
       oi.quantity,
       oi.unit_price,
       oi.quantity * oi.unit_price AS line_total
FROM order_items oi
INNER JOIN orders o ON oi.order_id = o.order_id
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON oi.product_id = p.product_id
ORDER BY o.order_id, p.category;

-- ============================================================================
-- Query 3: Customers who have never ordered (LEFT JOIN)
-- Description: Find customers who signed up but never placed any order
-- ============================================================================
SELECT c.customer_id,
       c.name,
       c.email,
       c.city,
       c.signup_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.signup_date;

-- ============================================================================
-- Query 4: Products never ordered (LEFT JOIN)
-- Description: Find products that have never appeared in order_items
-- ============================================================================
SELECT p.product_id,
       p.product_name,
       p.category,
       p.price,
       p.stock_qty
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.item_id IS NULL
ORDER BY p.category;

-- ============================================================================
-- Query 5: Revenue by customer with join (Aggregation + LEFT JOIN)
-- Description: Show every customer's total orders and total spent, including 0 for non-ordering customers
-- ============================================================================
SELECT c.name,
       c.city,
       COUNT(o.order_id)              AS total_orders,
       COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_spent DESC;

-- ============================================================================
-- Query 6: Best-selling products
-- Description: Top 5 products by total units sold with revenue
-- ============================================================================
SELECT p.product_name,
       p.category,
       p.price,
       SUM(oi.quantity)                AS units_sold,
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category, p.price
ORDER BY units_sold DESC
LIMIT 5;

-- Extended version: All products including those with zero sales
SELECT p.product_name,
       p.category,
       p.price,
       COALESCE(SUM(oi.quantity), 0)                AS units_sold,
       COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_revenue
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category, p.price
ORDER BY units_sold DESC;

-- ============================================================================
-- Query 7: City-level sales report
-- Description: For each city, show customer count, order count, and total revenue
-- ============================================================================
SELECT c.city,
       COUNT(DISTINCT c.customer_id) AS num_customers,
       COUNT(DISTINCT o.order_id)    AS num_orders,
       SUM(o.total_amount)           AS total_revenue,
       ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- ============================================================================
-- Query 8: Order details with status filter
-- Description: Delivered orders from 2025, grouped by customer with totals
-- ============================================================================
SELECT c.name                              AS customer,
       c.city,
       COUNT(DISTINCT p.product_id)        AS distinct_products_bought,
       SUM(oi.quantity)                    AS total_items,
       SUM(oi.quantity * oi.unit_price)    AS total_spent
FROM order_items oi
INNER JOIN orders o ON oi.order_id = o.order_id
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'delivered'
  AND o.order_date >= '2025-01-01'
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_spent DESC;

-- ============================================================================
-- Query 9: Session and purchase behaviour together
-- Description: For every customer with sessions, show session count, orders, and total spent
-- ============================================================================
SELECT c.name,
       c.city,
       COUNT(DISTINCT s.session_id)       AS total_sessions,
       COUNT(DISTINCT o.order_id)         AS total_orders,
       COALESCE(SUM(DISTINCT o.total_amount), 0) AS total_spent,
       CASE
           WHEN COUNT(DISTINCT o.order_id) > 0 THEN 'Converted'
           ELSE 'Not Converted'
       END                                AS customer_status
FROM customers c
INNER JOIN user_sessions s ON c.customer_id = s.customer_id
LEFT JOIN orders o ON c.customer_id = o.customer_id
       AND o.status = 'delivered'
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_sessions DESC;

-- ============================================================================
-- Query 10: FULL OUTER JOIN - Data completeness audit
-- Description: Identify mismatches between customers and user_sessions tables
-- ============================================================================
SELECT c.customer_id                     AS customer_table_id,
       c.name,
       s.customer_id                     AS session_table_cust_id,
       COUNT(s.session_id)               AS session_count,
       CASE
           WHEN c.customer_id IS NULL THEN 'Orphaned session — no customer record'
           WHEN s.customer_id IS NULL THEN 'Customer with no sessions'
           ELSE 'Matched'
       END                               AS audit_status
FROM customers c
FULL OUTER JOIN user_sessions s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.name, s.customer_id
ORDER BY audit_status, c.name;

-- ============================================================================
-- Performance Analysis: EXPLAIN ANALYZE for Query 2
-- Run this to see the query execution plan
-- ============================================================================
EXPLAIN ANALYZE
SELECT c.name         AS customer,
       o.order_id,
       o.order_date,
       o.status,
       p.product_name,
       p.category,
       oi.quantity,
       oi.unit_price,
       oi.quantity * oi.unit_price AS line_total
FROM order_items oi
INNER JOIN orders o ON oi.order_id = o.order_id
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON oi.product_id = p.product_id
ORDER BY o.order_id, p.category;
