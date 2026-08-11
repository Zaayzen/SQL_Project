/*==============================================================*/
/* Table: CATEGORIES                                             */
/*==============================================================*/
CREATE TABLE            CATEGORIES  (
   CATEGORY_CODE       int                       NOT NULL,
   CATEGORY_NAME        VARCHAR(25)                    NOT NULL,
   DESCRIPTION          VARCHAR(100)                   NOT NULL,
   CONSTRAINT PK_CATEGORIES PRIMARY KEY (CATEGORY_CODE)
   );