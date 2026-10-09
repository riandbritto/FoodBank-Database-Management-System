# 🥫 Food Bank Database Management & Analytics System

### SQL Server | T-SQL | Relational Database Design | Stored Procedures | Data Analytics

A relational database management and analytics solution designed to streamline food bank operations through centralized donor management, donation tracking, inventory monitoring, and food distribution.

The project demonstrates practical applications of **SQL database engineering, workflow automation, data integrity, and operational analytics** to support efficient resource management and data-driven decision-making.

---

## 📌 Project Overview

Food banks manage interconnected operations involving donors, financial and food donations, inventory, recipients, and distribution centers. Managing these activities requires accurate data, reliable transaction processing, and visibility into available resources.

This project addresses these operational needs through a structured **Microsoft SQL Server database system** that supports:

- Centralized donor and donation management
- Inventory availability and stock monitoring
- Food distribution and order tracking
- Automated database operations
- Data integrity and transaction management
- Operational reporting and visualization

**Objective:** Build a reliable database foundation that enables efficient food bank operations, reduces dependence on repetitive manual database tasks, and supports informed resource allocation.

---
## 🚀 Setup & Execution Guide

### Prerequisites

To run this project locally, you will need:

- Microsoft SQL Server (Developer or Express edition)
- SQL Server Management Studio (SSMS) or a compatible SQL client
- Git (optional, for cloning the repository)

### 1. Clone the Repository

Open a terminal and run:

```bash
git clone https://github.com/riandbritto/FoodBank-Database-Management-System.git
cd FoodBank-Database-Management-System
```

Alternatively, select **Code → Download ZIP** on GitHub and extract the project files.

### 2. Create the Database

Connect to your SQL Server instance and execute:

```sql
IF DB_ID('FoodBankDB') IS NULL
BEGIN
    CREATE DATABASE FoodBankDB;
END;
GO

USE FoodBankDB;
GO
```

This initializes the database used throughout the project.

### 3. Execute SQL Scripts

The following is the recommended execution sequence after correcting and validating script dependencies.

| Order | SQL Script | Purpose |
|---|---|---|
| 1 | `FoodBankDB_DBO_v3.sql` | Create relational tables, primary keys, foreign keys, and constraints |
| 2 | `FoodBankDB_inserts_v3.sql` | Populate database tables with sample records |
| 3 | `FoodBankDB_psm_v4.sql` | Create stored procedures, functions, views, and triggers |
| 4 | `FoodBankDB_indexes_script_v1.sql` | Create indexes to support data retrieval |
| 5 | `FoodBankDB_encryption_v2.sql` | Demonstrate encryption-related database functionality |

**Important:** The scripts are provided as a development project and require validation before a complete fresh installation. Review any destructive statements before execution, particularly table drops and encryption-key operations.

### 4. Load Sample Data

After successfully creating the database tables, open and execute:

`FoodBankDB_inserts_v3.sql`

The script contains sample records for donors, donations, distribution centers, inventory, items, volunteers, suppliers, orders, programs, and recipients.

### 5. Verify Database Installation

Execute the following queries in SQL Server:

```sql
USE FoodBankDB;
GO

-- Verify donor records
SELECT TOP (10) * FROM Donor;

-- Verify donations
SELECT TOP (10) * FROM Donation;

-- Verify inventory
SELECT TOP (10) * FROM Inventory;

-- Verify distribution centers
SELECT TOP (10) * FROM DistributionCenter;
```

If the scripts execute successfully, these queries should return the corresponding sample records.

### 6. Explore Operational Data

Run the following example query to examine donation activity:

```sql
SELECT
    DonationType,
    DonationStatus,
    COUNT(*) AS TotalDonations
FROM Donation
GROUP BY DonationType, DonationStatus;
```

To inspect inventory by distribution center:

```sql
SELECT
    dc.CenterName,
    i.InventoryCapacity,
    i.StockQuantity
FROM DistributionCenter AS dc
JOIN Inventory AS i
    ON dc.CenterID = i.CenterID;
```

### 7. Review Project Documentation

For additional details, refer to:

- [Logical Database ERD](LogicalERD_FoodBank_v3.pdf)
- [Food Bank Visualizations](FoodBank%20Visualization.pdf)
- Project summary document included in the repository

### 8. Troubleshooting

**Database not found:** Confirm that `FoodBankDB` was created before running the scripts.

**Invalid object name:** Ensure the schema script completed successfully and that the correct database is selected.

**Foreign key constraint errors:** Check that referenced parent records exist before inserting dependent records.

**Stored procedure errors:** Review procedure parameters, required table columns, and database object dependencies.

**Encryption errors:** Verify the database encryption configuration and use secure, environment-specific credentials.

### Note

This project is intended for educational and portfolio demonstration purposes. The scripts should be tested and reviewed before being used in a production environment.

## 🛠️ Technical Stack

| Category | Technologies & Concepts |
|---|---|
| Database | Microsoft SQL Server |
| Programming | SQL, T-SQL |
| Database Design | Relational Modeling, ERD, Database Schema |
| Database Automation | Stored Procedures, Functions, Triggers |
| Data Integrity | Constraints, Transactions, Error Handling |
| Query Optimization | SQL Indexing |
| Data Management | Data Insertion, Updates, Retrieval |
| Analytics | SQL Views, Operational Reporting, Data Visualization |

---

## 🏗️ Database Architecture

The system organizes food bank operations into interconnected relational entities.

### Core Business Entities

| Entity | Purpose |
|---|---|
| Donors | Maintains donor information |
| Donations | Records financial and item-based contributions |
| Inventory | Tracks available food items and stock quantities |
| Distribution Centers | Organizes food distribution locations |
| Orders | Supports food distribution and order processing |
| Recipients | Maintains recipient-related information |

### Entity-Relationship Diagram

The logical ERD illustrates the database structure, entity relationships, and organization of operational data.

---

## ⚙️ Key Features & Implementation

### 1. Donor & Donation Management

Developed SQL-based workflows to support donor registration, donation tracking, and donation history retrieval.

**Key functionality:**
- Register and maintain donor information
- Record monetary and item-based donations
- Retrieve donation histories
- Generate donation summaries
- Support donor-related data management

### 2. Inventory Management

Implemented database operations to track inventory quantities and support stock management.

**Key functionality:**
- Maintain inventory records
- Update available stock quantities
- Track inventory movement
- Retrieve inventory information
- Support stock availability analysis

### 3. Food Distribution & Order Processing

Designed database operations to support distribution activities and order tracking.

**Key functionality:**
- Maintain distribution-related records
- Process distribution transactions
- Track orders and inventory allocation
- Support resource planning across distribution operations

### 4. SQL Automation & Business Logic

Developed T-SQL stored procedures and reusable database functions to support recurring operational processes.

**Implemented concepts:**
- Parameterized stored procedures
- SQL user-defined functions
- Database views
- Database triggers
- Transaction management
- Error handling

These components centralize business logic and help maintain consistent database operations.

### 5. Data Integrity & Reliability

Incorporated transaction handling and database controls to support reliable record management.

**Technical implementation:**
- Transaction processing using `BEGIN TRANSACTION`, `COMMIT`, and `ROLLBACK`
- SQL error handling using `TRY...CATCH`
- Relational database constraints
- Structured data validation
- Database auditing logic

### 6. SQL Indexing & Database Security

Included dedicated SQL scripts for database indexing and encryption-related functionality.

These scripts demonstrate familiarity with database performance considerations and security-oriented database development.

---

## 📊 Data Analytics & Visualization

The project includes data visualization documentation supporting the analysis of food bank operations.

**Analytical focus areas:**
- Donation activity and reporting
- Inventory availability
- Distribution workflows
- Operational data monitoring
- Resource planning

📄 [View Food Bank Visualizations](FoodBank%20Visualization.pdf)

The database structure provides a foundation for developing additional SQL-based reports and interactive business intelligence dashboards.

---

## 📁 Repository Structure

```text
FoodBank-Database-Management-System/
│
├── README.md
│
├── DAMG6210_FoodBank_ProjectSummary.pdf
│
├── LogicalERD_FoodBank_v3.pdf
│
├── FoodBankDB_DBO_v3.sql
│
├── FoodBankDB_psm_v4.sql
│
├── FoodBankDB_inserts_v3.sql
│
├── FoodBankDB_indexes_script_v1.sql
│
├── FoodBankDB_encryption_v2.sql
│
├── FoodBankDB_DistributionCenter.csv
│
└── FoodBank Visualization.pdf
```

### File Descriptions

| File | Description |
|---|---|
| `FoodBankDB_DBO_v3.sql` | Database schema and object definitions |
| `FoodBankDB_psm_v4.sql` | Stored procedures and database business logic |
| `FoodBankDB_inserts_v3.sql` | Data insertion scripts |
| `FoodBankDB_indexes_script_v1.sql` | Database indexing implementation |
| `FoodBankDB_encryption_v2.sql` | Database encryption-related scripts |
| `FoodBankDB_DistributionCenter.csv` | Distribution center dataset |
| `LogicalERD_FoodBank_v3.pdf` | Logical entity-relationship diagram |
| `FoodBank Visualization.pdf` | Data visualization documentation |
| `DAMG6210_FoodBank_ProjectSummary.pdf` | Project documentation and overview |

---

## 🚀 Getting Started

### Prerequisites

- Microsoft SQL Server
- SQL Server Management Studio (SSMS) or another compatible SQL client
- Access to a local or development SQL Server instance

### General Setup

1. Clone the repository:

   `git clone https://github.com/riandbritto/FoodBank-Database-Management-System.git`

2. Open the SQL scripts in your SQL client.

3. Review `FoodBankDB_DBO_v3.sql` to create the required database objects.

4. Review and execute the data insertion scripts against the appropriate database.

5. Deploy the required stored procedures, functions, and views.

6. Review the indexing and security scripts before executing them.

7. Run sample queries to inspect donor, donation, inventory, and distribution records.

**Note:** Confirm database dependencies and the correct script execution order before running the project in a new environment.

---

## 💡 Technical Skills Demonstrated

**SQL Development**
- Advanced T-SQL programming
- Stored procedures and functions
- Relational queries
- Database views and triggers

**Database Engineering**
- Relational database design
- Entity-relationship modeling
- Database indexing
- Transaction management
- Data integrity

**Business & Data Analytics**
- Operational data analysis
- Inventory and distribution workflows
- Data visualization
- Business process understanding
- Data-driven reporting

---

## 🔮 Future Enhancements

- Develop interactive Power BI dashboards connected to SQL Server
- Implement automated inventory alerts for low-stock items
- Add advanced SQL queries for donation and distribution trend analysis
- Expand database performance testing and query optimization
- Develop forecasting models for food demand and inventory planning
- Build an interactive application interface for database operations

---

## 👤 Author

**Rian Renold DBritto**

Master of Science in Data Analytics Engineering  
Northeastern University

**Areas of Interest:** Data Analytics | Business Intelligence | SQL Development | Healthcare Analytics | Business Analysis

[GitHub Profile](https://github.com/riandbritto)

---

*This project demonstrates the application of relational database design, SQL programming, and analytics to real-world nonprofit operational challenges.*
