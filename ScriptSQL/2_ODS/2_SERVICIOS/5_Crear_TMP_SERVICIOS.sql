/* Crear Tablas Temporales para Direcciones de SERVICIOS */ 
USE ODS; 
 
DROP TABLE IF EXISTS TMP_DIRECCIONES_SERVICIOS; 
CREATE TABLE TMP_DIRECCIONES_SERVICIOS AS 
SELECT DIR.ID_DIRECCION, 
DIR.DE_DIRECCION, 
DIR.DE_CP, 
CIU.DE_CIUDAD, 
CIU.DE_ESTADO, 
PAI.DE_PAIS 
FROM ODS.ODS_HC_DIRECCIONES DIR 
INNER JOIN ODS.ODS_DM_CIUDADES_ESTADOS CIU ON DIR.ID_CIUDAD_ESTADO = CIU.ID_CIUDAD_ESTADO 
INNER JOIN ODS.ODS_DM_PAISES PAI ON CIU.ID_PAIS = PAI.ID_PAIS; 
ANALYZE TABLE TMP_DIRECCIONES_SERVICIOS; 
 
CREATE TABLE TMP_DIRECCIONES_SERVICIOS2 AS 
SELECT PRODUCTOS.PRODUCTO_ID ID_PRODUCTO, 
DIR.ID_DIRECCION 
FROM STAGE.STG_PRODUCTOS_CRM PRODUCTOS 
INNER JOIN ODS.TMP_DIRECCIONES_SERVICIOS DIR ON 
CASE WHEN LENGTH(TRIM(PRODUCTOS.PRODUCT_ADDRESS)) <> 0 THEN UPPER(TRIM(PRODUCTOS.PRODUCT_ADDRESS)) ELSE 'DESCONOCIDO' END = DIR.DE_DIRECCION AND 
CASE WHEN LENGTH(TRIM(PRODUCTOS.PRODUCT_POSTAL_CODE)) <> 0 THEN UPPER(TRIM(PRODUCTOS.PRODUCT_POSTAL_CODE)) ELSE 99999 END = DIR.DE_CP AND 
CASE WHEN LENGTH(TRIM(PRODUCTOS.PRODUCT_CITY)) <> 0 THEN UPPER(TRIM(PRODUCTOS.PRODUCT_CITY)) ELSE 'DESCONOCIDO' END = DIR.DE_CIUDAD AND 
CASE WHEN LENGTH(TRIM(PRODUCTOS.PRODUCT_STATE)) <> 0 THEN UPPER(TRIM(PRODUCTOS.PRODUCT_STATE)) ELSE 'DESCONOCIDO' END = DIR.DE_ESTADO AND 
CASE WHEN LENGTH(TRIM(PRODUCTOS.PRODUCT_COUNTRY)) <> 0 THEN REPLACE(PRODUCTOS.PRODUCT_COUNTRY,'United States', 'US') ELSE 'DESCONOCIDO' END = DIR.DE_PAIS; 
ANALYZE TABLE TMP_DIRECCIONES_SERVICIOS2; 