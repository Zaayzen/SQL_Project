/*==============================================================*/
/* Table: ORDERS                                          */
/*==============================================================*/
CREATE TABLE            ORDERS  (
   ORDER_int           int                       NOT NULL,
   CUSTOMER_CODE          CHAR(5)                         NOT NULL,
   EMPLOYEE_int          int                       NOT NULL,
   ORDER_DATE	         DATE                            NOT NULL,
   SHIP_DATE          		DATE,
   SHIPPING_COST                DECIMAL(10,2),
   CONSTRAINT PK_ORDERS  PRIMARY KEY (ORDER_int)
    );
GO
ALTER TABLE ORDERS ADD CONSTRAINT FK_ORDERS_CUSTOMERS 
FOREIGN KEY (CUSTOMER_CODE) REFERENCES CUSTOMERS (CUSTOMER_CODE);
GO
ALTER TABLE ORDERS ADD CONSTRAINT FK_ORDERS_EMPLOYEES  
FOREIGN KEY (EMPLOYEE_int) REFERENCES EMPLOYEES (EMPLOYEE_int);