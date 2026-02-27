# Performance Analysis for Week 3 Queries

## Overview

This document provides detailed performance analysis for the SQL queries in Lab 3. Each query was analyzed using `EXPLAIN ANALYZE` to understand execution plans and identify optimization opportunities.

---

## Query 3: Monthly Order Volume and Revenue

```sql
EXPLAIN ANALYZE
SELECT TO_CHAR(order_date, 'YYYY-MM') AS month,
       COUNT(*) AS num_orders,
       SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;
```

### Execution Plan Characteristics:
| Operation | Description |
|-----------|-------------|
| **HashAggregate** | Used for the GROUP BY operation on the formatted month |
| **Sort** | Required for the ORDER BY clause |
| **Function Scan** | TO_CHAR function applied to each row |
| **Sequential Scan** | Full table scan of orders table |

### Key Observations:
- The TO_CHAR function prevents index usage on order_date
- HashAggregate builds an in-memory hash table for grouping
- Sort operation may spill to disk if working set is large
- Simple query with minimal operations

---

## Query 9: Customer Value Segmentation

```sql
EXPLAIN ANALYZE
WITH customer_spend AS (
    SELECT c.customer_id,
           c.name,
           c.city,
           COALESCE(SUM(o.total_amount), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    AND o.status = 'delivered'
    GROUP BY c.customer_id, c.name, c.city
),
customer_tiers AS (
    SELECT *,
           CASE
               WHEN total_spent > 30000 THEN 'VIP'
               WHEN total_spent > 10000 THEN 'High Value'
               WHEN total_spent > 0 THEN 'Active'
               ELSE 'Never Purchased'
           END AS tier
    FROM customer_spend
)
SELECT tier,
       COUNT(*) AS customers,
       SUM(total_spent) AS total_revenue,
       ROUND(100.0 * SUM(total_spent) / SUM(SUM(total_spent)) OVER (), 1) AS pct_of_revenue
FROM customer_tiers
GROUP BY tier
ORDER BY total_revenue DESC;
```

### Execution Plan Characteristics:
| Operation | Description |
|-----------|-------------|
| **Multiple CTEs** | Each CTE creates a temporary result set |
| **Hash Join** | LEFT JOIN between customers and orders |
| **HashAggregate** | Multiple aggregation operations |
| **Window Function** | SUM() OVER () for percentage calculation |
| **Sort** | Final ORDER BY operation |

### Key Observations:
- More complex query with multiple operations
- CTEs create intermediate materialized results
- Window function adds computational overhead
- Multiple HashAggregate operations (one per CTE)
- Likely slower than Query 3 due to complexity

---

## Query Comparison

| Aspect | Query 3 | Query 9 |
|--------|---------|---------|
| Operations | 3–4 | 8–10 |
| Complexity | Low | High |
| CTEs | None | 2 levels |
| Joins | None | 1 (LEFT JOIN) |
| Window Functions | None | 1 |
| Expected Speed | Faster | Slower |
| Memory Usage | Low | Higher |

---

## Performance Insights

### 1. Query Complexity
**Query 3** is simpler with fewer operations, making it faster and more efficient.

**Query 9** involves multiple CTEs, joins, and window functions, which:
- Create intermediate result sets in memory
- Require multiple aggregation passes
- Add computational overhead for window calculations
- May spill to disk if memory is constrained

### 2. CTE Materialization
PostgreSQL materializes CTEs by default, creating temporary tables that consume memory and I/O.

### 3. Window Function Cost
The `SUM(SUM(total_spent)) OVER ()` requires computing the grand total across all rows after grouping.

### 4. Optimization Opportunities
For Query 9, the window function could be replaced with a subquery to potentially improve performance.

---

## Additional Query Analyses

### Query 5: Device Performance with HAVING

```sql
SELECT device,
       COUNT(*) AS total_sessions,
       ROUND(AVG(duration_mins), 2) AS avg_duration,
       SUM(CASE WHEN converted THEN 1 ELSE 0 END) AS conversions,
       ROUND(100.0 * SUM(CASE WHEN converted THEN 1 ELSE 0 END) / COUNT(*), 1) 
           AS conversion_rate_pct
FROM user_sessions
GROUP BY device
HAVING COUNT(*) >= 5
ORDER BY avg_duration DESC;
```

**Characteristics:**
- Conditional aggregation using CASE expressions
- HAVING clause filters grouped results
- Multiple aggregate functions in single pass

### Query 6: Ranking Orders with ROW_NUMBER

```sql
SELECT customer_id,
       order_id,
       order_date,
       total_amount,
       ROW_NUMBER() OVER (
           PARTITION BY customer_id
           ORDER BY total_amount DESC
       ) AS rank_within_customer
FROM orders
ORDER BY customer_id, rank_within_customer;
```

**Characteristics:**
- Window function with PARTITION BY
- Requires sort for both PARTITION and ORDER BY
- No data reduction (returns all rows)

### Query 8: Month-over-Month Trend with LAG

```sql
WITH monthly_revenue AS (
    SELECT TO_CHAR(order_date, 'YYYY-MM') AS month,
           SUM(total_amount) AS revenue
    FROM orders
    WHERE status = 'delivered'
    GROUP BY TO_CHAR(order_date, 'YYYY-MM')
)
SELECT month,
       revenue,
       LAG(revenue) OVER (ORDER BY month) AS prev_month,
       revenue - LAG(revenue) OVER (ORDER BY month) AS absolute_change,
       ROUND(
           100.0 * (revenue - LAG(revenue) OVER (ORDER BY month))
           / NULLIF(LAG(revenue) OVER (ORDER BY month), 0),
           1
       ) AS pct_change
FROM monthly_revenue
ORDER BY month;
```

**Characteristics:**
- CTE for base aggregation
- LAG window function for previous row access
- NULLIF prevents division by zero
- Multiple LAG calls (could be optimized with single call)

---

## Summary

| Query | Primary Operation | Performance Impact |
|-------|-------------------|-------------------|
| 1 | Simple Aggregation | Low |
| 2 | JOIN + GROUP BY | Medium |
| 3 | GROUP BY + Sort | Low-Medium |
| 4 | JOIN + HAVING | Medium |
| 5 | Conditional Aggregation | Medium |
| 6 | Window Function (ROW_NUMBER) | Medium-High |
| 7 | Window Function (RANK) | Medium-High |
| 8 | CTE + LAG | High |
| 9 | Multi-level CTEs + Window | High |
| 10 | Multiple CTEs + JOINs | High |

---

## References

- Full query results and visualizations: `lab3_report.pdf`
- SQL source code: `queries.sql`
- Dataset extension: `lab3_extension.sql`
