/*==============================================================*/
/* Table: PRODUCTS                                             */
/*==============================================================*/
CREATE TABLE           PRODUCTS (
   PRODUCT_REF         int                       NOT NULL,
   PRODUCT_NAME         NVARCHAR(40)                   NOT NULL,
   SUPPLIER_int      int                       NOT NULL,
   CATEGORY_CODE     	 int                       NOT NULL,
   QUANTITY            VARCHAR(30),
   UNIT_PRICE       	DECIMAL(10,2)           NOT NULL,
   UNITS_IN_STOCK        int,
   UNITS_ON_ORDER   	int,
   UNAVAILABLE	        int,
   CONSTRAINT PK_PRODUCTS  PRIMARY KEY (PRODUCT_REF)
  );
GO
ALTER TABLE PRODUCTS ADD CONSTRAINT FK_PRODUCTS_CATEGORIE 
FOREIGN KEY (CATEGORY_CODE) REFERENCES CATEGORIES (CATEGORY_CODE);
GO
ALTER TABLE PRODUCTS ADD CONSTRAINT FK_PRODUCTS_SUPPLIERS  
FOREIGN KEY (SUPPLIER_int) REFERENCES SUPPLIERS (SUPPLIER_int);