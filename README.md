# Database Systems Laboratory - Semester 4

## Course Information
**Course:** Database Systems Laboratory | **Semester:** Spring 2026 | **Student:** M Ayyan Khan |

---

## Table of Contents
- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Laboratory Exercises](#laboratory-exercises)
- [Prerequisites](#prerequisites)
- [Setup and Installation](#setup-and-installation)
- [Usage Instructions](#usage-instructions)
- [Analytical Queries](#analytical-queries)
- [Learning Progression](#learning-progression)
- [License](#license)

---

## Overview
This repository contains comprehensive materials for the Database Systems Laboratory course during the 4th semester. It includes SQL scripts, analytical queries, schema definitions, and documentation demonstrating proficiency in database design, implementation, and query optimization techniques.

The coursework encompasses fundamental database concepts through advanced analytical operations, showcasing practical application of theoretical database principles.

---

## Repository Structure
```
DATABASE-LAB/
├── README.md                 # Project documentation (this file)
├── ai_learning_log.txt       # AI-assisted learning progression
├── analytical_queries.txt    # Advanced analytical queries
├── lab01_db.sql             # Laboratory exercise 1
├── lab1_schema.sql          # Schema definitions
├── lab2/                     # Laboratory exercise 2
│   ├── ecommerce_setup.sql  # E-commerce dataset schema and data
│   ├── queries.sql          # 10 SQL exercises
│   ├── week2.pdf            # Lab instructions
│   └── pdf2/                 # Lab 02 documentation
├── lab3/                     # Laboratory exercise 3
│   ├── queries.sql          # SQL queries for Lab 03
│   ├── lab3_extension.sql   # Extension queries
│   ├── performance_analysis.md  # Performance analysis report
│   ├── README.md            # Lab 03 documentation
│   ├── week3.pdf            # Lab instructions
│   ├── lab3_report.*        # LaTeX report files (tex, pdf, aux, log, toc, out)
│   └── pdf/                 # Query result screenshots
├── lab4/                     # Laboratory exercise 4 (NEW)
│   ├── README.md            # Lab 04 comprehensive documentation
│   ├── queries.sql          # 10 JOIN-based SQL queries
│   ├── er_diagram.dbml      # ER diagram in DBML format
│   ├── normalisation_reflection.txt  # 3NF analysis document
│   ├── week4.pdf            # Lab instructions
│   └── pdf/                 # Query screenshots and LaTeX report
│       ├── Lab04_Report.pdf # Compiled lab report
│       ├── Lab04_Report.tex # LaTeX source
│       ├── er_diagram.txt   # Text-based ER diagram
│       └── Query*.png       # 10 query result screenshots
├── pdf/                     # Lab 01 documentation
│   ├── Lab01_Ayyan_DS2024001.tex  # Lab 01 LaTeX report
│   ├── Lab01_Ayyan.pdf      # Compiled PDF
│   ├── *.png               # Lab 01 screenshots (12 images)
│   └── *.aux, *.log        # LaTeX compilation files
└── .git/                    # Version control metadata
```

---

## Laboratory Exercises

### Lab 01: Database Fundamentals and Schema Design
- **Files:** `lab01_db.sql`, `lab1_schema.sql`
- **Focus Areas:**
  - Database schema creation
  - Table design and normalization
  - Primary and foreign key relationships
  - Basic CRUD operations
  - Data integrity constraints

### Lab 02: E-Commerce Data Queries
- **Files:** `lab2/ecommerce_setup.sql`, `lab2/queries.sql`
- **Documentation:** `lab2/pdf2/`
- **Focus Areas:**
  - SELECT statements with filtering and sorting
  - Pattern matching with LIKE/ILIKE
  - NULL handling in queries
  - Computed columns and aggregate functions
  - CASE expressions for conditional logic
  - Query optimization concepts
- **Dataset:** E-commerce schema with customers, products, orders, and order_items tables
- **Tools:** DBeaver 25.3.3 (GUI) and psql (CLI)

### Lab 03: Advanced SQL and Performance Analysis
- **Files:** `lab3/queries.sql`, `lab3/lab3_extension.sql`
- **Documentation:** `lab3/lab3_report.tex`, `lab3/performance_analysis.md`, `lab3/README.md`
- **Focus Areas:**
  - Advanced JOIN operations
  - Window functions (ROW_NUMBER, RANK, LAG, LEAD)
  - Common Table Expressions (CTEs)
  - HAVING clause for aggregated filtering
  - Revenue and business metrics analysis
  - Query performance evaluation
- **Dataset:** E-commerce analytics with session data, orders, and customer behavior

### Lab 04: JOINs & Relational Data Modelling (NEW)
- **Files:** `lab4/queries.sql`, `lab4/er_diagram.dbml`, `lab4/normalisation_reflection.txt`
- **Documentation:** `lab4/README.md`, `lab4/pdf/Lab04_Report.pdf`
- **Focus Areas:**
  - INNER JOIN, LEFT JOIN, and FULL OUTER JOIN operations
  - Multi-table joins (up to 4 tables)
  - Anti-join patterns for finding missing data
  - JOINs combined with aggregation and filtering
  - Data completeness audits
  - Query execution plans with EXPLAIN ANALYZE
  - Database normalization analysis (3NF)
- **Dataset:** Enhanced e-commerce schema with customers, orders, order_items, products, and user_sessions
- **Key Deliverables:**
  - 10 SQL queries demonstrating various JOIN patterns
  - ER diagram in DBML format (compatible with dbdiagram.io)
  - Normalisation reflection analyzing user_sessions table (3NF)
  - Professional LaTeX report with query visualizations

---

## Prerequisites

### Technical Requirements
- **Database Management System:** MySQL 8.0+, PostgreSQL 12+, or compatible SQL engine
- **Development Environment:** Terminal/command prompt access
- **Text Editor:** VS Code, Sublime Text, or equivalent
- **Version Control:** Git 2.0+

### Knowledge Requirements
- Fundamental understanding of relational database concepts
- Basic familiarity with SQL syntax
- Understanding of database normalization principles

---

## Setup and Installation

### Cloning the Repository
```bash
# Clone the repository
git clone <repository-url>
cd DATABASE-LAB
```

### Database Initialization
```bash
# For MySQL
mysql -u username -p < lab1_schema.sql

# For PostgreSQL
psql -U username -d database_name < lab1_schema.sql
```

---

## Usage Instructions

### Executing Laboratory Scripts
1. **Review SQL Files:** Examine `.sql` files to understand the database operations
2. **Establish Connection:** Connect to your database management system
3. **Execute Scripts:** Import or execute SQL files using your preferred method
4. **Validate Results:** Verify output against expected outcomes documented in the lab specifications

### Analytical Query Execution
Advanced analytical queries are located in `analytical_queries.txt` and demonstrate:
- Complex JOIN operations
- Aggregate functions
- Window functions
- Subqueries and CTEs

---

## Analytical Queries
The `analytical_queries.txt` file contains sophisticated SQL queries designed to extract meaningful insights from the database, including:
- Business intelligence reports
- Statistical aggregations
- Trend analysis
- Performance metrics

---

## Learning Progression

### Skills Developed Across Labs

| Lab | Key SQL Concepts | Business Applications |
|-----|------------------|----------------------|
| **Lab 01** | Schema design, CRUD, constraints | Database fundamentals |
| **Lab 02** | SELECT, WHERE, LIKE, CASE, aggregates | Basic e-commerce queries |
| **Lab 03** | Window functions, CTEs, HAVING | Advanced analytics, time-series analysis |
| **Lab 04** | JOINs (INNER, LEFT, FULL OUTER), EXPLAIN ANALYZE | Relational modelling, data audits |

### Progressive Complexity
- **Lab 01 → Lab 02:** From schema creation to data querying
- **Lab 02 → Lab 03:** From basic queries to advanced analytics
- **Lab 03 → Lab 04:** From single-table analytics to multi-table relational operations

The `ai_learning_log.txt` file documents the learning journey and progressive skill development throughout the course, including:
- Problem-solving approaches
- Technical challenges encountered
- Solutions implemented
- Best practices adopted

---

## Academic Integrity
This repository represents original academic work completed for the Database Systems Laboratory course. All code and documentation reflect individual comprehension and implementation of database concepts.

---

## License
This repository is designated for educational and academic purposes only. Distribution or reproduction for commercial purposes is prohibited without explicit written consent.

---

**Last Updated:** March 5, 2026
