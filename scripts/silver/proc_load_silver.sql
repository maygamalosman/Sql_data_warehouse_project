/*

Stored procedure: load silver layer (Bronze -> Silver) 

------------------------
------------------------

Script purpose:
 This stored procedure performs the  ETL (Extract ,Transform,Load)
  to populate the 'Silver 'Schema tables from the bronze' Schema.
Actions Performed:
-Truncates silver tables. 
-Insert transformed and cleand data from bronze into Silver tables.

Parameters: 
None.
This stored procedure does not accept any Parameters or return any values.

Usage example:
EXEC silver.load_silver;
--------------------------------------------
CREATE OR ALTER PROCEDURE  silver.load_silver AS

BEGIN 

	DECLARE @start_time DATETIME , @end_time DATETIME,@batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
		SET	@batch_start_time = GETDATE();
		print('=========================');
		print('Loading silver layer')
		print('=========================');
		print('Loading CRM Tables');
		print('=========================');

		SET @start_time= GETDATE();

    PRINT'>> truncating table: silver.crm_cust_info';
    TRUNCATE TABLE silver.crm_cust_info;
    PRINT '>> Inserting Data into :silver.crm_cust_info';

    INSERT INTO silver.crm_cust_info(
           cst_id
          ,cst_key
          ,cst_firstname
          ,cst_lastname
          ,cst_marital_status
          ,cst_gndr
          ,cst_create_date)
    SELECT 
    cst_id,
     cst_key,
    TRIM(cst_firstname) As cst_firstname,
    TRIM(cst_lastname)AS cst_lastname,

    CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
	     WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
	     ELSE 'n/a'
    END cst_marital_status,

    CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
	     WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
	     ELSE 'n/a'
    END cst_gndr,
    cst_create_date
    FROM (
    SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC ) AS flag_last
    FROM bronze.crm_cust_info
    WHERE cst_ID  IS NOT NULL
    )t
    WHERE  flag_last = 1 ;


		SET @end_time = GETDATE();
		PRINT('Load Duration = :' + CAST(DATEDIFF(Second,@start_time, @end_time) AS NVARCHAR)+'Seconds');

		print('=========================');


		SET @start_time= GETDATE();

    PRINT'>> truncating table: silver.crm_prd_info';
    TRUNCATE TABLE silver.crm_prd_info;
    PRINT '>> Inserting Data into :silver.crm_prd_info';

    INSERT INTO silver.crm_prd_info (
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
    )

    SELECT 
    prd_id,
    REPLACE (SUBSTRING(prd_key,1,5), '-' ,'_')  AS cat_id ,
    SUBSTRING(prd_key,7,len(prd_key))  AS prd_key ,
    prd_nm,
    ISNULL(prd_cost,0) AS prd_cost,
    CASE UPPER(TRIM(prd_line))
	     WHEN 'M' THEN 'Mountain'
	     WHEN 'R' THEN 'Road'
	     WHEN 'S' THEN 'Other Sales'
	     WHEN 'T' THEN 'Touring'
	     ELSE 'n/a'
    END AS prd_line,
    CAST (prd_start_dt AS DATE ) AS prd_start_dt ,
    CAST (LEAD (prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt
    FROM bronze.crm_prd_info;

        SET @end_time = GETDATE();
		PRINT('Load Duration = :' + CAST(DATEDIFF(Second,@start_time, @end_time) AS NVARCHAR)+'Seconds');

		print('=========================');

		SET @start_time= GETDATE();
    PRINT'>> truncating table: silver.crm_sales_details';
    TRUNCATE TABLE Silver.crm_sales_details;
    PRINT '>> Inserting Data into :silver.crm_sales_details';

    INSERT INTO Silver.crm_sales_details(
    sls_ord_num ,
    sls_prd_key ,
    sls_cust_id ,
    sls_order_dt ,
    sls_ship_dt ,
    sls_due_dt ,
    sls_sales ,
    sls_quantity ,
    sls_price 
    )SELECT sls_ord_num
          ,sls_prd_key
          ,sls_cust_id
          ,CASE 
                WHEN  sls_order_dt = 0 OR LEN (sls_order_dt) != 8 THEN NULL
                ELSE CAST( CAST (sls_order_dt AS VARCHAR)AS DATE )
          END AS sls_order_dt 
      
          ,CASE 
                WHEN  sls_ship_dt = 0 OR LEN (sls_ship_dt) != 8 THEN NULL
                ELSE CAST( CAST (sls_ship_dt AS VARCHAR)AS DATE )
     
         END AS sls_ship_dt
     
         ,CASE 
                WHEN  sls_due_dt = 0 OR LEN (sls_due_dt) != 8 THEN NULL
                ELSE CAST( CAST (sls_due_dt AS VARCHAR)AS DATE )
          END AS sls_due_dt,
    CASE WHEN sls_sales is NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
         Then sls_quantity * ABS(sls_price)
         ELSE sls_sales
    END AS  sls_sales,
    sls_quantity,
    CASE WHEN sls_price is NULL OR sls_price <=0
            THEN sls_sales/ NUllif (sls_quantity ,0)
          ELSE sls_price 
    END AS sls_price

    FROM bronze.crm_sales_details;

        SET @end_time = GETDATE();
		PRINT('Load Duration = :' + CAST(DATEDIFF(Second,@start_time, @end_time) AS NVARCHAR)+'Seconds');
		print('=========================');


        print('=========================');
		print('Loading ERP Tables');
		print('=========================');

		SET @start_time= GETDATE();

    PRINT'>> truncating table: silver.erp_cust_az12';
    TRUNCATE TABLE silver.erp_cust_az12;
    PRINT '>> Inserting Data into :silver.erp_cust_az12';

    INSERT INTO silver.erp_cust_az12(
    cid,
    bdate,
    gen
    )

    SELECT
    CASE WHEN cid LIKE  'NAS%' THEN SUBSTRING (cid,4,len(cid))
    ELSE cid
    END AS cid,
    CASE WHEN bdate <'1926-01-01' OR bdate > GETDATE() THEN NULL 
    ELSE bdate
    END AS bdate ,
    CASE WHEN UPPER(TRIM(gen)) IN ('MALE','M') THEN 'Male'
    WHEN UPPER(TRIM(gen)) IN ('FEMALE','F') THEN 'Female'
    ELSE 'n/a'
    END AS gen
    FROM bronze.erp_cust_az12;

        print('=========================');
        SET @end_time = GETDATE();
		PRINT('Load Duration = :' + CAST(DATEDIFF(Second,@start_time, @end_time) AS NVARCHAR)+'Seconds');
		print('=========================');

        SET @start_time= GETDATE();
    PRINT'>> truncating table: silver .erp_loc_a101';
    TRUNCATE TABLE SILVER.erp_loc_a101;
    PRINT '>> Inserting Data into :silver .erp_loc_a101';
    INSERT INTO SILVER.erp_loc_a101( 
    cid, cntry
    )
    SELECT REPLACE (cid,'-','') AS cid,
    CASE 
    WHEN TRIM(cntry) ='DE'  THEN 'Germany'
    WHEN TRIM(cntry) IN ('USA','US') THEN 'United states'
    WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
    ELSE TRIM(cntry)
    END AS cntry
    FROM bronze.erp_loc_a101;

        print('=========================');
        SET @end_time = GETDATE();
		PRINT('Load Duration = :' + CAST(DATEDIFF(Second,@start_time, @end_time) AS NVARCHAR)+'Seconds');
		print('=========================');
        SET @start_time= GETDATE();

    PRINT'>> truncating table: silver.erp_px_cat_g1v2';
    TRUNCATE TABLE silver.erp_px_cat_g1v2;
    PRINT '>> Inserting Data into :silver.erp_px_cat_g1v2';

    INSERT INTO silver.erp_px_cat_g1v2 (
    id,
    cat,
    subcat,
    maintenance 
    )

    SELECT
    id,
    cat,
    subcat,
    maintenance
    FROM bronze.erp_px_cat_g1v2;

        print('=========================');
        SET @end_time = GETDATE();
		PRINT('Load Duration = :' + CAST(DATEDIFF(Second,@start_time, @end_time) AS NVARCHAR)+'Seconds');
		print('=========================');
END TRY

	BEGIN CATCH 
		PRINT ('===================================================');
		PRINT ('Error occured during loading silver layer');
		PRINT ('Error message '+ error_message());
		PRINT ('Error message'+ cast (error_message() AS nvarchar));
		PRINT ('Error message'+ cast (error_state() AS nvarchar));
		PRINT ('===================================================');
	END CATCH 
END
