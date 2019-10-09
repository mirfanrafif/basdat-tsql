-- Soal No. 1 dan 2

-- DROP VIEW IF EXISTS Production.ProductsDairy

-- CREATE VIEW Production.ProductsDairy
-- AS
-- SELECT p.productid, p.productname, s.companyname as suppliername,
-- p.unitprice, p.discontinued
-- FROM Production.Products as p
-- INNER JOIN Production.Suppliers as s
-- ON p.supplierid = s.supplierid
-- WHERE p.categoryid = 4
-- ;

-- Menuju No. 3

-- CREATE VIEW Production.ProductsBeverages AS
-- SELECT
-- productid, productname, supplierid, unitprice, discontinued
-- FROM Production.Products
-- WHERE categoryid = 1

-- Soal No. 3

-- SELECT productid, productname
-- FROM Production.ProductsBeverages
-- WHERE supplierid = 1

-- Soal no. 4

-- ALTER VIEW Production.ProductsBeverages AS
-- SELECT TOP(100) PERCENT
-- productid, productname, supplierid, unitprice, discontinued
-- FROM Production.Products
-- WHERE categoryid = 1
-- ORDER BY productname

-- Soal no. 5

-- SELECT * FROM Production.ProductsBeverages

-- Soal no. 6
-- ALTER VIEW Production.ProductsBeverages
-- AS
    -- SELECT productid, productname, supplierid, unitprice, discontinued,
    -- CASE WHEN unitprice > 100 THEN N'High' ELSE N'Normal' END as pricetype
    -- FROM Production.Products
    -- WHERE categoryid = 1

-- Soal no. 8

SELECT productid, productname
FROM (
    SELECT productid, productname, supplierid, unitprice, discontinued,
    CASE WHEN unitprice > 100 THEN N'High' ELSE N'Normal' END as pricetype
    FROM Production.Products
    WHERE categoryid = 1
) as p
WHERE p.pricetype = N'High'

-- Soal no. 9
-- CREATE VIEW Sales.OrderTotals AS
--     SELECT o.custid, o.orderid,
--     SUM(d.qty * d.unitprice) as total
--     FROM Sales.Orders as o
--     INNER JOIN Sales.OrderDetails as d
--     ON o.orderid = d.orderid
--     GROUP BY o.custid, o.orderid


-- SELECT 
-- s.custid, SUM(s.total) as totalsalesamount,
-- AVG(s.total) as avgsalesamount
-- FROM Sales.OrderTotals as s
-- GROUP BY s.custid

--Soal no. 10


-- Soal no. 11
-- WITH ProductsBeverages as (
--     SELECT productid, productname, supplierid, unitprice, discontinued,
--     CASE WHEN unitprice > 100 THEN N'High' ELSE N'Normal' END as pricetype
--     FROM Production.Products
--     WHERE categoryid = 1
-- )
-- SELECT productid, productname
-- FROM ProductsBeverages
-- WHERE pricetype = N'High'

-- Soal no. 12
-- WITH CTEC2008 as (
--     SELECT custid, SUM(val) as salesamt2008
--     FROM Sales.OrderValues
--     WHERE YEAR(orderdate) = '2008'
--     GROUP BY custid
-- )
-- SELECT c.custid, contactname, c2.salesamt2008 FROM Sales.Customers as c
-- FULL JOIN CTEC2008 as c2
-- ON c2.custid = c.custid

--Soal no. 13
-- WITH CTEC2008 as (
--     SELECT custid, SUM(val) as salesamt2008
--     FROM Sales.OrderValues
--     WHERE YEAR(orderdate) = '2008'
--     GROUP BY custid
-- ), CTEC2007 as (
--     SELECT custid, SUM(val) as salesamt2007
--     FROM Sales.OrderValues
--     WHERE YEAR(orderdate) = '2007'
--     GROUP BY custid
-- )
-- SELECT c.custid, contactname, 
-- c2008.salesamt2008, c2007.salesamt2007,
-- (c2008.salesamt2008 / c2007.salesamt2007 * 100) as percentgrows
-- FROM Sales.Customers as c
-- FULL JOIN CTEC2008 as c2008
-- ON c2008.custid = c.custid
-- FULL JOIN CTEC2007 as c2007
-- ON c2007.custid = c.custid

--Soal no. 14
-- SELECT
-- custid, SUM(val)
-- FROM Sales.OrderValues
-- WHERE YEAR(orderdate) = '2007'
-- GROUP BY custid

-- Soal no. 15
-- CREATE FUNCTION dbo.fnGetSalesByCustomer 
-- (@orderyear AS INT) RETURNS TABLE
-- AS
-- RETURN
--     SELECT
--     custid, SUM(val) as totalsalesamount
--     FROM Sales.OrderValues
--     WHERE YEAR(orderdate) = '2007'
--     GROUP BY custid

--Soal no. 16
-- ALTER FUNCTION dbo.fnGetSalesByCustomer 
-- (@orderyear AS INT) RETURNS TABLE
-- AS
-- RETURN
--     SELECT
--     custid, SUM(val) as totalsalesamount
--     FROM Sales.OrderValues
--     WHERE YEAR(orderdate) = @orderyear
--     GROUP BY custid

--Soal no. 17
SELECT * FROM dbo.fnGetSalesByCustomer(2007)

--Soal no. 18
-- SELECT TOP 3
-- p.productid, p.productname, 
-- SUM(d.qty * d.unitprice) as totalsalesamount
-- FROM
-- Production.Products as p
-- INNER JOIN Sales.OrderDetails as d
-- ON d.productid = p.productid
-- INNER JOIN Sales.Orders as o
-- ON o.orderid = d.orderid
-- WHERE o.custid = 1
-- GROUP by p.productid, p.productname
-- ORDER BY totalsalesamount DESC

--Soal no. 19
-- CREATE FUNCTION dbo.fnGetTop3ProductsForCustomer
-- (@custid AS INT) RETURNS TABLE
-- AS
-- RETURN
-- SELECT TOP 3
-- p.productid, p.productname, 
-- SUM(d.qty * d.unitprice) as totalsalesamount
-- FROM
-- Production.Products as p
-- INNER JOIN Sales.OrderDetails as d
-- ON d.productid = p.productid
-- INNER JOIN Sales.Orders as o
-- ON o.orderid = d.orderid
-- WHERE o.custid = @custid
-- GROUP by p.productid, p.productname
-- ORDER BY totalsalesamount DESC

--Soal no. 20
SELECT * from dbo.fnGetTop3ProductsForCustomer(1) as p
