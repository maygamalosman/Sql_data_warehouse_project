# 📊 SQL Data Warehouse Project

> Building a modern Data Warehouse using **Microsoft SQL Server**, including ETL processes, data modeling, and analytics-ready structures.

---

## 📌 Project Overview

This project demonstrates the end-to-end implementation of a modern data warehouse solution following industry best practices.

It was built by **May Osman** as part of a structured SQL learning journey, inspired by real-world data engineering workflows. The project simulates how organizations transform raw data into business-ready insights.

---

## 🎯 Project Objectives

- Design a scalable Data Warehouse architecture
- Implement ETL pipelines across multiple layers
- Clean, standardize, and transform raw data
- Build a Star Schema for analytics
- Enable reporting and data-driven decision making

---

## 🏗️ Architecture

This project follows the **Medallion Architecture** with three layers:

| Layer | Color | Description |
|-------|-------|-------------|
| 🟤 Bronze | Raw | Data as-is from source systems |
| ⚪ Silver | Cleaned | Standardized and enriched data |
| 🟡 Gold | Business-Ready | Analytical models for reporting |

<img width="1207" height="755" alt="DWH Layers" src="https://github.com/user-attachments/assets/e109d84d-3949-415e-9f7d-82c107a27454" />

---

## 🔄 Data Flow

Data flows from two source systems (**CRM** and **ERP**) through three layers before reaching the reporting layer.


**Source Systems → Bronze → Silver → Gold → Reporting / Analytics**

<img width="1215" height="802" alt="Data Flow Diagram" src="https://github.com/user-attachments/assets/4549735d-629d-4680-9bbe-c712e876563d" />

---

## 🧩 Integration Model

The integration model shows how tables from CRM and ERP sources relate to each other and feed into the unified data warehouse.

<img width="1415" height="747" alt="Integration model" src="https://github.com/user-attachments/assets/d6a45b7f-a942-4060-b830-f0b6c6d0510f" />

---

## 🧱 Data Modeling — Star Schema

The Gold Layer is designed using a **Star Schema (Data Mart)**. In a star schema, the relationship between fact and dimension tables is **1 to many (1:N)**.

<img width="788" height="767" alt="Star Schema" src="https://github.com/user-attachments/assets/8496f4ff-83ec-454b-a35b-8808a7b70915" />


### Fact Table
- `fact_sales` — Sales & orders transaction details

### Dimension Tables
- `dim_customers` — Customer information (merged from CRM + ERP)
- `dim_products` — Product information (merged from CRM + ERP)

This structure enables efficient querying and supports BI tools like **Power BI**.

---

## ⚙️ ETL Process

### 🟤 Bronze Layer
- Stores raw data **as-is** from source systems (CRM & ERP CSV files)
- No transformations applied
- Full Load with Truncate & Insert
- Target Audience: Data Engineers

### ⚪ Silver Layer
- Data cleaning and standardization
- Handling missing/invalid values
- Data normalization & enrichment
- Derived columns
- Target Audience: Data Engineers & Data Analysts

### 🟡 Gold Layer
- Business logic implementation
- Data integration across CRM and ERP sources
- Creation of analytical **Views** (fact & dimensions)
- Data Aggregation
- Target Audience: Data Engineers & Data Analysts

---

## 📏 Design Standards

### 🔹 Naming Conventions

- `snake_case` for all objects
- English naming only
- Avoid SQL reserved keywords

### 🧱 Table Naming

| Layer | Format | Example |
|-------|--------|---------|
| Bronze | `<source>_<entity>` | `crm_sales_details` |
| Silver | `<source>_<entity>` | `erp_cust_info` |
| Gold | `<type>_<entity>` | `dim_customers` / `fact_sales` |

### 🧩 Column Naming

- **Surrogate Keys** → `<table>_key` &nbsp; (e.g., `customer_key`)
- **Technical Columns** → `dwh_<column>` &nbsp; (e.g., `dwh_load_date`)

---

## ⚙️ Stored Procedures

| Purpose | Naming |
|---------|--------|
| Load Bronze | `load_bronze` |
| Load Silver | `load_silver` |
| Load Gold | `load_gold` |

---

## 🧠 Key Skills Demonstrated

- SQL (Joins, Window Functions, CASE, COALESCE)
- Data Modeling (Star Schema)
- ETL Design
- Data Cleaning & Transformation
- Analytical Thinking

---

## 🚀 Business Value

This project shows how raw data can be transformed into:

- ✅ Actionable insights
- ✅ Structured reporting datasets
- ✅ Scalable analytics solutions

---

## 📂 Project Resources

- 📺 **Course Reference:** [Data With Baraa](https://www.youtube.com/@DataWithBaraa)
- 🗂️ **Project Planning (Notion):** [Data Warehouse Project](https://www.notion.so/Data-Warehouse-Project-2ddd5da8dfd28068997dd3e88ab2c7c6)

---

## 💡 Future Improvements

- Add incremental loading
- Implement Slowly Changing Dimensions (SCD)
- Connect to BI dashboard
- Optimize query performance
