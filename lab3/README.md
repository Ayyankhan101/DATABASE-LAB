# Database Systems Lab — Week 03

## Advanced SQL: Aggregations & Analytics

This lab focuses on advanced SQL concepts including:
- Aggregate functions (COUNT, SUM, AVG, MIN, MAX)
- GROUP BY and HAVING clauses
- Window functions (ROW_NUMBER, RANK, LAG, LEAD)
- Common Table Expressions (CTEs)
- Time-series and cohort analysis

## Files

- `lab3_extension.sql`: SQL script to extend the e-commerce dataset with user_sessions table
- `queries.sql`: All 10 lab queries demonstrating advanced SQL concepts

## Dataset Extension

The `lab3_extension.sql` file adds a `user_sessions` table that tracks:
- Session ID (primary key)
- Customer ID (foreign key to customers table)
- Session date
- Pages viewed
- Duration in minutes
- Device type
- Conversion status

## Queries

1. **Overall business summary**: KPIs for delivered orders
2. **Revenue by product category**: Join and aggregation
3. **Monthly order volume and revenue**: Time-series aggregation
4. **Active cities**: GROUP BY with HAVING
5. **Device performance**: Multiple aggregations with HAVING
6. **Ranking orders**: ROW_NUMBER window function
7. **Overall revenue ranking**: RANK vs DENSE_RANK
8. **Month-over-month trends**: LAG window function
9. **Customer segmentation**: Multi-level CTEs
10. **Session-to-purchase funnel**: Complex CTE with business analysis

## Performance Analysis

The lab includes EXPLAIN ANALYZE queries to understand:
- HashAggregate operations for GROUP BY
- Sort operations for ORDER BY
- Window function performance
- CTE execution plans

## Learning Outcomes

By completing this lab, you will:
- Understand the difference between WHERE and HAVING
- Use window functions for analytical queries
- Write readable complex queries with CTEs
- Apply these skills to real-world business analysis
- Analyze query performance with EXPLAIN ANALYZE