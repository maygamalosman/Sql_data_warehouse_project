# 📊 SQL Data Warehouse Project

Building a modern Data Warehouse using Microsoft SQL Server, including ETL processes, data modeling, and analytics-ready structures.

## 📌 Project Overview

This project demonstrates the end-to-end implementation of a **modern data warehouse solution** following industry best practices.

It was built by **May Osman** as part of a structured SQL learning journey, inspired by real-world data engineering workflows.

The project simulates how organizations transform raw data into **business-ready insights**.

<img width="1207" height="755" alt="DWH Layers" src="https://github.com/user-attachments/assets/67896bf3-e2d9-40ed-9cb3-648f83824755" />

---
## 🎯 Project Objectives

* Design a scalable Data Warehouse architecture
* Implement ETL pipelines across multiple layers
* Clean, standardize, and transform raw data
* Build a **Star Schema** for analytics
* Enable reporting and data-driven decision making
---

## 🏗️ Architecture

This project follows the **Medallion Architecture**:

* 🟤 **Bronze Layer** → Raw data (as-is from source systems)
* ⚪ **Silver Layer** → Cleaned and standardized data
* 🟡 **Gold Layer** → Business-ready analytical models
<img width="1415" height="747" alt="Integration model" src="https://github.com/user-attachments/assets/b3bad547-c4eb-472f-ac44-66a0d8549b15" />




## 🔄 Data Flow

Source Systems (CRM & ERP) → Bronze → Silver → Gold → Reporting / Analytics
 ---<img width="1215" height="802" alt="Data Flow Diagram" src="https://github.com/user-attachments/assets/65852194-8f3c-4a44-ba54-4f2b7d3b4cff" />
---

## 🧱 Data Modeling

The Gold Layer is designed using a **Star Schema**:
<img width="788" height="767" alt="Star Schema" src="https://github.com/user-attachments/assets/b76f9ff4-8b73-4b10-a0f4-04b4a0508283" />


* **Fact Table**

  * `fact_sales`

* **Dimension Tables**

  * `dim_customers`
  * `dim_products`

This structure enables efficient querying and supports BI tools like Power BI.

---

## ⚙️ ETL Process

Data is processed through structured layers:

### 🟤 Bronze Layer

* Stores raw data from source systems
* No transformations applied
* Supports full load & batch processing

### ⚪ Silver Layer

* Data cleaning and standardization
* Handling missing values
* Data normalization & enrichment

### 🟡 Gold Layer

* Business logic implementation
* Data integration across sources
* Creation of analytical views (fact & dimensions)

---

## 📏 Design Standards

### 🔹 Naming Conventions

* snake_case for all objects
* English naming only
* Avoid SQL reserved keywords

---

### 🧱 Table Naming

| Layer  | Format              | Example                    |
| ------ | ------------------- | -------------------------- |
| Bronze | `<source>_<entity>` | crm_sales_details          |
| Silver | `<source>_<entity>` | erp_cust_info              |
| Gold   | `<type>_<entity>`   | dim_customers / fact_sales |

---

### 🧩 Column Naming

* Surrogate Keys → `<table>_key`

  * Example: `customer_key`

* Technical Columns → `dwh_<column>`

  * Example: `dwh_load_date`

---

### ⚙️ Stored Procedures

| Purpose     | Naming        |
| ----------- | ------------- |
| Load Bronze | `load_bronze` |
| Load Silver | `load_silver` |
| Load Gold   | `load_gold`   |

---

## 🧠 Key Skills Demonstrated

* SQL (Joins, Window Functions, CASE, COALESCE)
* Data Modeling (Star Schema)
* ETL Design
* Data Cleaning & Transformation
* Analytical Thinking

---

## 🚀 Business Value

This project shows how raw data can be transformed into:

* Actionable insights
* Structured reporting datasets
* Scalable analytics solutions

---

## 📂 Project Resources

* 📺 Course Reference:
  [https://www.youtube.com/@DataWithBaraa](https://www.youtube.com/@DataWithBaraa)

* 🗂️ Project Planning (Notion):
  [https://www.notion.so/Data-Warehouse-Project-2ddd5da8dfd28068997dd3e88ab2c7c6](https://www.notion.so/Data-Warehouse-Project-2ddd5da8dfd28068997dd3e88ab2c7c6)

---

## 💡 Future Improvements

* Add incremental loading
* Implement Slowly Changing Dimensions (SCD)
* Connect to BI dashboard
* Optimize query performance

