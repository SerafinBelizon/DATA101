/* Insertar Datos en Tabla HC_SERVICIOS */ 
USE ODS; 

/* Clientes no encontrados en ODS_HC_CLIENTES */
INSERT INTO ODS.ODS_HC_CLIENTES 
SELECT DISTINCT CUSTOMER_ID, 'DESCONOCIDO', 'DESCONOCIDO', '99-999-9999', 99, 999999, 9999999999, 
	'DESCONOCIDO', STR_TO_DATE('31/12/9999', '%d/%m/%Y'), 999, 999, NOW(), NOW() 
FROM STAGE.STG_PRODUCTOS_CRM PROD 
WHERE CUSTOMER_ID NOT IN 
(SELECT ID_CLIENTE 
FROM ODS.ODS_HC_CLIENTES); 
COMMIT; 

/* Poblar ODS_HC_SERVICIOS */
INSERT INTO ODS_HC_SERVICIOS 
SELECT  
PRODUCTO_ID AS ID_SERVICIO, 
    CASE WHEN LENGTH(TRIM(CUSTOMER_ID)) <> 0 THEN TRIM(UPPER(CUSTOMER_ID)) ELSE 'DESCONOCIDO' END ID_CLIENTE, 
    PRODUCTOS.ID_PRODUCTO, 
    CASE WHEN LENGTH(TRIM(ACCESS_POINT)) <> 0 THEN TRIM(UPPER(ACCESS_POINT)) ELSE 'DESCONOCIDO' END PUNTO_ACCESO, 
    CANALES.ID_CANAL, 
    CASE WHEN LENGTH(TRIM(AGENT_CODE)) <> 0 THEN TRIM(UPPER(AGENT_CODE)) ELSE 99999 END ID_AGENTE, 
    DIR.ID_DIRECCION, 
    CASE WHEN LENGTH(TRIM(START_DATE)) <> 0 THEN STR_TO_DATE(START_DATE, '%d/%m/%Y') ELSE STR_TO_DATE('31/12/9999', '%d/%m/%Y') END FC_INICIO, 
    CASE WHEN LENGTH(TRIM(INSTALL_DATE)) <> 0 THEN DATE_FORMAT(REPLACE(INSTALL_DATE, 'UTC', ''), '%Y-%m-%d') ELSE STR_TO_DATE('31/12/9999', '%d/%m/%Y') END FC_INSTALACION, 
    CASE WHEN LENGTH(TRIM(END_DATE)) <> 0 THEN DATE_FORMAT(REPLACE(END_DATE, 'UTC', ''), '%Y-%m-%d') ELSE STR_TO_DATE('31/12/9999', '%d/%m/%Y') END FC_FIN, 
    NOW(), 
    NOW() 
FROM STAGE.STG_PRODUCTOS_CRM PROD 
INNER JOIN ODS.ODS_HC_CLIENTES CLIENTES ON CASE WHEN LENGTH(TRIM(PROD.CUSTOMER_ID)) <> 0 THEN UPPER(TRIM(PROD.CUSTOMER_ID)) ELSE 'DESCONOCIDO' END = CLIENTES.ID_CLIENTE 
    INNER JOIN ODS.ODS_DM_PRODUCTOS PRODUCTOS ON CASE WHEN LENGTH(TRIM(PROD.PRODUCT_NAME)) <> 0 THEN UPPER(TRIM(PROD.PRODUCT_NAME)) ELSE 'DESCONOCIDO' END = PRODUCTOS.DE_PRODUCTO 
    INNER JOIN ODS.ODS_DM_CANALES CANALES ON CASE WHEN LENGTH(TRIM(PROD.CHANNEL)) <> 0 THEN UPPER(TRIM(PROD.CHANNEL)) ELSE 'DESCONOCIDO' END = CANALES.DE_CANAL 
    INNER JOIN ODS.TMP_DIRECCIONES_SERVICIOS2 DIR ON PROD.PRODUCTO_ID = DIR.ID_PRODUCTO; 
COMMIT; 
ANALYZE TABLE ODS_HC_CLIENTES; 
 
DROP TABLE IF EXISTS TMP_DIRECCIONES_CLIENTES; 
DROP TABLE IF EXISTS TMP_DIRECCIONES_CLIENTES2; 
COMMIT; 