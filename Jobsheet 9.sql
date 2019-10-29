-- CREATE VIEW Sales.CustGroups
-- AS
-- SELECT
-- custid, CHOOSE(custid %3 + 1, N'A', N'B', N'C') as custgroup, country
-- FROM Sales.Customers

--Soal no. 1
SELECT *
FROM Sales.CustGroups


--Soal no. 2
SELECT country, [A], [B], [C]
FROM (
    SELECT country, custgroup
    FROM Sales.CustGroups
)as a
PIVOT(
    COUNT(custgroup) FOR custgroup IN ([A], [B], [C])
) as pvt
;

-- ALTER VIEW Sales.CustGroups AS
-- SELECT
-- custid, 
-- CHOOSE(custid %3 + 1, N'A', N'B', N'C') as custgroup, 
-- country, 
-- city, 
-- contactname
-- FROM Sales.Customers

--Soal no. 3
SELECT country, [A], [B], [C]
FROM (
    SELECT country, custgroup
    FROM Sales.CustGroups
)as a
PIVOT(
    COUNT(custgroup) FOR custgroup IN ([A], [B], [C])
) as pvt
;

--Soal no. 4
SELECT country, city, contactname, [A], [B], [C]
FROM (
    SELECT *
    FROM Sales.CustGroups
)as a
PIVOT(
    COUNT(custgroup) FOR custgroup IN ([A], [B], [C])
) as pvt
ORDER BY country
;

--Soal no. 5
WITH
    PivotCustGroups
    AS
    (
        SELECT
            custid, country, custgroup
        FROM Sales.CustGroups
    )
SELECT country, A, B, C
FROM (
    SELECT country, custgroup
    FROM PivotCustGroups
) as a
PIVOT(
    COUNT(custgroup) FOR custgroup IN ([A],[B],[C])
    ) as pvt

--Soal no. 6
-- Ya. Karena fungsi CTE dan view hampir sama. namun untuk kecepatan bekerja, saya lebih memilih CTE

--Soal no. 7
--Menggunakan CTE saat membuat pivot lebih mudah dimodifikasi karena tidak memerlukan alter, tetapi hanya mengganti query cte yang digunakan

--Soal no. 8
WITH
    SalesByCategory
    AS
    (
        SELECT
            o.custid,
            c.categoryname as category,
            od.qty * od.unitprice as SalesValue
        FROM Sales.Orders as o
            INNER JOIN Sales.OrderDetails as od ON od.orderid = o.orderid
            INNER JOIN Production.Products as p ON p.productid = od.productid
            INNER JOIN Production.Categories as c ON c.categoryid = p.categoryid
        WHERE YEAR(orderdate) = 2008
    )
SELECT *
FROM SalesByCategory
PIVOT (
    SUM(SalesValue) FOR category IN (Beverages, Condiments, Confections, [Dairy Products], [Grains/Cereals], [Meat/Poultry], Produce, Seafood)
) as p
ORDER BY custid

--Soal no. 9
-- CREATE VIEW Sales.PivotCustGroups AS
-- WITH PivotCustGroups AS (
--     SELECT 
--     custid,
--     country,
--     custgroup
--     FROM Sales.CustGroups
-- )
-- SELECT country, p.A, p.B, p.C FROM PivotCustGroups
-- PIVOT (COUNT(custid) FOR custgroup IN (A, B, C)) as p;

SELECT country, A, B, C
FROM Sales.PivotCustGroups
-- PIVOT (COUNT(custid) FOR custgroup IN (A, B, C)) as p;

--Soal no. 10
SELECT custgroup, country, numberofcustomer
FROM Sales.PivotCustGroups
UNPIVOT(numberofcustomer FOR custgroup IN([A], [B], [C])) as p

--Soal no. 11
SELECT
    country, city, COUNT(custid) as noofcustomers
FROM Sales.Customers
GROUP BY
GROUPING SETS((country, city), country, city, ())

--Soal no. 12
SELECT
    YEAR(orderdate) as orderyear,
    MONTH(orderdate) as ordermonth,
    DAY(orderdate) as orderday,
    SUM(val) as salesvalue
FROM Sales.OrderValues
GROUP BY CUBE(
    YEAR(orderdate), 
    MONTH(orderdate), 
    DAY(orderdate)
    )

--Soal no. 13
SELECT
    YEAR(orderdate) as orderyear,
    MONTH(orderdate) as ordermonth,
    DAY(orderdate) as orderday,
    SUM(val) as salesvalue
FROM Sales.OrderValues
GROUP BY ROLLUP(
    YEAR(orderdate), 
    MONTH(orderdate), 
    DAY(orderdate)
    )

--Soal no. 14
--Lebih cocok menggunakan rollup karena hasil yang dikeluarkan lebih tertata dengan baik, pengelompokan berdasarkan tanggal, bulan lalu tahun

--Soal no. 15
SELECT GROUPING_ID (YEAR(orderdate), MONTH(orderdate)) AS groupid,
    YEAR(orderdate) AS orderyear,
    MONTH(orderdate) AS ordermonth,
    SUM(val) AS salesvalue
FROM
    Sales.OrderValues
GROUP BY 
	ROLLUP (YEAR(orderdate), MONTH(orderdate))
ORDER BY groupid, orderyear, ordermonth;