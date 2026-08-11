/*==============================================================*/
/* Table: ORDER_DETAILS                                   */
/*==============================================================*/
CREATE TABLE            ORDER_DETAILS  (
   ORDER_int         INT                       NOT NULL,
   PRODUCT_REF         int                       NOT NULL,
   UNIT_PRICE          DECIMAL(10,2)             NOT NULL,
   QUANTITY            int                      NOT NULL,
   DISCOUNT              FLOAT                           NOT NULL,
   CONSTRAINT PK_DETAILS_ORDERS  PRIMARY KEY (ORDER_int , PRODUCT_REF )
  );
GO
ALTER TABLE ORDER_DETAILS ADD CONSTRAINT FK_ORDER_DETAILS_ORDERS 
FOREIGN KEY (ORDER_int) REFERENCES ORDERS (ORDER_int);
GO
ALTER TABLE ORDER_DETAILS ADD CONSTRAINT FK_ORDER_DETAILS_PRODUCTS   
FOREIGN KEY (PRODUCT_REF) REFERENCES PRODUCTS  (PRODUCT_REF);