/*

-- Create database 'DataWarehouse'and schemas

Script purpose:

this script created a New database named 'Data Warehouse',before we start we used 
 MASTER database is a database BUILT-IN inside SQL server allow you to create another database

first step we double checked if we have an existed datawarehouse with the same name or not if so we will drop it 
nad creat the new database in additional to the three schemas within the database: 'bronze','silver','gold'.


Warning:
1- Running this script will drop the entire 'Datawarehouse' database if it exists.
2- All the data in the database will permanently deleted; proceed with caution 
and double ensure you have proper backup before running this script 



================================================================================================
*/
USE master;
GO 
--Drop and replace the 'DataWarehouse' database if exist

IF EXISTS (SELECT 1 FROM sys.database WHERE name = 'DataWarehouse')
BEGIN
      ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
      DROP  DATABASE 'DataWarehouse',

--Create the database  DataWarehouse;  
CREATE DATABASE DataWarehouse;
GO
USE DataWarehouse;
GO

-- Create schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
