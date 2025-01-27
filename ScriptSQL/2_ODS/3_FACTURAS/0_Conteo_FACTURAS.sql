/* Revision Tabla STG_FACTURAS_FCT */ 
USE STAGE; 
  
SELECT COUNT(*) TOTAL_REGISTROS, 
SUM(CASE WHEN LENGTH(TRIM(BILL_REF_NO)) <> 0 THEN 1 ELSE 0 END) TOTAL_BILL_REF_NO, 
COUNT(DISTINCT CASE WHEN LENGTH(TRIM(BILL_REF_NO)) <> 0 THEN BILL_REF_NO ELSE 0 END) TOTAL_DISTINTOS_BILL_REF_NO, 
SUM(CASE WHEN LENGTH(TRIM(CUSTOMER_ID)) <> 0 THEN 1 ELSE 0 END) TOTAL_CUSTOMER_ID, 
COUNT(DISTINCT CASE WHEN LENGTH(TRIM(CUSTOMER_ID)) <> 0 THEN CUSTOMER_ID ELSE 0 END) TOTAL_DISTINTOS_CUSTOMER_ID, 
SUM(CASE WHEN LENGTH(TRIM(START_DATE)) <> 0 THEN 1 ELSE 0 END) TOTAL_START_DATE, 
COUNT(DISTINCT CASE WHEN LENGTH(TRIM(START_DATE)) <> 0 THEN START_DATE ELSE 0 END) TOTAL_DISNTINTOS_START_DATE, 
SUM(CASE WHEN LENGTH(TRIM(END_DATE)) <> 0 THEN 1 ELSE 0 END) TOTAL_END_DATE, 
COUNT(DISTINCT CASE WHEN LENGTH(TRIM(END_DATE)) <> 0 THEN END_DATE ELSE 0 END) TOTAL_DISNTINTOS_END_DATE, 
SUM(CASE WHEN LENGTH(TRIM(STATEMENT_DATE)) <> 0 THEN 1 ELSE 0 END) TOTAL_STATEMENT_DATE, 
COUNT(DISTINCT CASE WHEN LENGTH(TRIM(STATEMENT_DATE)) <> 0 THEN STATEMENT_DATE ELSE 0 END) TOTAL_DISNTINTOS_STATEMENT_DATE, 
SUM(CASE WHEN LENGTH(TRIM(PAYMENT_DATE)) <> 0 THEN 1 ELSE 0 END) TOTAL_PAYMENT_DATE, 
COUNT(DISTINCT CASE WHEN LENGTH(TRIM(PAYMENT_DATE)) <> 0 THEN PAYMENT_DATE ELSE 0 END) TOTAL_DISNTINTOS_PAYMENT_DATE, 
SUM(CASE WHEN LENGTH(TRIM(BILL_CYCLE)) <> 0 THEN 1 ELSE 0 END) TOTAL_BILL_CYCLE, 
COUNT(DISTINCT CASE WHEN LENGTH(TRIM(BILL_CYCLE)) <> 0 THEN BILL_CYCLE ELSE 0 END) TOTAL_DISNTINTOS_BILL_CYCLE, 
SUM(CASE WHEN LENGTH(TRIM(AMOUNT)) <> 0 THEN 1 ELSE 0 END) TOTAL_AMOUNT, 
COUNT(DISTINCT CASE WHEN LENGTH(TRIM(AMOUNT)) <> 0 THEN AMOUNT ELSE 0 END) TOTAL_DISNTINTOS_AMOUNT, 
SUM(CASE WHEN LENGTH(TRIM(BILL_METHOD)) <> 0 THEN 1 ELSE 0 END) TOTAL_BILL_METHOD, 
COUNT(DISTINCT CASE WHEN LENGTH(TRIM(BILL_METHOD)) <> 0 THEN BILL_METHOD ELSE 0 END) TOTAL_DISNTINTOS_BILL_METHOD 
FROM STAGE.STG_FACTURAS_FCT; 