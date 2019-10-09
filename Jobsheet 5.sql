-- Soal no. 1
SELECT c.contactname, o.orderdate, p.productname
FROM Sales.Customers as c
inner JOIN Sales.Orders as o
ON c.custid = o.custid
inner JOIN Sales.OrderDetails as d
on  o.orderid = d.orderid
INNER JOIN Production.Products as p
on d.productid = p.productid
WHERE o.empid = 7
GROUP BY c.contactname, o.orderdate, p.productname;

-- Soal no. 2
SELECT c.contactname, o.orderdate, p.productname, o.shipname
FROM Sales.Customers as c
inner JOIN Sales.Orders as o
ON c.custid = o.custid
inner JOIN Sales.OrderDetails as d
on  o.orderid = d.orderid
INNER JOIN Production.Products as p
on d.productid = p.productid
WHERE o.empid = 7
GROUP BY c.contactname, o.orderdate, p.productname, o.shipname;

-- Soal no. 5
SELECT o.custid, MONTH(o.orderdate) as ordermonth, c.categoryname
FROM Sales.Orders as o
INNER JOIN Sales.OrderDetails as d
ON o.orderid =  d.orderid
INNER JOIN Production.Products as p
on d.productid = p.productid
INNER JOIN Production.Categories as c
ON p.categoryid = c.categoryid
WHERE o.empid = 7 
AND YEAR(o.orderdate) = '2006'
GROUP BY o.custid, c.categoryname, o.orderdate
ORDER BY ordermonth
;

--Soal no. 6
SELECT 
o.orderid, o.orderdate,
SUM(d.qty * d.unitprice) as totalsalesAmount,
COUNT(*) as orderLines,
AVG(d.qty * d.unitprice) as avgSalesAmount
FROM Sales.Orders as o
INNER JOIN Sales.OrderDetails as d
ON o.orderid = d.orderid
WHERE YEAR(o.orderdate) = '2008'
GROUP BY o.orderid, o.orderdate
ORDER BY totalsalesAmount desc
;

--Soal no. 7
SELECT
DATENAME(MONTH, o.orderdate) as ordermonth,
SUM(d.qty * d.unitprice) as totalAmountPerMonth
FROM Sales.Orders as o
INNER JOIN Sales.OrderDetails as d
ON o.orderid = d.orderid
WHERE YEAR(o.orderdate) = '2007'
GROUP BY DATENAME(MONTH, o.orderdate)
;

--Soal No. 8
SELECT
YEAR(orderdate) as orderyear,
COUNT(orderid) as nooforders,
COUNT(DISTINCT custid) as noofcustomers
from Sales.Orders
GROUP BY YEAR(orderdate)
;

--Soal no. 10
SELECT
c.categoryname, COUNT(DISTINCT o.orderid) AS nooforders,
SUM(d.qty*d.unitprice) as totalSalesAmount,
SUM(d.qty*d.unitprice)/COUNT(DISTINCT d.orderid) as avgSalesAmountPerOrder
FROM Production.Categories as c
INNER JOIN Production.Products as p
ON p.categoryid = c.categoryid
INNER JOIN Sales.OrderDetails as d
on d.productid = p.productid
INNER JOIN Sales.Orders as o
ON o.orderid = d.orderid
WHERE YEAR(o.orderdate) = '2008'
GROUP BY C.categoryname
;

--Soal no. 11
SELECT TOP 7
 o.custid,
 SUM(unitprice*qty) as totalSalesCount
FROM Sales.Orders as o
INNER JOIN Sales.OrderDetails as d
ON o.orderid = d.orderid
GROUP BY o.custid
HAVING SUM(unitprice*qty) > 30000
ORDER BY totalSalesCount DESC
;

--Soal no. 12
SELECT
o.custid,
MAX(o.orderdate) as lastorderdate,
SUM(unitprice*qty) as totalSalesCount
FROM Sales.Orders as o
INNER JOIN Sales.OrderDetails as d
ON o.orderid = d.orderid
GROUP BY o.custid
HAVING COUNT(DISTINCT o.orderid) > 15
;

--Soal no. 13
SELECT
orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderdate=(SELECT MAX(orderdate) FROM Sales.Orders)

--Soal no. 14
SELECT
c.contactname, o.orderid, o.orderdate, o.empid
FROM Sales.Orders as o
INNER JOIN Sales.Customers as c
ON o.custid = c.custid
WHERE c.custid IN (
    SELECT custid
    from Sales.Customers
    WHERE contactname LIKE N'O%'
)

--Soal no. 16
SELECT
productid, productname
FROM Production.Products AS p
WHERE productid IN (SELECT productid FROM Sales.OrderDetails as d WHERE qty > 115)


--Soal no. 17
SELECT
c.custid, c.contactname, c.city, c.country
from Sales.Customers as c
WHERE NOT EXISTS (SELECT o.orderid from Sales.Orders as o where o.custid = c.custid)

--Soal no. 18
SELECT
c.custid, c.contactname, (SELECT MAX(o.orderdate) FROM Sales.Orders as o where o.custid = c.custid) as lastorderdate
FROM Sales.Customers as c

--Soal no. 19
SELECT
c.custid, c.contactname
FROM Sales.Customers as c
WHERE EXISTS 
(SELECT * 
FROM Sales.Orders AS o 
INNER JOIN Sales.OrderDetails as d
ON o.orderid = d.orderid
WHERE o.custid = c.custid
AND d.unitprice > 260
AND o.orderdate > '20080201')
