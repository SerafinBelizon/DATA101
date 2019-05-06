/* Creacion de STAGE */ 
CREATE DATABASE STAGE; 
CREATE DATABASE ODS; 
CREATE DATABASE DDS; 
 
 
 
 /* Creacion de STAGE */ 
USE STAGE; 
 
DROP TABLE IF EXISTS  STG_CLIENTES_CRM; 
CREATE TABLE STG_CLIENTES_CRM AS 
SELECT * 
FROM CRM.CLIENTES; 
ANALYZE TABLE STG_CLIENTES_CRM; 
 
DROP TABLE IF EXISTS   STG_ORDERS_CRM; 
CREATE TABLE STG_ORDERS_CRM AS 
SELECT * 
FROM CRM.ORDERS; 
ANALYZE TABLE  STG_ORDERS_CRM; 
 
DROP TABLE IF EXISTS  STG_PRODUCTOS_CRM; 
CREATE TABLE STG_PRODUCTOS_CRM AS 
SELECT * 
FROM CRM.PRODUCTOS; 
ANALYZE TABLE STG_PRODUCTOS_CRM; 
 
DROP TABLE IF EXISTS  STG_FACTURAS_FCT; 
CREATE TABLE STG_FACTURAS_FCT AS 
SELECT * 
FROM FACTURADOR.FACTURAS; 
ANALYZE TABLE STG_FACTURAS_FCT; 
 
DROP TABLE IF EXISTS  STG_CONTACTOS_IVR; 
CREATE TABLE STG_CONTACTOS_IVR AS 
SELECT * 
FROM IVR.CONTACTOS; 
ANALYZE TABLE STG_CONTACTOS_IVR; 



/* CORRECCION DE ERRATAS */  
USE CRM; 
 
ALTER TABLE CRM.CLIENTES 
CHANGE COLUMN CUSTOMER_ID CUSTOMER_ID VARCHAR(512) NOT NULL, 
ADD PRIMARY KEY (CUSTOMER_ID); 
 
ALTER TABLE CRM.PRODUCTOS 
CHANGE COLUMN PRODUCT_ID PRODUCTO_ID VARCHAR(512) NOT NULL, 
ADD PRIMARY KEY (PRODUCTO_ID); 
  
     
USE FACTURADOR; 
  
ALTER TABLE FACTURADOR.FACTURAS 
CHANGE COLUMN BILL_REF_NO BILL_REF_NO VARCHAR(512) NOT NULL, 
ADD PRIMARY KEY (BILL_REF_NO); 
  
  
USE IVR; 
 
ALTER TABLE IVR.CONTACTOS 
CHANGE COLUMN ID ID VARCHAR(512) NOT NULL; 