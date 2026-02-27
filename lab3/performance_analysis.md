# Performance Analysis for Week 3 Queries

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

### Expected Performance Characteristics:
- **HashAggregate**: Used for the GROUP BY operation on the formatted month
- **Sort**: Required for the ORDER BY clause
- **Function Scan**: TO_CHAR function applied to each row
- **Sequential Scan**: Full table scan of orders table

### Key Observations:
- The TO_CHAR function prevents index usage on order_date
- HashAggregate builds an in-memory hash table for grouping
- Sort operation may spill to disk if working set is large
- Simple query with minimal operations

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

### Expected Performance Characteristics:
- **Multiple CTEs**: Each CTE creates a temporary result set
- **Hash Join**: LEFT JOIN between customers and orders
- **HashAggregate**: Multiple aggregation operations
- **Window Function**: SUM() OVER () for percentage calculation
- **Sort**: Final ORDER BY operation

### Key Observations:
- More complex query with multiple operations
- CTEs create intermediate materialized results
- Window function adds computational overhead
- Multiple HashAggregate operations (one per CTE)
- Likely slower than Query 3 due to complexity

## Comparison

| Aspect | Query 3 | Query 9 |
|--------|---------|---------|
| Operations | 3-4 | 8-10 |
| Complexity | Low | High |
| CTEs | None | 2 levels |
| Joins | None | 1 (LEFT JOIN) |
| Window Functions | None | 1 |
| Expected Speed | Faster | Slower |
| Memory Usage | Low | Higher |

## Performance Insights

1. **Query 3** is simpler with fewer operations, making it faster and more efficient.

2. **Query 9** involves multiple CTEs, joins, and window functions, which:
   - Create intermediate result sets in memory
   - Require multiple aggregation passes
   - Add computational overhead for window calculations
   - May spill to disk if memory is constrained

3. **CTE Materialization**: PostgreSQL materializes CTEs by default, creating temporary tables that consume memory and I/O.

4. **Window Function Cost**: The `SUM(SUM(total_spent)) OVER ()` requires computing the grand total across all rows after grouping.

5. **Optimization Opportunity**: For Query 9, the window function could be replaced with a subquery to potentially improve performance.