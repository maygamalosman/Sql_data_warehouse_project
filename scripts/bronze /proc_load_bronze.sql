/* 
====================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze )
====================================================================
Script Purpose :
This stored procedure loads data into the 'bronze schema from external CSV files.
it performs the following actions:
1-Truncate the bronze tables before loading data.
2-Uses the 'BULK INSERT' command to load data from csv files to bronze tables.

Parameters:
this stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze

===================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME,@batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
		SET	@batch_start_time = GETDATE();
		print('=========================');
		print('Loading bronze layer')
		print('=========================');
		print('Loading CRM Tables');
		print('=========================');

		SET @start_time= GETDATE();

		PRINT ('>> Truncating Table:bronze.crm_cust_info');
		TRUNCATE TABLE bronze.crm_cust_info
		PRINT ('>> Loading Table:bronze.crm_cust_info');

		BULK INSERT  bronze.crm_cust_info
		FROM "D:\SQL WITH BARAA\datasets\DW project\source_crm\cust_info.csv"
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR= ',' ,
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT('Load Duration = :' + CAST(DATEDIFF(Second,@start_time, @end_time) AS NVARCHAR)+'Seconds');

		print('=========================');


		SET @start_time= GETDATE();

		PRINT ('>> Truncating Table:bronze.crm_prd_info');
		TRUNCATE TABLE bronze.crm_prd_info
		PRINT ('>> Loading Table:bronze.crm_prd_info');
		BULK INSERT  bronze.crm_prd_info
		FROM "D:\SQL WITH BARAA\datasets\DW project\source_crm\prd_info.csv"
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR= ',' ,
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT('Load Duration = :' + CAST(DATEDIFF(Second,@start_time, @end_time) AS NVARCHAR)+'Seconds');

		print('=========================');

		SET @start_time= GETDATE();
		PRINT ('>> Truncating Table:bronze.crm_sales_details');
		TRUNCATE TABLE bronze.crm_sales_details

		PRINT ('>> Loading Table:bronze.crm_sales_details');
		BULK INSERT  bronze.crm_sales_details
		FROM "D:\SQL WITH BARAA\datasets\DW project\source_crm\sales_details.csv"
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR= ',' ,
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT('Load Duration = :' + CAST(DATEDIFF(Second,@start_time, @end_time) AS NVARCHAR)+'Seconds');

		print('=========================');
		print('Loading ERP Tables');
		print('=========================');


		SET @start_time= GETDATE();
		PRINT ('>> Truncating Table:bronze.erp_cust_az12');
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT ('>> Loading Table:bronze.erp_cust_az12');
		BULK INSERT  bronze.erp_cust_az12
		FROM "D:\SQL WITH BARAA\datasets\DW project\source_erp\CUST_AZ12.csv"
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR= ',' ,
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT('Load Duration = :' + CAST(DATEDIFF(Second,@start_time, @end_time) AS NVARCHAR)+'Seconds');

		print('=========================');

		SET @start_time= GETDATE();

		PRINT ('>> Truncating Table:bronze.erp_loc_a101');
		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT ('>> Loading Table:bronze.erp_loc_a101');

		BULK INSERT  bronze.erp_loc_a101
		FROM "D:\SQL WITH BARAA\datasets\DW project\source_erp\LOC_A101.csv"
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR= ',' ,
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT('Load Duration = :' + CAST(DATEDIFF(Second,@start_time, @end_time) AS NVARCHAR)+'Seconds');
		print('=========================');


		SET @start_time= GETDATE();

		PRINT ('>> Truncating Table:bronze.erp_px_cat_g1v2');
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		PRINT ('>> Loading Table:bronze.erp_px_cat_g1v2');
		BULK INSERT  bronze.erp_px_cat_g1v2
		FROM "D:\SQL WITH BARAA\datasets\DW project\source_erp\PX_CAT_G1V2.csv"
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR= ',' ,
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT('Load Duration = :' + CAST(DATEDIFF(Second,@start_time, @end_time) AS NVARCHAR)+'Seconds');
		PRINT ('===================================================');
		
		
		SET	@batch_end_time = GETDATE();

		PRINT('Total batch load duration = :' + CAST(DATEDIFF(Second,@batch_start_time, @batch_end_time) AS NVARCHAR)+'Seconds');
		

	END TRY

	BEGIN CATCH 
		PRINT ('===================================================');
		PRINT ('Error occured during loading bronze layer');
		PRINT ('Error message '+ error_message());
		PRINT ('Error message'+ cast (error_message() AS nvarchar));
		PRINT ('Error message'+ cast (error_state() AS nvarchar));
		PRINT ('===================================================');
	END CATCH 
END




EXEC bronze.load_bronze
