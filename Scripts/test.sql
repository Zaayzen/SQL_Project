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

--------1---------

SELECT 
    EMPLOYEE_int AS Num_e, 
    FIRST_NAME + ' ' + LAST_NAME AS Prenom_Nom, 
    DATEDIFF(YEAR, BIRTH_DATE, GETDATE()) AS Age, 
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS Anciennete 
FROM EMPLOYEES
WHERE TITLE IN ('Mr.', 'Dr.') AND (SALARY + ISNULL(COMMISSION, 0)) >= 8000
ORDER BY Anciennete DESC;

--------2---------

SELECT 
    PRODUCT_REF AS Num_Produit,
    PRODUCT_NAME AS Nom_Produit,
    SUPPLIER_int AS Num_Fournisseur,
    UNITS_ON_ORDER AS Unites_commandees,
    UNIT_PRICE AS Prix_Unitaire
FROM PRODUCTS 
WHERE QUANTITY LIKE '%bottle%'
    AND UPPER(SUBSTRING(PRODUCT_NAME, 3, 1)) = 'T'
    AND SUPPLIER_int IN (1, 2, 3)
    AND UNIT_PRICE BETWEEN 70 AND 200
    AND UNITS_ON_ORDER IS NOT NULL;

--------3---------

SELECT * FROM CUSTOMERS
WHERE CITY + COUNTRY + RIGHT(POSTAL_CODE, 3) = (SELECT CITY + COUNTRY + RIGHT(POSTAL_CODE, 3)
FROM SUPPLIERS WHERE SUPPLIER_int = 1);

--------4---------

SELECT
    o.ORDER_int AS [Numero_commande],
    CASE
        WHEN SUM(od.UNIT_PRICE * od.QUANTITY) BETWEEN 0 AND 2000       THEN 0
        WHEN SUM(od.UNIT_PRICE * od.QUANTITY) BETWEEN 2001 AND 10000   THEN 5
        WHEN SUM(od.UNIT_PRICE * od.QUANTITY) BETWEEN 10001 AND 40000  THEN 10
        WHEN SUM(od.UNIT_PRICE * od.QUANTITY) BETWEEN 40001 AND 80000  THEN 15
        ELSE 20
    END AS [Nouveau_taux_remise],
    CASE
        WHEN o.ORDER_int BETWEEN 10000 AND 10999
            THEN 'appliquer l''ancien taux de remise'
        ELSE 'appliquer le nouveau taux de remise'
    END AS [Note_application]
FROM ORDERS o
JOIN ORDER_DETAILS od ON o.ORDER_int = od.ORDER_int
WHERE o.ORDER_int BETWEEN 10998 AND 11003
GROUP BY o.ORDER_int;

--------5---------

SELECT DISTINCT 
    s.SUPPLIER_int AS Num_fournisseur,
    s.COMPANY AS Societe,
    s.ADDRESS AS Adresse,
    s.PHONE AS Tel
FROM SUPPLIERS s 
JOIN PRODUCTS p ON s.SUPPLIER_int = p.SUPPLIER_int
JOIN CATEGORIES c ON p.CATEGORY_CODE = c.CATEGORY_CODE
WHERE c.CATEGORY_NAME = 'Beverages';

--------6---------

SELECT c.CUSTOMER_CODE AS Code_client
FROM CUSTOMERS c 
WHERE c.CITY = 'Berlin' 
AND (
    SELECT COUNT(*) FROM ORDERS o 
    JOIN ORDER_DETAILS od ON o.ORDER_int = od.ORDER_int
    JOIN PRODUCTS p ON od.PRODUCT_REF = p.PRODUCT_REF
    JOIN CATEGORIES cat ON p.CATEGORY_CODE = cat.CATEGORY_CODE
    WHERE o.CUSTOMER_CODE = c.CUSTOMER_CODE AND cat.CATEGORY_NAME = 'Desserts'
) <= 1;

--------7---------

SELECT 
    c.CUSTOMER_CODE AS Num_client,
    c.COMPANY AS Societe,
    c.PHONE AS Tel,
    ISNULL(SUM(od.UNIT_PRICE * od.QUANTITY), 0) AS Montant_total,
    c.COUNTRY AS Pays
FROM CUSTOMERS c
LEFT JOIN ORDERS o 
    ON c.CUSTOMER_CODE = o.CUSTOMER_CODE
    AND o.ORDER_DATE BETWEEN '1998-04-01' AND '1998-04-30'
    AND DATEDIFF(DAY, 0, o.ORDER_DATE) % 7 = 0
LEFT JOIN ORDER_DETAILS od ON o.ORDER_int = od.ORDER_int
WHERE c.COUNTRY = 'France'
GROUP BY c.CUSTOMER_CODE, c.COMPANY, c.PHONE, c.COUNTRY;

--------8---------

SELECT 
    c.CUSTOMER_CODE AS Code_client,
    c.COMPANY AS Societe,
    c.PHONE AS Tel
FROM CUSTOMERS c 
WHERE NOT EXISTS(
    SELECT p.PRODUCT_REF 
    FROM PRODUCTS p 
    WHERE NOT EXISTS(
        SELECT 1 
        FROM ORDERS o 
        JOIN ORDER_DETAILS od ON o.ORDER_int = od.ORDER_int
        WHERE o.CUSTOMER_CODE = c.CUSTOMER_CODE
        AND od.PRODUCT_REF = p.PRODUCT_REF
    )
);

--------9---------

SELECT 
    c.CUSTOMER_CODE AS Code_client,
    COUNT(o.ORDER_int) AS Nb_commandes
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.CUSTOMER_CODE = o.CUSTOMER_CODE
WHERE c.COUNTRY = 'France'
GROUP BY c.CUSTOMER_CODE;

--------10---------

SELECT
    (SELECT COUNT(*) FROM ORDERS WHERE YEAR(ORDER_DATE) = 1996) AS [Commandes_1996],
    (SELECT COUNT(*) FROM ORDERS WHERE YEAR(ORDER_DATE) = 1997) AS [Commandes_1997],
    (SELECT COUNT(*) FROM ORDERS WHERE YEAR(ORDER_DATE) = 1997)
        - (SELECT COUNT(*) FROM ORDERS WHERE YEAR(ORDER_DATE) = 1996) AS [Difference];