/*
Script de déploiement pour SQL_Projet

Ce code a été généré par un outil.
Toute modification apportée à ce fichier peut entraîner un comportement incorrect et sera perdue en cas de
régénération du code.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "SQL_Projet"
:setvar DefaultFilePrefix "SQL_Projet"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l’exécution de script si le mode SQLCMD n’est pas pris en charge.
Pour réactiver le script après l’activation du mode SQLCMD, exécutez ce qui suit : 
DÉSACTIVER NOEXEC ; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Création de la base de données $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, OPERATION_MODE = READ_WRITE, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Création de Table [dbo].[CATEGORIES]...';


GO
CREATE TABLE [dbo].[CATEGORIES] (
    [CATEGORY_CODE] INT           NOT NULL,
    [CATEGORY_NAME] VARCHAR (25)  NOT NULL,
    [DESCRIPTION]   VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_CATEGORIES] PRIMARY KEY CLUSTERED ([CATEGORY_CODE] ASC)
);


GO
PRINT N'Création de Table [dbo].[CUSTOMERS]...';


GO
CREATE TABLE [dbo].[CUSTOMERS] (
    [CUSTOMER_CODE] CHAR (5)      NOT NULL,
    [COMPANY]       NVARCHAR (40) NOT NULL,
    [ADDRESS]       NVARCHAR (60) NOT NULL,
    [CITY]          VARCHAR (30)  NOT NULL,
    [POSTAL_CODE]   VARCHAR (10)  NOT NULL,
    [COUNTRY]       VARCHAR (15)  NOT NULL,
    [PHONE]         VARCHAR (24)  NOT NULL,
    [FAX]           VARCHAR (24)  NULL,
    CONSTRAINT [PK_CUSTOMERS] PRIMARY KEY CLUSTERED ([CUSTOMER_CODE] ASC)
);


GO
PRINT N'Création de Table [dbo].[EMPLOYEES]...';


GO
CREATE TABLE [dbo].[EMPLOYEES] (
    [EMPLOYEE_int] INT             NOT NULL,
    [REPORTS_TO]   INT             NULL,
    [LAST_NAME]    NVARCHAR (40)   NOT NULL,
    [FIRST_NAME]   NVARCHAR (30)   NOT NULL,
    [POSITION]     VARCHAR (30)    NOT NULL,
    [TITLE]        VARCHAR (5)     NOT NULL,
    [BIRTH_DATE]   DATE            NOT NULL,
    [HIRE_DATE]    DATE            NOT NULL,
    [SALARY]       DECIMAL (10, 2) NOT NULL,
    [COMMISSION]   DECIMAL (10, 2) NULL,
    CONSTRAINT [PK_EMPLOYEES] PRIMARY KEY CLUSTERED ([EMPLOYEE_int] ASC)
);


GO
PRINT N'Création de Table [dbo].[ORDER_DETAILS]...';


GO
CREATE TABLE [dbo].[ORDER_DETAILS] (
    [ORDER_int]   INT             NOT NULL,
    [PRODUCT_REF] INT             NOT NULL,
    [UNIT_PRICE]  DECIMAL (10, 2) NOT NULL,
    [QUANTITY]    INT             NOT NULL,
    [DISCOUNT]    FLOAT (53)      NOT NULL,
    CONSTRAINT [PK_DETAILS_ORDERS] PRIMARY KEY CLUSTERED ([ORDER_int] ASC, [PRODUCT_REF] ASC)
);


GO
PRINT N'Création de Table [dbo].[ORDERS]...';


GO
CREATE TABLE [dbo].[ORDERS] (
    [ORDER_int]     INT             NOT NULL,
    [CUSTOMER_CODE] CHAR (5)        NOT NULL,
    [EMPLOYEE_int]  INT             NOT NULL,
    [ORDER_DATE]    DATE            NOT NULL,
    [SHIP_DATE]     DATE            NULL,
    [SHIPPING_COST] DECIMAL (10, 2) NULL,
    CONSTRAINT [PK_ORDERS] PRIMARY KEY CLUSTERED ([ORDER_int] ASC)
);


GO
PRINT N'Création de Table [dbo].[PRODUCTS]...';


GO
CREATE TABLE [dbo].[PRODUCTS] (
    [PRODUCT_REF]    INT             NOT NULL,
    [PRODUCT_NAME]   NVARCHAR (40)   NOT NULL,
    [SUPPLIER_int]   INT             NOT NULL,
    [CATEGORY_CODE]  INT             NOT NULL,
    [QUANTITY]       VARCHAR (30)    NULL,
    [UNIT_PRICE]     DECIMAL (10, 2) NOT NULL,
    [UNITS_IN_STOCK] INT             NULL,
    [UNITS_ON_ORDER] INT             NULL,
    [UNAVAILABLE]    INT             NULL,
    CONSTRAINT [PK_PRODUCTS] PRIMARY KEY CLUSTERED ([PRODUCT_REF] ASC)
);


GO
PRINT N'Création de Table [dbo].[SUPPLIERS]...';


GO
CREATE TABLE [dbo].[SUPPLIERS] (
    [SUPPLIER_int] INT           NOT NULL,
    [COMPANY]      NVARCHAR (40) NOT NULL,
    [ADDRESS]      NVARCHAR (60) NOT NULL,
    [CITY]         VARCHAR (30)  NOT NULL,
    [POSTAL_CODE]  VARCHAR (10)  NOT NULL,
    [COUNTRY]      VARCHAR (15)  NOT NULL,
    [PHONE]        VARCHAR (24)  NOT NULL,
    [FAX]          VARCHAR (24)  NULL,
    CONSTRAINT [PK_SUPPLIERS] PRIMARY KEY CLUSTERED ([SUPPLIER_int] ASC)
);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_EMPLOYEES_EMPLOYES]...';


GO
ALTER TABLE [dbo].[EMPLOYEES]
    ADD CONSTRAINT [FK_EMPLOYEES_EMPLOYES] FOREIGN KEY ([REPORTS_TO]) REFERENCES [dbo].[EMPLOYEES] ([EMPLOYEE_int]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_ORDER_DETAILS_ORDERS]...';


GO
ALTER TABLE [dbo].[ORDER_DETAILS]
    ADD CONSTRAINT [FK_ORDER_DETAILS_ORDERS] FOREIGN KEY ([ORDER_int]) REFERENCES [dbo].[ORDERS] ([ORDER_int]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_ORDER_DETAILS_PRODUCTS]...';


GO
ALTER TABLE [dbo].[ORDER_DETAILS]
    ADD CONSTRAINT [FK_ORDER_DETAILS_PRODUCTS] FOREIGN KEY ([PRODUCT_REF]) REFERENCES [dbo].[PRODUCTS] ([PRODUCT_REF]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_ORDERS_CUSTOMERS]...';


GO
ALTER TABLE [dbo].[ORDERS]
    ADD CONSTRAINT [FK_ORDERS_CUSTOMERS] FOREIGN KEY ([CUSTOMER_CODE]) REFERENCES [dbo].[CUSTOMERS] ([CUSTOMER_CODE]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_ORDERS_EMPLOYEES]...';


GO
ALTER TABLE [dbo].[ORDERS]
    ADD CONSTRAINT [FK_ORDERS_EMPLOYEES] FOREIGN KEY ([EMPLOYEE_int]) REFERENCES [dbo].[EMPLOYEES] ([EMPLOYEE_int]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_PRODUCTS_CATEGORIE]...';


GO
ALTER TABLE [dbo].[PRODUCTS]
    ADD CONSTRAINT [FK_PRODUCTS_CATEGORIE] FOREIGN KEY ([CATEGORY_CODE]) REFERENCES [dbo].[CATEGORIES] ([CATEGORY_CODE]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_PRODUCTS_SUPPLIERS]...';


GO
ALTER TABLE [dbo].[PRODUCTS]
    ADD CONSTRAINT [FK_PRODUCTS_SUPPLIERS] FOREIGN KEY ([SUPPLIER_int]) REFERENCES [dbo].[SUPPLIERS] ([SUPPLIER_int]);


GO
/*
Modèle de script de post-déploiement							
--------------------------------------------------------------------------------------
 Ce fichier contient des instructions SQL qui seront ajoutées au script de compilation.		
 Utilisez la syntaxe SQLCMD pour inclure un fichier dans le script de post-déploiement.			
 Exemple :      :r .\monfichier.sql								
 Utilisez la syntaxe SQLCMD pour référencer une variable dans le script de post-déploiement.		
 Exemple :      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
SELECT * FROM EMPLOYEES;
GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Mise à jour terminée.';


GO
