/* Insertar Datos en ODS_HC_FACTURAS */ 
USE ODS; 
 
INSERT INTO ODS.ODS_HC_CLIENTES 
SELECT DISTINCT CUSTOMER_ID, 'DESCONOCIDO', 'DESCONOCIDO', '99-999-9999', 99, 999999, 9999999999, 
	'DESCONOCIDO', STR_TO_DATE('31/12/9999', '%d/%m/%Y'), 999, 999, NOW(), NOW() 
FROM STAGE.STG_FACTURAS_FCT FCT 
WHERE CUSTOMER_ID NOT IN 
(SELECT ID_CLIENTE 
FROM ODS.ODS_HC_CLIENTES); 
COMMIT; 

INSERT INTO ODS_HC_FACTURAS 
SELECT  
BILL_REF_NO AS ID_FACTURA, 
CLI.ID_CLIENTE, 
CASE WHEN LENGTH(TRIM(START_DATE)) <> 0 THEN DATE_FORMAT(START_DATE, '%Y-%m-%d') ELSE STR_TO_DATE('31/12/9999', '%d/%m/%Y') END FC_INICIO, 
    CASE WHEN LENGTH(TRIM(END_DATE)) <> 0 THEN DATE_FORMAT(END_DATE, '%Y-%m-%d') ELSE STR_TO_DATE('31/12/9999', '%d/%m/%Y') END FC_FIN, 
    CASE WHEN LENGTH(TRIM(STATEMENT_DATE)) <> 0 THEN DATE_FORMAT(STATEMENT_DATE, '%Y-%m-%d') ELSE STR_TO_DATE('31/12/9999', '%d/%m/%Y') END FC_ESTADO, 
    CASE WHEN LENGTH(TRIM(PAYMENT_DATE)) <> 0 THEN DATE_FORMAT(PAYMENT_DATE, '%Y-%m-%d') ELSE STR_TO_DATE('31/12/9999', '%d/%m/%Y') END FC_PAGO, 
    CYCL.ID_CICLO_FACTURACION, 
    METH.ID_METODO_PAGO, 
    CASE WHEN LENGTH(TRIM(AMOUNT)) <> 0 THEN TRIM(UPPER(AMOUNT)) ELSE 0 END CANTIDAD, 
    NOW(), 
    NOW() 
FROM STAGE.STG_FACTURAS_FCT 
INNER JOIN ODS.ODS_HC_CLIENTES CLI ON CASE WHEN LENGTH(TRIM(CUSTOMER_ID)) <> 0 THEN UPPER(TRIM(CUSTOMER_ID)) ELSE 'DESCONOCIDO' END = CLI.ID_CLIENTE 
    INNER JOIN ODS.ODS_DM_CICLOS_FACTURACION CYCL ON CASE WHEN LENGTH(TRIM(BILL_CYCLE)) <> 0 THEN UPPER(TRIM(BILL_CYCLE)) ELSE 'DESCONOCIDO' END = CYCL.DE_CICLO_FACTURACION 
    INNER JOIN ODS.ODS_DM_METODOS_PAGO METH ON CASE WHEN LENGTH(TRIM(BILL_METHOD)) <> 0 THEN UPPER(TRIM(BILL_METHOD)) ELSE 'DESCONOCIDO' END = METH.DE_METODO_PAGO; 
COMMIT; 
ANALYZE TABLE ODS_HC_FACTURAS; 