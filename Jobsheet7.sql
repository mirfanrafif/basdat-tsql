-- Soal no. 1
    SELECT
        productid, productname
    FROM Production.Products p
    WHERE p.categoryid = 4
UNION
    SELECT p.productid, p.productname
    FROM Production.Products p
        JOIN Sales.OrderDetails od
        ON p.productid = od.productid
    GROUP BY p.productid, p.productname
    HAVING
SUM(od.qty*od.unitprice) > 50000

--Soal no. 2
    SELECT
        productid, productname
    FROM Production.Products p
    WHERE p.categoryid = 4
UNION ALL
    SELECT p.productid, p.productname
    FROM Production.Products p
        JOIN Sales.OrderDetails od
        ON p.productid = od.productid
    GROUP BY p.productid, p.productname
    HAVING
SUM(od.qty*od.unitprice) > 50000

--Soal no. 3
--SKIP

--Soal no. 4
    SELECT *
    FROM
        (SELECT TOP 10
            ov.custid, c.contactname, ov.orderdate, ov.val
        FROM Sales.OrderValues as ov
            INNER JOIN Sales.Customers as c
            ON ov.custid = c.custid
        WHERE MONTH(ov.orderdate) = 01 AND YEAR(ov.orderdate)=2008
        ORDER BY ov.val DESC)
as a
UNION ALL
    SELECT *
    FROM (SELECT TOP 10
            ov.custid, c.contactname, ov.orderdate, ov.val
        FROM Sales.OrderValues as ov
            INNER JOIN Sales.Customers as c
            ON ov.custid = c.custid
        WHERE MONTH(ov.orderdate) = 02 AND YEAR(ov.orderdate)=2008
        ORDER BY ov.val DESC) as b

SELECT
    p.productid, p.productname, o.orderid
FROM Production.Products p
CROSS APPLY
(
    SELECT TOP 2
        d.orderid
    FROM Sales.OrderDetails as d
    WHERE d.productid = p.productid
    ORDER BY d.orderid DESC
) as o
ORDER BY p.productid


-- CREATE FUNCTION dbo.fnGetTop3ProductsForCustomer (@custid as INT)
-- RETURNS TABLE
-- AS RETURN
-- SELECT TOP 3
-- d.productid, p.productname, SUM(d.qty * d.unitprice) as totalsalesamount
-- FROM Sales.Orders as o
-- INNER JOIN Sales.OrderDetails as d ON d.orderid = o.orderid
-- INNER JOIN Production.Products as p ON d.productid = p.productid
-- WHERE custid = @custid
-- GROUP BY d.productid, p.productname
-- ORDER BY totalsalesamount DESC;
-- GO

--Soal no. 5
SELECT
    c.custid, c.contactname, p.productid, p.productname, p.totalsalesamount
FROM
    Sales.Customers as c
OUTER APPLY
dbo.fnGetTop3ProductsForCustomer (c.custid) as p
ORDER BY c.custid

--Soal no. 6
SELECT
    c.custid, c.contactname, p.productid, p.productname, p.totalsalesamount
FROM
    Sales.Customers as c
OUTER APPLY
dbo.fnGetTop3ProductsForCustomer (c.custid) as p
WHERE p.productid IS NULL
ORDER BY c.custid

DROP FUNCTION dbo.fnGetTop3ProductsForCustomer

--Soal no. 7
SELECT distinct
c.custid
FROM Sales.Orders as o
INNER JOIN Sales.Customers as c
on c.custid = o.custid
WHERE c.country = N'USA'
EXCEPT
SELECT o.custid FROM sales.Orders as o
INNER JOIN Sales.OrderDetails as d on d.orderid = o.orderid
GROUP by o.custid
HAVING COUNT(distinct d.productid) > 20


--Soal no. 8
SELECT c.custid FROM Sales.Customers as c
EXCEPT
SELECT o.custid FROM sales.Orders as o
INNER JOIN Sales.OrderDetails as d on d.orderid = o.orderid
GROUP by o.custid
HAVING COUNT(distinct d.productid) > 20
INTERSECT
SELECT o.custid
FROM Sales.Orders as o
INNER JOIN Sales.OrderDetails as d on d.orderid = o.orderid
GROUP by o.custid
HAVING sum(d.qty * d.unitprice) > 10000
