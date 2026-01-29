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
├── README.md                 # Project documentation
├── ai_learning_log.txt       # AI-assisted learning progression
├── analytical_queries.txt    # Advanced analytical queries
├── lab01_db.sql             # Laboratory exercise 1
├── lab1_schema.sql          # Schema definitions
├── pdf/                     # Supporting documentation
│   ├── *.png               # Diagrams and visual aids
│   └── *.aux, *.log        # LaTeX compilation files
└── .git/                    # Version control metadata
```

---

## Laboratory Exercises

### Lab 01: Database Fundamentals and Schema Design
- **File:** `lab01_db.sql`
- **File:** `lab1_schema.sql`
- **Focus Areas:**
  - Database schema creation
  - Table design and normalization
  - Primary and foreign key relationships
  - Basic CRUD operations
  - Data integrity constraints

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