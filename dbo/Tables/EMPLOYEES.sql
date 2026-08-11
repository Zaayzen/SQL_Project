/*==============================================================*/
/* Table: EMPLOYEES                                             */
/*==============================================================*/
CREATE TABLE            EMPLOYEES (
   EMPLOYEE_int          int                       NOT NULL,
   REPORTS_TO         int,
   LAST_NAME                 NVARCHAR(40)                   NOT NULL,
   FIRST_NAME              NVARCHAR(30)                   NOT NULL,
   POSITION            VARCHAR(30)                    NOT NULL,
   TITLE               VARCHAR(5)                     NOT NULL,
   BIRTH_DATE      DATE                            NOT NULL,
   HIRE_DATE       DATE           NOT NULL,
   SALARY             DECIMAL(10,2)         NOT NULL,
   COMMISSION          DECIMAL(10,2),
   CONSTRAINT PK_EMPLOYEES PRIMARY KEY (EMPLOYEE_int)
  );
GO
ALTER TABLE EMPLOYEES  ADD CONSTRAINT FK_EMPLOYEES_EMPLOYES 
FOREIGN KEY (REPORTS_TO) REFERENCES EMPLOYEES (EMPLOYEE_int);