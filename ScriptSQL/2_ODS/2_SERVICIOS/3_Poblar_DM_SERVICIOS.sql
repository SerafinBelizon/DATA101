/* Insertar Datos en Servicios */ 
USE ODS; 
 
INSERT INTO ODS_DM_PRODUCTOS (DE_PRODUCTO, FC_INSERT, FC_MODIFICACION) 
    SELECT DISTINCT UPPER(TRIM(PRODUCT_NAME)), NOW(), NOW() 
    FROM STAGE.STG_PRODUCTOS_CRM 
    WHERE TRIM(PRODUCT_NAME) <> ''; 
COMMIT; 
INSERT INTO ODS_DM_PRODUCTOS VALUES (99, 'DESCONOCIDO', NOW(), NOW()); 
INSERT INTO ODS_DM_PRODUCTOS VALUES (98, 'NO APLICA', NOW(), NOW()); 
COMMIT; 
 
INSERT INTO ODS_DM_CANALES (DE_CANAL, FC_INSERT, FC_MODIFICACION) 
    SELECT DISTINCT UPPER(TRIM(CHANNEL)), NOW(), NOW() 
    FROM STAGE.STG_PRODUCTOS_CRM 
    WHERE TRIM(CHANNEL) <> ''; 
COMMIT; 
INSERT INTO ODS_DM_CANALES VALUES (99, 'DESCONOCIDO', NOW(), NOW()); 
INSERT INTO ODS_DM_CANALES VALUES (98, 'NO APLICA', NOW(), NOW()); 
COMMIT; 