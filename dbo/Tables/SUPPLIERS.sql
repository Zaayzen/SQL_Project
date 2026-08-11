/*==============================================================*/
/* Table: SUPPLIERS                                          */
/*==============================================================*/
CREATE TABLE            SUPPLIERS  (
   SUPPLIER_int      int                       NOT NULL,
   COMPANY             NVARCHAR(40)                   NOT NULL,
   ADDRESS             NVARCHAR(60)                   NOT NULL,
   CITY               VARCHAR(30)                    NOT NULL,
   POSTAL_CODE         VARCHAR(10)                    NOT NULL,
   COUNTRY                VARCHAR(15)                    NOT NULL,
   PHONE          	 VARCHAR(24)                    NOT NULL,
   FAX                 VARCHAR(24),
   CONSTRAINT PK_SUPPLIERS PRIMARY KEY (SUPPLIER_int)
  );