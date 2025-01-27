/* Insertar Datos en Modelo SERVICIOS (Direcciones) */ 
USE ODS; 
 
INSERT INTO ODS_DM_PAISES (DE_PAIS, FC_INSERT, FC_MODIFICACION) 
SELECT DISTINCT UPPER(TRIM(PRODUCT_COUNTRY)) 
FROM STAGE.STG_PRODUCTOS_CRM PROD 
WHERE TRIM(PRODUCT_COUNTRY) <>'' AND 
TRIM(REPLACE(PROD.PRODUCT_COUNTRY, 'United States', 'US')) NOT IN 
(SELECT DE_PAIS 
FROM ODS.ODS_DM_PAISES); 
COMMIT; 
ANALYZE TABLE ODS_DM_PAISES; 
 
INSERT INTO ODS_DM_CIUDADES_ESTADOS (DE_CIUDAD, DE_ESTADO, ID_PAIS, FC_INSERT, FC_MODIFICACION) 
SELECT DISTINCT 
CASE WHEN LENGTH(PRODUCT_CITY) <> 0 THEN UPPER(TRIM(PRODUCT_CITY)) ELSE 'DESCONOCIDO' END, 
CASE WHEN LENGTH(PRODUCT_STATE) <> 0 THEN UPPER(TRIM(PRODUCT_STATE)) ELSE 'DESCONOCIDO' END, 
PAI.ID_PAIS, 
NOW(), 
NOW() 
FROM STAGE.STG_PRODUCTOS_CRM PROD 
INNER JOIN ODS.ODS_DM_PAISES PAI ON CASE WHEN TRIM(PRODUCT_COUNTRY) <> '' THEN UPPER(REPLACE(PRODUCT_COUNTRY, 'United States', 'US')) ELSE 'DESCONOCIDO' END = PAI.DE_PAIS 
WHERE NOT EXISTS 
(SELECT 1 
FROM ODS.ODS_DM_CIUDADES_ESTADOS CIU 
WHERE CASE WHEN LENGTH(PRODUCT_CITY) <> 0 THEN UPPER(TRIM(PRODUCT_CITY)) ELSE 'DESCONOCIDO' END = CIU.DE_CIUDAD AND  
CASE WHEN LENGTH(PRODUCT_STATE) <> 0 THEN UPPER(TRIM(PRODUCT_STATE)) ELSE 'DESCONOCIDO' END = CIU.DE_ESTADO AND 
PAI.ID_PAIS = CIU.ID_PAIS); 
COMMIT; 
ANALYZE TABLE ODS_DM_CIUDADES_ESTADOS; 
 
INSERT INTO ODS_HC_DIRECCIONES (DE_DIRECCION, DE_CP, ID_CIUDAD_ESTADO, FC_INSERT, FC_MODIFICACION) 
SELECT DISTINCT  
CASE WHEN TRIM(PRODUCT_ADDRESS) <> '' THEN UPPER(TRIM(PRODUCT_ADDRESS)) ELSE 'DESCONOCIDO' END DIRECCION, 
CASE WHEN LENGTH(TRIM(PRODUCT_POSTAL_CODE)) <> 0 THEN TRIM(PRODUCT_POSTAL_CODE) ELSE 99999 END CP, 
CIU.ID_CIUDAD_ESTADO,  
NOW(), 
NOW() 
FROM STAGE.STG_PRODUCTOS_CRM PROD 
INNER JOIN ODS.ODS_DM_PAISES PAI ON CASE WHEN TRIM(PRODUCT_COUNTRY) <> '' THEN UPPER(REPLACE(PRODUCT_COUNTRY, 'United States', 'US')) ELSE 'DESCONOCIDO' END = PAI.DE_PAIS 
INNER JOIN ODS.ODS_DM_CIUDADES_ESTADOS CIU ON CASE WHEN LENGTH(TRIM(PRODUCT_CITY)) <> 0 THEN UPPER(PRODUCT_CITY) ELSE 'DESCONOCIDO' END = CIU.DE_CIUDAD AND 
CASE WHEN LENGTH(TRIM(PRODUCT_STATE)) <> 0 THEN UPPER(PRODUCT_STATE) ELSE 'DESCONOCIDO' END = CIU.DE_ESTADO 
WHERE NOT EXISTS 
(SELECT 1 
FROM ODS.ODS_HC_DIRECCIONES DIR 
WHERE CASE WHEN TRIM(PRODUCT_ADDRESS) <> '' THEN UPPER(TRIM(PRODUCT_ADDRESS)) ELSE 'DESCONOCIDO' END = DIR.DE_DIRECCION AND 
CASE WHEN LENGTH(TRIM(PRODUCT_POSTAL_CODE)) <> 0 THEN TRIM(PRODUCT_POSTAL_CODE) ELSE 99999 END = DIR.DE_CP AND 
DIR.ID_CIUDAD_ESTADO = CIU.ID_CIUDAD_ESTADO); 
COMMIT; 
ANALYZE TABLE ODS_HC_DIRECCIONES;  