-- Soal No. 6

SELECT
    c.custid, c.contactname, o.orderid
FROM Sales.Customers as c
    INNER JOIN Sales.Orders as o
    ON c.custid = o.custid
    ;


-- Soal No. 8

SELECT
    c.custid, c.contactname, o.orderid
FROM Sales.Customers as c
    INNER JOIN Sales.Orders as o
    ON c.custid = o.custid;

-- Soal no. 9

SELECT
    c.custid, c.contactname, o.orderid, d.productid, d.qty, d.unitprice
FROM Sales.Customers as c
    INNER JOIN Sales.Orders as o
    ON c.custid = o.custid
    INNER JOIN Sales.OrderDetails as d
    on d.orderid = o.orderid

-- Soal no. 11

SELECT
    e.empid, e.firstname, e.lastname, e.title, e.mgrid
FROM HR.Employees as e
;

-- Soal no. 13

SELECT
    e.empid, e.firstname, e.lastname, e.title, e.mgrid,
    m.firstname as mgrfirstname, m.lastname as mgrlastname
FROM HR.Employees as e, HR.Employees as m
WHERE e.mgrid = m.empid
;

-- Soal no. 16

SELECT c.custid, c.contactname,
    o.orderid
FROM Sales.Customers as c
    LEFT JOIN Sales.Orders as o
    ON c.custid = o.custid
;

-- Soal no. 20

-- SELECT
--     empid, firstname, lastname, calendardate
-- FROM HR.Employees
-- CROSS JOIN HR.Calendar
-- ;

-- Soal no. 23

SELECT
    custid, companyname, contactname, address, city, country, phone
FROM Sales.Customers
WHERE country = N'Brazil'
;

-- Soal no. 24

SELECT
    custid, companyname, contactname, address, city, country, phone
FROM Sales.Customers
WHERE country IN (N'Brazil', N'UK', N'USA')
;

-- Soal no. 26

SELECT
    custid, companyname, contactname, address, city, country, phone
FROM Sales.Customers
WHERE contactname LIKE 'A%'
;

-- Soal no. 27

SELECT
    c.custid, c.companyname, o.orderid
FROM Sales.Customers as c
    LEFT OUTER JOIN Sales.Orders as o
    on c.custid = o.custid AND c.city = 'Paris'
;

-- Soal no. 28

SELECT
    c.custid, c.companyname, o.orderid
FROM Sales.Customers as c
    LEFT OUTER JOIN Sales.Orders as o
    ON c.custid = o.custid
WHERE c.city = 'Paris'
;

-- Soal no. 30

SELECT c.custid, c.companyname
FROM Sales.Customers as c
    LEFT OUTER JOIN Sales.Orders as o
    ON c.custid = o.custid
WHERE o.custid is NULL;
;

-- Soal no. 32

SELECT
    c.custid, c.contactname, o.orderid, o.orderdate
FROM Sales.Customers as c
    JOIN Sales.Orders as o
    on c.custid = o.custid
WHERE o.orderdate>='2008/04/01'
;

-- Soal no. 34

SELECT
    e.empid, e.lastname, e.firstname, e.title, e.mgrid,
    m.lastname as mgrlastname, m.firstname
from HR.Employees as e
    INNER JOIN HR.Employees as m ON e.mgrid = m.empid
ORDER BY m.firstname
;

-- Soal no. 38

SELECT
    TOP 20
    orderid, orderdate
FROM Sales.Orders
ORDER BY orderdate;

-- Soal no. 39

SELECT
    orderid, orderdate
FROM Sales.Orders
ORDER BY orderdate DESC
OFFSET 0 ROWS
FETCH NEXT 20 ROWS ONLY
;

-- Soal no. 40

SELECT
    productname, unitprice
FROM Production.Products
ORDER BY unitprice
DESC
;

-- Soal no. 41

SELECT
    TOP 10 PERCENT
    productname, unitprice
FROM Production.Products
ORDER BY unitprice
DESC
;

-- Soal no. 43

SELECT
TOP 20
custid, orderid, orderdate
FROM Sales.Orders
ORDER BY orderdate, orderid
;

-- Soal no. 44

SELECT
custid, orderid, orderdate
FROM Sales.Orders
ORDER BY orderdate, orderid
OFFSET 20 ROWS
FETCH NEXT 20 ROWS ONLY
;