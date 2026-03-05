# Lab 02: E-Commerce Database Setup and SQL Queries

## Overview

This lab focuses on setting up a complete e-commerce database schema with four related tables and practicing fundamental SQL querying techniques. The dataset simulates a real-world online store with customers, products, orders, and order items.

---

## Database Schema

### Entity Relationship

```
customers (1) ──── (N) orders (1) ──── (N) order_items (N) ──── (1) products
```

### Tables

#### 1. `customers`
Stores customer information.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `customer_id` | SERIAL | PRIMARY KEY | Unique customer identifier |
| `name` | VARCHAR(100) | NOT NULL | Customer's full name |
| `email` | VARCHAR(150) | UNIQUE, NOT NULL | Email address |
| `city` | VARCHAR(80) | - | City of residence |
| `signup_date` | DATE | NOT NULL | Account registration date |

#### 2. `products`
Contains product catalog information.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `product_id` | SERIAL | PRIMARY KEY | Unique product identifier |
| `product_name` | VARCHAR(150) | NOT NULL | Product name |
| `category` | VARCHAR(60) | NOT NULL | Product category |
| `price` | DECIMAL(10,2) | NOT NULL, CHECK > 0 | Product price |
| `stock_qty` | INTEGER | NOT NULL, DEFAULT 0 | Available stock quantity |

#### 3. `orders`
Tracks customer orders.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `order_id` | SERIAL | PRIMARY KEY | Unique order identifier |
| `customer_id` | INTEGER | FOREIGN KEY → customers | Reference to customer |
| `order_date` | DATE | NOT NULL | Date order was placed |
| `status` | VARCHAR(30) | NOT NULL, DEFAULT 'pending' | Order status |
| `total_amount` | DECIMAL(10,2) | NOT NULL | Total order value |
| `shipped_date` | DATE | - | Date order was shipped |

**Order Statuses:** `pending`, `processing`, `shipped`, `delivered`, `cancelled`

#### 4. `order_items`
Line items for each order (junction table).

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `item_id` | SERIAL | PRIMARY KEY | Unique item identifier |
| `order_id` | INTEGER | FOREIGN KEY → orders | Reference to order |
| `product_id` | INTEGER | FOREIGN KEY → products | Reference to product |
| `quantity` | INTEGER | NOT NULL, CHECK > 0 | Quantity ordered |
| `unit_price` | DECIMAL(10,2) | NOT NULL | Price per unit |

---

## Dataset Summary

### Customers
- **Total:** 20 customers
- **Cities:** Peshawar, Lahore, Karachi, Islamabad, Faisalabad, Multan, Quetta
- **Signup Period:** March 2023 - January 2025

### Products
- **Total:** 15 products
- **Categories:**
  - Electronics (9 products): Mouse, Hub, Keyboard, Stand, Headset, Webcam, Lamp
  - Books (5 products): Programming and technical books
  - Furniture (3 products): Chair, Desk, Monitor Arm
- **Price Range:** Rs. 1,200 - Rs. 28,000

### Orders
- **Total:** 29 orders
- **Status Distribution:** delivered, shipped, processing, pending, cancelled
- **Date Range:** September 2024 - August 2025

---

## SQL Queries Covered

### 1. Exploring Data
```sql
SELECT * FROM customers LIMIT 5;
SELECT * FROM products LIMIT 5;
SELECT * FROM orders LIMIT 5;
SELECT * FROM order_items LIMIT 5;
```
**Purpose:** Quick preview of table contents.

---

### 2. Select Specific Columns
```sql
SELECT name, city, signup_date
FROM customers
ORDER BY signup_date;
```
**Purpose:** Retrieve only needed columns, sorted by signup date.

---

### 3. Filter by Status
```sql
SELECT order_id, customer_id, total_amount, order_date
FROM orders
WHERE status = 'delivered'
ORDER BY order_date DESC;
```
**Purpose:** Find all delivered orders, newest first.

---

### 4. Filter by Price Range

**Method A: Using BETWEEN**
```sql
SELECT product_name, category, price
FROM products
WHERE price BETWEEN 1000 AND 5000
ORDER BY price;
```

**Method B: Using Comparison Operators**
```sql
SELECT product_name, category, price
FROM products
WHERE price >= 1000 AND price <= 5000
ORDER BY price;
```
**Purpose:** Find products within a specific price range.

---

### 5. Top 10 Highest-Value Orders
```sql
SELECT order_id, customer_id, total_amount, status
FROM orders
ORDER BY total_amount DESC
LIMIT 10;
```
**Purpose:** Identify top revenue-generating orders.

---

### 6. Multi-Condition Filter
```sql
SELECT order_id, customer_id, total_amount, order_date
FROM orders
WHERE status = 'delivered'
  AND order_date >= '2025-01-01'
  AND total_amount > 10000
ORDER BY total_amount DESC;
```
**Purpose:** Complex filtering with multiple AND conditions.

---

### 7. Pattern Matching on Email
```sql
SELECT name, email, city
FROM customers
WHERE email LIKE '%@gmail.com'
ORDER BY name;
```
**Purpose:** Find customers using Gmail addresses.

---

### 8. NULL Handling (Unshipped Orders)
```sql
SELECT order_id, customer_id, order_date, status, total_amount
FROM orders
WHERE shipped_date IS NULL
ORDER BY order_date;
```
**Purpose:** Identify orders that haven't been shipped yet.

---

### 9. Computed Column (20% Discount)
```sql
SELECT product_name,
       category,
       price AS original_price,
       ROUND(price * 0.80, 2) AS discounted_price,
       ROUND(price * 0.20, 2) AS you_save
FROM products
ORDER BY discounted_price DESC;
```
**Purpose:** Calculate discounted prices using arithmetic operations.

---

### 10. Priority Classification with CASE
```sql
SELECT order_id,
       customer_id,
       total_amount,
       order_date,
       status,
       CASE
           WHEN total_amount > 20000 THEN 'CRITICAL'
           WHEN total_amount > 5000 THEN 'URGENT'
           ELSE 'NORMAL'
       END AS priority
FROM orders
WHERE shipped_date IS NULL
  AND order_date >= '2025-01-01'
ORDER BY total_amount DESC
LIMIT 5;
```
**Purpose:** Classify unshipped orders by priority based on order value.

**Priority Levels:**
- **CRITICAL:** Orders > Rs. 20,000
- **URGENT:** Orders Rs. 5,000 - Rs. 20,000
- **NORMAL:** Orders ≤ Rs. 5,000

---

## Key SQL Concepts Practiced

| Concept | Example |
|---------|---------|
| SELECT & projection | Choosing specific columns |
| WHERE clause | Filtering rows |
| ORDER BY | Sorting results |
| LIMIT | Restricting output |
| BETWEEN | Range filtering |
| LIKE | Pattern matching |
| IS NULL | NULL value handling |
| Computed columns | Arithmetic in SELECT |
| CASE expressions | Conditional logic |
| Aggregate functions | (prepared for future labs) |
| JOINs | (implicit in foreign keys) |

---

## Files in This Lab

| File | Description |
|------|-------------|
| `ecommerce_setup.sql` | Schema creation and data insertion |
| `queries.sql` | All SQL queries for the lab |
| `week2.pdf` | Lab instructions/handout |
| `pdf2/` | Generated report and visual outputs |

---

## Setup Instructions

1. **Create the database:**
   ```bash
   createdb lab2_db
   ```

2. **Load the schema and data:**
   ```bash
   psql -d lab2_db -f ecommerce_setup.sql
   ```

3. **Run queries:**
   ```bash
   psql -d lab2_db -f queries.sql
   ```

4. **Or interactively:**
   ```bash
   psql -d lab2_db
   ```

---

## Sample Query Outputs

### Customers Preview
```
 customer_id |     name      |           email            |   city    | signup_date
-------------+---------------+----------------------------+-----------+-------------
           1 | Ali Hassan    | ali.hassan@gmail.com       | Peshawar  | 2023-03-12
           2 | Sara Khan     | sara.khan@yahoo.com        | Lahore    | 2023-05-20
           3 | Usman Tariq   | usman.tariq@gmail.com      | Karachi   | 2023-07-08
```

### Products by Category
```
 Electronics: 9 products (Rs. 1,850 - Rs. 12,500)
 Books: 5 products (Rs. 1,200 - Rs. 2,200)
 Furniture: 3 products (Rs. 8,500 - Rs. 28,000)
```

### Order Status Distribution
```
 delivered  : Majority of orders
 shipped    : In transit
 processing : Being prepared
 pending    : Awaiting processing
 cancelled  : Cancelled orders
```

---

## Learning Objectives

By completing this lab, you should be able to:

- ✅ Design a normalized e-commerce database schema
- ✅ Understand foreign key relationships
- ✅ Write SELECT queries with column projection
- ✅ Filter data using WHERE clauses
- ✅ Sort results with ORDER BY
- ✅ Use BETWEEN for range queries
- ✅ Apply LIKE for pattern matching
- ✅ Handle NULL values properly
- ✅ Create computed columns
- ✅ Use CASE for conditional logic
- ✅ Combine multiple conditions with AND

---

## Notes

- All monetary values are in Pakistani Rupees (Rs.)
- The dataset spans from 2023 to 2025
- Customer emails are unique (constraint enforced)
- Product prices must be positive (CHECK constraint)
- Order quantities must be positive (CHECK constraint)

---

## Author

**Lab Course:** Database Systems Lab  
**Semester:** SEM-4  
**Institution:** [Your Institution]

---

## References

- PostgreSQL Documentation: https://www.postgresql.org/docs/
- Lab handout: `week2.pdf`
- Generated report: `pdf2/lab02_report.pdf`
