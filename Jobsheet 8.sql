--Soal no. 1

SELECT
    orderid,
    orderdate,
    val,
    ROW_NUMBER()OVER(ORDER BY orderdate) as rowno
FROM
    Sales.OrderValues

--Soal no. 2
SELECT
    orderid,
    orderdate,
    val,
    ROW_NUMBER()OVER(ORDER BY orderdate) as rowno,
    RANK()OVER(ORDER BY orderdate) as rankno
FROM
    Sales.OrderValues

--Soal no. 3
--Rank akan memberikan nomor yang sama ketika value nya sama, sedangkan row number akan memberikan nomor baris yang tidak akan sama setiap barisnya

--Soal no. 4
SELECT
    orderid,
    orderdate,
    custid,
    val,
    RANK()OVER(PARTITION BY custid ORDER BY val DESC) as orderrankno
FROM
    Sales.OrderValues;

--Soal no. 5
SELECT
    custid,
    val,
    YEAR(orderdate) as orderyear,
    RANK()OVER(PARTITION BY custid, YEAR(orderdate) ORDER BY val DESC) as orderrankno
FROM
    Sales.OrderValues

--Soal no. 6
SELECT
    *
FROM
    (
    SELECT
        custid,
        val,
        YEAR(orderdate) as orderyear,
        RANK()OVER(
        PARTITION BY custid, 
        YEAR(orderdate) ORDER BY val DESC) as orderrankno
    FROM
        Sales.OrderValues
) AS OrderVal
WHERE orderrankno <= 2;

--Soal no. 7
WITH
    OrderRows
    AS
    (
        SELECT
            orderid,
            orderdate,
            val,
            ROW_NUMBER()OVER(ORDER BY orderid, orderdate) as rowno
        FROM
            Sales.OrderValues
    )

SELECT
    *
FROM
    OrderRows;

--Soal no. 8
WITH
    OrderRows
    AS
    (
        SELECT
            orderid,
            orderdate,
            val,
            ROW_NUMBER()OVER(ORDER BY orderid, orderdate) as rowno
        FROM
            Sales.OrderValues
    )
SELECT
    o.orderid,
    o.orderdate,
    o.val,
    op.val,
    (o.val - op.val) as valdiff
FROM
    OrderRows as o
    LEFT JOIN OrderRows as op
    ON o.rowno = op.rowno+1;

--Soal no. 9
WITH
    OrderRows
    AS
    (
        SELECT
            orderid,
            orderdate,
            val,
            LAG(val, 1)OVER(ORDER BY orderid, orderdate) as valprev,
            ROW_NUMBER()OVER(ORDER BY orderid, orderdate) as rowno
        FROM
            Sales.OrderValues
    )
SELECT
    o.orderid,
    o.orderdate,
    o.val,
    o.valprev,
    (o.val - o.valprev) as valdiff
FROM
    OrderRows as o;

--Soal no. 10
WITH
    SalesMonth2007
    as
    (
        SELECT
            MONTH(orderdate) as monthno,
            -- AVG(val) OVER(PARTITION BY orderdate)  AS avgsalesmonth,
            SUM(val) AS totalsalesmonth

        FROM
            Sales.OrderValues
        WHERE YEAR(orderdate) = 2007
        GROUP BY MONTH(orderdate)
    )
SELECT
    *
FROM
    SalesMonth2007;

--Soal no. 11
