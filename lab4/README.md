# Database Systems Lab — Week 04
## JOINs & Relational Data Modelling

**Course:** Database Systems Lab (Data Science Program)  
**Instructor:** Muhammad Usama Afridi  
**Student:** Muhammad Ayyan Khan  
**Institute:** Institute of Management Sciences  
**Date:** March 2026

---

## 📋 Table of Contents

- [Overview](#overview)
- [Database Schema](#database-schema)
- [Lab Deliverables](#lab-deliverables)
- [Query Summary](#query-summary)
- [File Structure](#file-structure)
- [How to Use](#how-to-use)
- [Key Learnings](#key-learnings)

---

## 📖 Overview

This lab focuses on mastering **SQL JOIN operations** and **relational data modelling** using an e-commerce database schema. The exercises cover all major JOIN types (INNER, LEFT, FULL OUTER) and demonstrate practical business analytics scenarios including customer analysis, product performance, revenue reporting, and data quality audits.

### Learning Objectives

- Master INNER JOIN, LEFT JOIN, and FULL OUTER JOIN operations
- Understand multi-table joins (up to 4 tables)
- Apply JOINs with aggregation and filtering
- Perform data completeness audits
- Analyze query execution plans with EXPLAIN ANALYZE
- Evaluate database normalization (3NF)

---

## 🗄️ Database Schema

### Entity-Relationship Diagram

```
┌──────────────────┐       ┌──────────────────┐       ┌──────────────────┐
│    CUSTOMERS     │       │     ORDERS       │       │   ORDER_ITEMS    │
├──────────────────┤       ├──────────────────┤       ├──────────────────┤
│ PK customer_id   │◄──────│ FK customer_id   │       │ FK order_id      │
│    name          │  1:N  │ PK order_id      │  1:N  │ FK product_id    │
│    email         │       │    order_date    │──────►│    quantity      │
│    city          │       │    status        │       │    unit_price    │
│    signup_date   │       │    total_amount  │       └──────────────────┘
└──────────────────┘       │    shipped_date  │                ▲
         ▲                 └──────────────────┘                │ 1:N
         │ 1:N                                                  │
         │                                            ┌──────────────────┐
         │                                            │    PRODUCTS      │
         │                                            ├──────────────────┤
         └────────────────────────────────────────────│ PK product_id    │
                                                      │    product_name  │
+──────────────────┐                                  │    category      │
│  USER_SESSIONS   │                                  │    price         │
├──────────────────┤                                  │    stock_qty     │
│ PK session_id    │                                  └──────────────────┘
│ FK customer_id   │
│    session_date  │
│    device        │
│    converted     │
└──────────────────┘
```

### Tables Description

| Table | Primary Key | Foreign Keys | Description |
|-------|-------------|--------------|-------------|
| `customers` | customer_id | — | Customer master data (name, email, city, signup date) |
| `orders` | order_id | customer_id → customers | Order transactions with status and totals |
| `order_items` | item_id | order_id → orders, product_id → products | Line items within orders |
| `products` | product_id | — | Product catalog with pricing and inventory |
| `user_sessions` | session_id | customer_id → customers | User browsing sessions and conversion tracking |

### Relationships

1. **customers → orders** (One-to-Many): One customer can place many orders
2. **orders → order_items** (One-to-Many): One order contains many line items
3. **products → order_items** (One-to-Many): One product appears in many order items
4. **customers → user_sessions** (One-to-Many): One customer has many browsing sessions

---

## 📝 Lab Deliverables

### Section 1: 10 SQL Queries (35 points)

Ten queries demonstrating various JOIN patterns with business analytics applications:

| # | Query | JOIN Type | Business Purpose |
|---|-------|-----------|------------------|
| 1 | Orders with Customer Names | INNER JOIN | Replace IDs with readable customer info |
| 2 | Full Order Receipt | 4-table INNER JOIN | Complete transaction details for receipts |
| 3 | Customers Who Never Ordered | LEFT JOIN (Anti-Join) | Identify churned/non-converting customers |
| 4 | Products Never Ordered | LEFT JOIN (Anti-Join) | Find dead inventory for clearance |
| 5 | Revenue by Customer | LEFT JOIN + Aggregation | Customer lifetime value calculation |
| 6 | Best-Selling Products | INNER JOIN + Aggregation | Top products by units and revenue |
| 7 | City-Level Sales Report | INNER JOIN + Aggregation | Geographic market analysis |
| 8 | Order Details with Status Filter | Multi-JOIN + WHERE | Completed orders analysis (2025+) |
| 9 | Session & Purchase Behaviour | INNER + LEFT JOIN | Conversion funnel analysis |
| 10 | Data Completeness Audit | FULL OUTER JOIN | Data quality/integrity check |

### Section 2: ER Diagram

- **File:** `er_diagram.dbml` (DBML format for dbdiagram.io)
- **Text Representation:** `pdf/er_diagram.txt`
- Visualizes all tables, primary keys, foreign keys, and relationships

### Section 3: Normalisation Reflection

- **File:** `normalisation_reflection.txt`
- **Topic:** Analysis of whether the `user_sessions` table is in Third Normal Form (3NF)
- **Conclusion:** Yes, the table satisfies 3NF requirements
  - All non-key attributes depend only on the primary key (session_id)
  - No transitive dependencies exist
  - Foreign key (customer_id) correctly references the customers table

---

## 🔍 Query Summary

### Query Patterns Demonstrated

#### 1. INNER JOIN (Queries 1, 2, 6, 7, 8)
```sql
SELECT o.order_id, c.name AS customer_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
```
**Use Case:** Connecting transaction tables to dimension/lookup tables

#### 2. LEFT JOIN with IS NULL (Queries 3, 4, 5)
```sql
SELECT c.customer_id, c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
```
**Use Case:** Finding records that don't have matches (anti-join pattern)

#### 3. LEFT JOIN with Aggregation (Query 5)
```sql
SELECT c.name, COUNT(o.order_id) AS total_orders,
       COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = c.customer_id
GROUP BY c.customer_id, c.name, c.city
```
**Use Case:** Including zero-values for non-matching records

#### 4. Multi-Table JOINs (Queries 2, 8, 9)
```sql
SELECT ...
FROM order_items oi
INNER JOIN orders o ON oi.order_id = o.order_id
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON oi.product_id = p.product_id
```
**Use Case:** Complete business transaction views

#### 5. FULL OUTER JOIN (Query 10)
```sql
SELECT c.customer_id, s.customer_id,
       CASE
           WHEN c.customer_id IS NULL THEN 'Orphaned session'
           WHEN s.customer_id IS NULL THEN 'Customer with no sessions'
           ELSE 'Matched'
       END AS audit_status
FROM customers c
FULL OUTER JOIN user_sessions s ON c.customer_id = s.customer_id
```
**Use Case:** Data quality audits and integrity checks

#### 6. EXPLAIN ANALYZE
```sql
EXPLAIN ANALYZE
SELECT ... -- (any complex query)
```
**Use Case:** Query performance optimization and execution plan analysis

---

## 📁 File Structure

```
lab4/
├── README.md                      # This file - comprehensive lab documentation
├── queries.sql                    # All 10 SQL queries with comments
├── er_diagram.dbml                # ER diagram in DBML format (for dbdiagram.io)
├── normalisation_reflection.txt   # 3NF analysis of user_sessions table
├── week4.pdf                      # Original lab assignment instructions
│
└── pdf/                           # Generated outputs and screenshots
    ├── er_diagram.txt             # Text-based ER diagram representation
    ├── Lab04_Report.pdf           # Compiled lab report (LaTeX output)
    ├── Lab04_Report.tex           # LaTeX source for lab report
    ├── Query1—Your-firs-join:-orders-with-customer-names.png
    ├── Query2---Full-order-receipt.png
    ├── Query3----Customers-who-have-never-ordered.png
    ├── Query4—Products-never-ordered(before).png
    ├── Query4--Products-never-ordered(after)EXplain analyze.png
    ├── Query5—Revenue-by-customer-with-join.png
    ├── Query6—Best-selling-products.png
    ├── Query7—City-level-sales-report.png
    ├── Query8—Order-details-with-status-filter.png
    ├── Query9—Session-and-purchase-behaviour-together.png
    ├── Query10—FULL-OUTER-JOIN:-data-completeness-audit.png
    └── EXPLAIN-ANALYZE.png        # Query execution plan screenshot
```

---

## 🚀 How to Use

### Running the Queries

1. **Connect to your PostgreSQL database:**
   ```bash
   psql -U your_username -d ecommerce_db
   ```

2. **Execute the queries file:**
   ```bash
   psql -U your_username -d ecommerce_db -f queries.sql
   ```

3. **Or run individual queries interactively:**
   ```sql
   \i queries.sql
   ```

### Visualizing the ER Diagram

1. Visit [dbdiagram.io](https://dbdiagram.io/)
2. Copy the contents of `er_diagram.dbml`
3. Paste into the editor to generate a visual ER diagram

### Analyzing Query Performance

For any query, prepend `EXPLAIN ANALYZE` to see the execution plan:
```sql
EXPLAIN ANALYZE
SELECT ... -- your query here
```

This shows:
- Join strategies (Hash Join, Nested Loop, Merge Join)
- Actual execution times
- Row estimates vs. actual rows
- Memory usage

---

## 🎯 Key Learnings

### SQL JOIN Mastery

| JOIN Type | Returns | Common Use Case |
|-----------|---------|-----------------|
| **INNER JOIN** | Only matching rows | Connecting transactions to dimensions |
| **LEFT JOIN** | All left table rows + matches | Including non-ordering customers |
| **LEFT JOIN + IS NULL** | Non-matching rows only | Finding gaps/missing data |
| **FULL OUTER JOIN** | All rows from both tables | Data quality audits |

### Business Analytics Applications

1. **Customer Analytics:** Lifetime value, churn identification, geographic distribution
2. **Product Analytics:** Best-sellers, dead inventory, category performance
3. **Sales Analytics:** Revenue by region, order patterns, conversion funnels
4. **Data Quality:** Orphaned records, referential integrity checks

### Normalization Insights

The `user_sessions` table analysis demonstrates:
- **1NF:** Atomic values, no repeating groups ✓
- **2NF:** No partial dependencies (single-column PK) ✓
- **3NF:** No transitive dependencies ✓

### Performance Considerations

- **Hash Joins** are efficient for large-table anti-joins (Query 4)
- **Proper indexing** on foreign keys improves JOIN performance
- **EXPLAIN ANALYZE** reveals actual vs. estimated costs
- **Filter placement** matters: WHERE vs. ON clause affects LEFT JOIN behavior

---

## 📊 Sample Output Highlights

### Query 3: Customers Who Never Ordered
Identifies customers requiring re-engagement campaigns:
```
 customer_id |    name     |      email      |   city   | signup_date
-------------+-------------+-----------------+----------+-------------
     15      | John Smith  | john@email.com  | Boston   | 2025-02-15
     23      | Sarah Jones | sarah@email.com | Chicago  | 2025-02-10
```

### Query 6: Top 5 Best-Selling Products
```
  product_name    |  category   |  price  | units_sold | total_revenue
------------------+-------------+---------+------------+---------------
  Wireless Mouse  | Electronics |  29.99  |    145     |   4348.55
  USB-C Cable     | Electronics |  12.99  |    132     |   1714.68
```

### Query 10: Data Audit Results
```
 customer_table_id |    name     | session_table_cust_id | session_count | audit_status
-------------------+-------------+-----------------------+---------------+--------------
        1          | Alice Brown |          1            |      5        |   Matched
      NULL         |    NULL     |         99            |      2        | Orphaned session
        7          | Mike Wilson |        NULL           |     NULL      | Customer with no sessions
```

---

## 🔗 References

- **PostgreSQL Documentation:** [JOIN Operations](https://www.postgresql.org/docs/current/sql-select.html#SQL-FROM)
- **DBML Documentation:** [dbdiagram.io](https://dbdiagram.io/)
- **Normalization Guide:** [Database Normalization Basics](https://www.postgresql.org/docs/current/ddl-normalization.html)

---

## 📄 License

This lab work is part of the Database Systems Lab course curriculum at the Institute of Management Sciences.

---

**Last Updated:** March 5, 2026
