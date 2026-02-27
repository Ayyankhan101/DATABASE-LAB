# Database Systems Lab — Week 03

## Advanced SQL: Aggregations & Analytics

This lab focuses on advanced SQL concepts including:
- Aggregate functions (COUNT, SUM, AVG, MIN, MAX)
- GROUP BY and HAVING clauses
- Window functions (ROW_NUMBER, RANK, LAG, LEAD)
- Common Table Expressions (CTEs)
- Time-series and cohort analysis

## Files

| File | Description |
|------|-------------|
| `lab3_extension.sql` | SQL script to extend the e-commerce dataset with user_sessions table |
| `queries.sql` | All 10 lab queries demonstrating advanced SQL concepts |
| `lab3_report.tex` | LaTeX source for the professional lab report |
| `lab3_report.pdf` | Compiled PDF report with queries and visualizations |
| `performance_analysis.md` | Detailed query performance analysis |

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

| # | Query | Description | Visualization |
|---|-------|-------------|---------------|
| 1 | Overall business summary | KPIs for delivered orders | `Query1-Overall-business-summary.png` |
| 2 | Revenue by product category | Join and aggregation | `Query 2—Revenu-by-product-category.png` |
| 3 | Monthly order volume and revenue | Time-series aggregation | `Query 3—Monthly-order-volume-and-revenue.png` |
| 4 | Active cities | GROUP BY with HAVING | `Query-4—HAVING:-active-cities.png` |
| 5 | Device performance | Multiple aggregations with HAVING | `Query-5—Device-performance-with-HAVING.png` |
| 6 | Ranking orders | ROW_NUMBER window function | `Query-6—Ranking-orders-with-ROW_NUMBER.png` |
| 7 | Overall revenue ranking | RANK vs DENSE_RANK | `Query-7—Overall-revenue-ranking-with-RANK.png` |
| 8 | Month-over-month trends | LAG window function | `Query-8—Month-over-month-revenue-trend-with-LAG.png` |
| 9 | Customer segmentation | Multi-level CTEs | `Query-9—Customer-value-segmentation-using-CTEs.png` |
| 10 | Session-to-purchase funnel | Complex CTE with business analysis | `Query-10—Session-to-purchase-funnel-analysis.png` |

## Visualizations

All query results are visualized as PNG images and embedded in the LaTeX report:

- **Query 1**: Overall business KPIs (total orders, revenue, avg order value, largest order)
- **Query 2**: Revenue breakdown by product category
- **Query 3**: Monthly trends in order volume and revenue
- **Query 4**: Geographic distribution of active customers
- **Query 5**: Device-wise session and conversion metrics
- **Query 6**: Per-customer order ranking using window functions
- **Query 7**: Revenue ranking comparison (RANK vs DENSE_RANK)
- **Query 8**: Month-over-month revenue change analysis
- **Query 9**: Customer value tier distribution
- **Query 10**: Session-to-purchase conversion funnel

## Report

The complete lab report is available as:
- **PDF**: `lab3_report.pdf` — Professional 11-page report with all queries, code listings, and visualizations
- **LaTeX Source**: `lab3_report.tex` — Editable source file

### Report Contents
1. Title page with abstract
2. Table of contents
3. Introduction to advanced SQL concepts
4. Dataset extension documentation
5. All 10 queries with:
   - SQL code listings (syntax-highlighted)
   - Technique descriptions
   - Result visualizations (PNG figures)
6. Summary table of SQL techniques
7. Learning outcomes

## Performance Analysis

See `performance_analysis.md` for detailed EXPLAIN ANALYZE results including:
- HashAggregate operations for GROUP BY
- Sort operations for ORDER BY
- Window function performance
- CTE execution plans
- Query comparison (simple vs complex queries)

## Learning Outcomes

By completing this lab, you will:
- Understand the difference between WHERE and HAVING
- Use window functions for analytical queries
- Write readable complex queries with CTEs
- Apply these skills to real-world business analysis
- Analyze query performance with EXPLAIN ANALYZE
- Generate professional reports with LaTeX

## Building the Report

To compile the LaTeX report:

```bash
pdflatex lab3_report.tex
pdflatex lab3_report.tex  # Second pass for TOC
```

This produces `lab3_report.pdf` with all queries and visualizations.
