# Sql_data_warehouse_project
Building a modern Data Warehouse with SQL server, including ETL processes, data modeling, and analytics 

📌Project Overview

Welcome to the SQL Data Warehouse Project.

This project was built by May Osman as part of the Full SQL Course by Baraa Khatib Salkini.
It follows the complete step-by-step roadmap provided in his YouTube course and reflects real-world data engineering and analytics workflows.

You can find Baraa’s channel here:
🔗 https://www.youtube.com/@DataWithBaraa

To stay organized I created a full Notion project workspace also to avoid chaos, and validate progress.

You can view my Notion roadmap here:
🔗 https://www.notion.so/Data-Warehouse-Project-2ddd5da8dfd28068997dd3e88ab2c7c6

🏗️ Architecture

This project follows the Medallion Architecture:

Bronze Layer → Raw data from source systems

Silver Layer → Cleaned & standardized data

Gold Layer → Business-ready analytical tables

📏 General Design Principles

To ensure consistency, quality, and scalability, the following rules are applied:

General Principles

Naming convention: snake_case (lowercase, underscore separated)

Language: English only

Reserved words: Avoid SQL reserved words as object names

🧱 Table Naming Conventions
🟤 Bronze Layer

Tables must keep the original source structure

Format:

<sourcesystem>_<entity>


Examples:

crm_customer_info
erp_sales_orders

⚪ Silver Layer

Same naming pattern as Bronze

Represents cleaned and standardized versions of the source tables

<sourcesystem>_<entity>


Examples:

crm_customer_info
erp_sales_orders

🟡 Gold Layer

Business-friendly names

Format:

<category>_<entity>


Where:

dim_ = Dimension tables

fact_ = Fact tables

agg_ = Aggregated tables

Examples:

Pattern	Meaning	Example
dim_	Dimension table	dim_customers
fact_	Fact table	fact_sales
agg_	Aggregated table	agg_sales_monthly
🧩 Column Naming Conventions
Surrogate Keys

All primary keys in dimension tables must use the suffix _key.

Format:

<table_name>_key


Example:

customer_key   -- Surrogate key in dim_customers


These keys ensure stable joins and support slowly changing dimensions.

Technical Columns

All system-generated metadata columns must start with dwh_.

Format:

dwh_<description>


Example:

dwh_load_date   -- Date when the record was loaded into the warehouse

⚙️ Stored Procedure Naming

All ETL loading procedures follow this pattern:

load_<layer>


Examples:

load_bronze
load_silver
load_gold


These procedures handle data movement and transformation between layers.

🎯 Goal of This Project

This project simulates how real data engineering teams design, load, and manage enterprise-grade data warehouses.

It demonstrates:

ETL design

Layered architecture

Data modeling

Business-ready analytics
